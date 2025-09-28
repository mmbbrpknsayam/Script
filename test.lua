local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `test`,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "main",
        Icon = "nil"
    }
}

local Toggle9 = Tabs.Main:CreateToggle("MyToggle", {Title = "auto block", Default = false})

local blockEnabled = false
local Toggle9Interacted = false
local humConnections = {} -- store connections so we can disconnect later

Toggle9:OnChanged(function()
    if not Toggle9Interacted then
        Toggle9Interacted = true
        return
    end

    blockEnabled = not blockEnabled

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local workspace = game:GetService("Workspace")

    local LocalPlayer = Players.LocalPlayer
    local KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
    local RANGE = 13

    -- killer -> animId -> animData
    local TARGET_ANIM_BY_NAME = {
        ["c00lkidd"] = {
            ["18885909645"] = {}
        },
        ["JohnDoe"] = {
            ["105458270463374"] = {}
        },
        ["Noli"] = {
            ["106538427162796"] = {}
        },
        ["1x1x1x1"] = {
            ["83829782357897"] = {}
        },
        ["Slasher"] = {
            ["126355327951215"] = {delay = 0.3},
            ["121086746534252"] = {},
            ["126830014841198"] = {}
        }
    }

    local function fireSkill()
        local args = { "UseActorAbility", { buffer.fromstring("\"Block\"") } }
        ReplicatedStorage.Modules.Network.RemoteEvent:FireServer(unpack(args))
        print("Fired UseActorAbility")
    end

    local function hookHumanoid(humanoid, model)
        local targetAnims = TARGET_ANIM_BY_NAME[model.Name]
        if not targetAnims then return end

        -- cache HRPs
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetHRP = model:FindFirstChild("HumanoidRootPart")

        local function onAnim(track)
            if not blockEnabled then return end
            local anim = track.Animation
            local animId = anim and anim.AnimationId and tostring(anim.AnimationId):match("%d+")
            if animId and targetAnims[animId] then
                if myHRP and targetHRP then
                    local distance = (myHRP.Position - targetHRP.Position).Magnitude
                    if distance <= RANGE then
                        local animData = targetAnims[animId]
                        if animData.delay then
                            task.delay(animData.delay, fireSkill)
                        else
                            fireSkill()
                        end
                    end
                end
            end
        end

        -- hook Animator if possible (fires earlier)
        local animator = humanoid:FindFirstChildOfClass("Animator")
        local conn
        if animator then
            conn = animator.AnimationPlayed:Connect(onAnim)
        else
            conn = humanoid.AnimationPlayed:Connect(onAnim)
        end
        table.insert(humConnections, conn)
    end

    if blockEnabled then
        -- hook existing killers
        for _, killer in ipairs(KillersFolder:GetChildren()) do
            local hum = killer:FindFirstChildOfClass("Humanoid")
            if hum then
                hookHumanoid(hum, killer)
            end
        end

        -- hook new humanoids via DescendantAdded (better than WaitForChild(5))
        local descConn
        descConn = KillersFolder.DescendantAdded:Connect(function(desc)
            if not blockEnabled then
                descConn:Disconnect()
                return
            end
            if desc:IsA("Humanoid") then
                local model = desc.Parent
                if model and model:IsA("Model") then
                    hookHumanoid(desc, model)
                end
            end
        end)
        table.insert(humConnections, descConn)

        print("Auto block ON (optimized, no cooldown, instant killer hook).")
    else
        -- turn off: disconnect all connections
        for _, conn in ipairs(humConnections) do
            if conn and conn.Disconnect then
                conn:Disconnect()
            end
        end
        humConnections = {}
        print("Auto block OFF.")
    end
end)
