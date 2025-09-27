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
local TARGET_ANIM_ID = {
    "18885909645",
    "105458270463374",
    "106538427162796",
    "138754221537146",
    "126830014841198"
}
local RANGE = 13

-- helper to fire the skill
local function fireSkill()
    local args = {
        "UseActorAbility",
        {
            buffer.fromstring("\"Block\"")
        }
    }
    ReplicatedStorage.Modules.Network.RemoteEvent:FireServer(unpack(args))
    print("Fired UseActorAbility for animation", TARGET_ANIM_ID)
end

-- hook a single Humanoid
local function hookHumanoid(humanoid, model)
    humanoid.AnimationPlayed:Connect(function(track)
        local anim = track.Animation
        local animId = anim and anim.AnimationId and tostring(anim.AnimationId):match("%d+") or "UNKNOWN"

        if animId == TARGET_ANIM_ID then
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetPart = model:FindFirstChildWhichIsA("BasePart") -- use any part for distance
            if myHRP and targetPart then
                local distance = (myHRP.Position - targetPart.Position).Magnitude
                if distance <= RANGE then
                    fireSkill()
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
