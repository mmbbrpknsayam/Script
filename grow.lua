local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `banana [ beta ]`,
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

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "Auto Sell", Default = false})

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    AutoSellEnabled = not AutoSellEnabled

    if AutoSellEnabled then
        game:GetService("ReplicatedStorage").GameEvents.Sell_Inventory:FireServer()
    end
end)

local selectedSeeds = {}

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Seed",
    Description = "",
    Values = {"Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk"},
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
                    local args = {seed}
                    game:GetService("ReplicatedStorage").GameEvents.BuySeedStock:FireServer(unpack(args))
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
    Values = {"Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Lightning Rod", "Master Sprinkler", "Favorite Tool"},
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
                    local args = {gear}
                    game:GetService("ReplicatedStorage").GameEvents.BuyGearStock:FireServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)

local Tabs = {
    Main = Window:CreateTab{
        Title = "Crafting",
        Icon = "nil"
    }
}

Tabs.Main:CreateButton{
    Title = "select craft bean shard",
    Description = "",
    Callback = function()
        local args = {
            "SetRecipe",
            workspace:WaitForChild("UpdateService"):WaitForChild("BeanstalkEvent"):WaitForChild("Model"):WaitForChild("GiantCraftingWorkBench"),
            "GiantBeanstalkEventWorkbench",
            "Pet Shard GiantBean"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
    end
}

Tabs.Main:CreateButton{
    Title = "unselect craft bean shard",
    Description = "",
    Callback = function()
        local args = {
            "Cancel",
            workspace:WaitForChild("UpdateService"):WaitForChild("BeanstalkEvent"):WaitForChild("Model"):WaitForChild("GiantCraftingWorkBench"),
            "GiantBeanstalkEventWorkbench"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
    end
}

Tabs.Main:CreateButton{
    Title = "input material",
    Description = "",
    Callback = function()
        local args = {
            "InputItem",
            workspace:WaitForChild("UpdateService"):WaitForChild("BeanstalkEvent"):WaitForChild("Model"):WaitForChild("GiantCraftingWorkBench"),
            "GiantBeanstalkEventWorkbench",
            1,
            {
                ItemType = "Holdable",
                ItemData = {
                    UUID = "0"
                }
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))
    end
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "Bug",
        Icon = "nil"
    }
}

Tabs.Main:CreateButton{
    Title = "Back Beanstalk Event",
    Description = "",
    Callback = function()
        local BeanstalkEvent = game:GetService("ReplicatedStorage").Modules.UpdateService

        if BeanstalkEvent then
            BeanstalkEvent.Parent = workspace
        end
    end
}

Tabs.Main:CreateButton{
    Title = "Back Fairy Event",
    Description = "",
    Callback = function()
        local FairyEvent = game:GetService("ReplicatedStorage").Modules.UpdateService

        if FairyEvent then
            FairyEvent.Parent = workspace
        end
    end
}
