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
local workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local KillersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
local RANGE = 13

-- map killer model names to a list of animations
-- each animation can have an optional delay
local TARGET_ANIM_BY_NAME = {
    ["c00kidd"] = {
        {id = "18885909645"} -- no delay
    },
    ["JohnDoe"] = {
        {id = "105458270463374"}
    },
    ["Noli"] = {
        {id = "106538427162796"}
    },
    ["1x1x1x1"] = {
        {id = "83829782357897"}
    },
    ["Slasher"] = {
        {id = "126355327951215"},
        {id = "121086746534252"},
        {id = "126830014841198"}
    }
}

-- helper to fire the skill
local function fireSkill()
    local args = {
        "UseActorAbility",
        {
            buffer.fromstring("\"Block\"")
        }
    }
    ReplicatedStorage.Modules.Network.RemoteEvent:FireServer(unpack(args))
    print("Fired UseActorAbility")
end

-- hook a single humanoid
local function hookHumanoid(humanoid, model)
    humanoid.AnimationPlayed:Connect(function(track)
        local anim = track.Animation
        local animId = anim and anim.AnimationId and tostring(anim.AnimationId):match("%d+") or "UNKNOWN"
        local modelName = model.Name

        local targetAnims = TARGET_ANIM_BY_NAME[modelName]
        if targetAnims then
            for _, animData in ipairs(targetAnims) do
                if animId == animData.id then
                    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetPart = model:FindFirstChildWhichIsA("BasePart")
                    if myHRP and targetPart then
                        local distance = (myHRP.Position - targetPart.Position).Magnitude
                        if distance <= RANGE then
                            if animData.delay then
                                task.delay(animData.delay, fireSkill)
                            else
                                fireSkill()
                            end
                        end
                    end
                end
            end
        end
    end)
end

-- hook all existing killers
for _, killer in ipairs(KillersFolder:GetChildren()) do
    local hum = killer:FindFirstChildOfClass("Humanoid")
    if hum then
        hookHumanoid(hum, killer)
    end
end

-- hook new killers as they spawn
KillersFolder.ChildAdded:Connect(function(killer)
    local hum = killer:WaitForChild("Humanoid", 5)
    if hum then
        hookHumanoid(hum, killer)
    end
end)

print("Multi-animation killer script loaded (no cooldown).")
