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

local p = game:GetService("Players")
local l = p.LocalPlayer
local c = workspace:WaitForChild("Characters")

local function f(s)
	for _, model in pairs(c:GetChildren()) do
		if model:FindFirstChild("HumanoidRootPart") and model.Name ~= l.Name then
			model.HumanoidRootPart.Size = Vector3.new(s, s, s)
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
	Callback = function(x)
		v = x
		f(x)
	end
})

p.PlayerAdded:Connect(function(player)
	p.CharacterAdded:Connect(function(char)
		repeat task.wait() until char:FindFirstChild("HumanoidRootPart")
		if char.Name ~= l.Name then
			char.HumanoidRootPart.Size = Vector3.new(v, v, v)
		end
	end)
end)

f(x)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "Unbreakable", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    BuyEnabled = not BuyEnabled

    if BuyEnabled then
        workspace.Characters:FindFirstChild(LocalPlayer.Name):SetAttribute("UnbreakableAll", true)
	else
		workspace.Characters:FindFirstChild(LocalPlayer.Name):SetAttribute("UnbreakableAll", false)
	end
end)
