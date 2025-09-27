local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `plant and zombie`,
    SubTitle = "V-0.1.1",
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
        Title = "Shop",
        Icon = "nil"
    }
}

local selectedSeeds = {}

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Seed",
    Description = "",
    Values = {"Cactus Seed", "Strawberry Seed", "Blueberry", "Pumpkin Seed", "Sunflower Seed", "Dragon Fruit Seed", "Eggplant Seed", "Watermelon Seed", "Cocotank Seed", "Carnivorous Plant Seed", "Mr Carrot Seed", "Tomatrio Seed"},
    Multi = true,
    Default = {},
})

MultiDropdown:OnChanged(function(Value)
    selectedSeeds = {}
    for SeedName, IsSelected in pairs(Value) do
        if IsSelected then
            table.insert(selectedSeeds, SeedName)
        end
    end
end)

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "Auto buy", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    BuyEnabled = not BuyEnabled

    if BuyEnabled then
        task.spawn(function()
            while BuyEnabled do
                for _, seed in ipairs(selectedSeeds) do
                    local args = {
                        {seed, "\a"}
                    }
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("BridgeNet2")
                        :WaitForChild("dataRemoteEvent")
                        :FireServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)

local selectedGears = {}

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Gear",
    Description = "",
    Values = {"Water Bucket", "Frost Grenade", "Banana Gun", "Frost Blower", "Carrot Launcher"},
    Multi = true,
    Default = {},
})

MultiDropdown:OnChanged(function(Value)
    selectedGears = {}
    for GearName, IsSelected in pairs(Value) do
        if IsSelected then
            table.insert(selectedGears, GearName)
        end
    end
end)

local Toggle3 = Tabs.Main:CreateToggle("MyToggle", {Title = "Auto buy", Default = false})

Toggle3:OnChanged(function()
    if not Toggle3Interacted then
        Toggle3Interacted = true
        return
    end

    BuyGearEnabled = not BuyGearEnabled

    if BuyGearEnabled then
        task.spawn(function()
            while BuyGearEnabled do
                for _, gear in ipairs(selectedGears) do
                    local args = {
                        {gear, " "}
                    }
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("BridgeNet2")
                        :WaitForChild("dataRemoteEvent")
                        :FireServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)
