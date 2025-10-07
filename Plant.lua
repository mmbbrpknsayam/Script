local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `plant`,
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
        Title = "Shop",
        Icon = "nil"
    }
}

local selectedSeeds = {}

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Seed",
    Description = "",
    Values = {"Cactus Seed", "Strawberry Seed", "Pumpkin Seed", "Sunflower Seed", "Dragon Fruit Seed", "Eggplant Seed", "Watermelon Seed", "Grape Seed", "Cocotank Seed", "Carnivorous Plant Seed", "Mr Carrot Seed", "Tomatrio Seed", "Shroombino Seed", "Mango Seed"},
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
                        seed, true
                    }
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("Remotes")
                        :WaitForChild("BuyItem")
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
                        gear, true
                    }
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("Remotes")
                        :WaitForChild("BuyGear")
                        :FireServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)

local Tabs = {
    Main = Window:CreateTab{
        Title = "Setting",
        Icon = "nil"
    }
}

local placeId = game.PlaceId
local jobid = ""

Tabs.Main:CreateButton{
    Title = "Copy jobid",
    Description = "",
    Callback = function()
        local clipboardFunc = setclipboard or toclipboard
        if clipboardFunc then
            clipboardFunc(tostring(game.JobId))
            print("Copied Job ID:", game.JobId)
        else
            warn("Clipboard not supported on this executor.")
        end
    end
}

local Input = Tabs.Main:CreateInput("Input", {
    Title = "JobId",
    Default = "",
    Placeholder = "",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        jobid = Value
        print("Job ID set to:", jobid)
    end
})

Tabs.Main:CreateButton{
    Title = "Join Server",
    Description = "",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local instanceId = tostring(jobid)

        if instanceId ~= "" then
            TeleportService:TeleportToPlaceInstance(placeId, instanceId, game.Players.LocalPlayer)
        else
            warn("Invalid Job ID.")
        end
    end
}
