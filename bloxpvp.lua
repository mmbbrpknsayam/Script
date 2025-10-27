local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `bfpvp`,
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

local Slider = Tabs.Main:CreateSlider("Slider", {
    Title = "hitbox",
    Description = "",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        workspace.Characters.ncqzqsuze2211.HumanoidRootPart.Size = Vector3.new(Value, Value, Value)
        print("Slider was changed:", Value)
    end
})
