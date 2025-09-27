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

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
local RANGE = 13

local KillerData = {
    ["coolkid"] = "18885909645",
    ["JohnDoe"] = "105458270463374",
    ["Noli"] = "106538427162796",
    ["1x1x1x1"] = "138754221537146"
    ["Slasher"] = "126830014841198"
}

local function fireSkill()
    local args = {
        "UseActorAbility",
        {
            buffer.fromstring("\"Block\"")
        }
    }
    ReplicatedStorage.Modules.Network.RemoteEvent:FireServer(unpack(args))
    print("Fired UseActorAbility!")
end

local function hookHumanoid(humanoid, model, targetAnimId, killerName)
    humanoid.AnimationPlayed:Connect(function(track)
        local anim = track.Animation
        local animId = anim and anim.AnimationId and tostring(anim.AnimationId):match("%d+") or "UNKNOWN"

        if animId == targetAnimId then
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetPart = model:FindFirstChildWhichIsA("BasePart")
            if myHRP and targetPart then
                local distance = (myHRP.Position - targetPart.Position).Magnitude
                if distance <= RANGE then

                    if killerName == "JohnDoe" then
                        task.delay(0.3, fireSkill)
                    else
                        fireSkill()
                    end
                end
            end
        end
    end)
end

for killerName, animId in pairs(KillerData) do
    local killerModel = KillersFolder:FindFirstChild(killerName)
    if killerModel then
        local hum = killerModel:FindFirstChildOfClass("Humanoid")
        if hum then
            hookHumanoid(hum, killerModel, animId, killerName)
        end
    end
end

KillersFolder.ChildAdded:Connect(function(killer)
    local targetAnimId = KillerData[killer.Name]
    if targetAnimId then
        local hum = killer:WaitForChild("Humanoid", 5)
        if hum then
            hookHumanoid(hum, killer, targetAnimId, killer.Name)
        end
    end
end)
