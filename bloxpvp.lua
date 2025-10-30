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

local Slider = Tabs.Main:CreateSlider("Slider", {
    Title = "Hitbox",
    Description = "",
    Default = 1,
    Min = 1,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        for _, model in pairs(workspace.Characters:GetChildren()) do
            if model:FindFirstChild("HumanoidRootPart") and model.Name ~= LocalPlayer.Name then
                model.HumanoidRootPart.Size = Vector3.new(Value, Value, Value)
            end
        end
    end
})
