local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `blox fruit`,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "pvp",
        Icon = "nil"
    }
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Characters = workspace:WaitForChild("Characters")

local function appHit(size)
	for _, model in pairs(Characters:GetChildren()) do
		if model:FindFirstChild("HumanoidRootPart") and model.Name ~= LocalPlayer.Name then
			model.HumanoidRootPart.Size = Vector3.new(size, size, size)
		end
	end
end

local Slider = Tabs.Main:CreateSlider("Slider", {
	Title = "Hitbox",
	Description = "",
	Default = 1,
	Min = 1,
	Max = 200,
	Rounding = 1,
	Callback = function(Value)
		crHit = Value
		appHit(Value)
	end
})

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		repeat task.wait() until char:FindFirstChild("HumanoidRootPart")
		if char.Name ~= LocalPlayer.Name then
			char.HumanoidRootPart.Size = Vector3.new(crHit, crHit, crHit)
		end
	end)
end)

appHit(crHit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Toggle1= Tabs.Main:CreateToggle("MyToggle", {Title = "Unbreakable", Default = false})

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    Unbreakables = not Unbreakables

    if BuyEnabled then
        workspace.Characters:FindFirstChild(LocalPlayer.Name):SetAttribute("UnbreakableAll", true)
	else
		workspace.Characters:FindFirstChild(LocalPlayer.Name):SetAttribute("UnbreakableAll", false)
	end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "Water walk", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    Waterwalk = not Waterwalk

    if BuyEnabled then
        workspace.Characters:FindFirstChild(LocalPlayer.Name):SetAttribute("WaterWalking", true)
	else
		workspace.Characters:FindFirstChild(LocalPlayer.Name):SetAttribute("WaterWalking", false)
	end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function applySpeed(value)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = value
	end
end

local Slider = Tabs.Main:CreateSlider("Slider", {
	Title = "WalkSpeed",
	Description = "",
	Default = 100,
	Min = 1,
	Max = 300,
	Rounding = 1,
	Callback = function(Value)
		currentSpeed = Value
		applySpeed(Value)
	end
})

LocalPlayer.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid")
	task.wait(0.1)
	applySpeed(currentSpeed)
end)
