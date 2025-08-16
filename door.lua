local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `door-door Hub`,
    SubTitle = "discord(not ready)",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "Esp",
        Icon = "nil"
    }
}

-- Store Config
local player = game:GetService("Players").LocalPlayer
local inventory = player:WaitForChild("Inventory")
local sack = inventory:WaitForChild("Old Sack")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem")
local itemsFolder = workspace:WaitForChild("Items")

-- Dropdown setup
local selectedItems = {}

local MultiDropdown = Tabs.Main:CreateDropdown("StoreDropdown", {
    Title = "Select Items to Store",
    Description = "Choose items you want to auto store",
    Values = {
        "Log",
        "Coal",
        "Spear",
        "Rifle",
        "Rifle Ammo",
        "Revolver",
        "Revolver Ammo",
        "MedKit",
        "Bandage",
        "Item chest",
        "Iron Body",
        "Leather Body",
        "Fuel Canister",
        "Oil Barrel",
        "Chair",
        "Feather",
        "Metal Chair",
        "Bolt",
        "Broken Fan",
        "Broken Microwave",
        "Sheet Metal",
        "Tyre",
        "Old Car Engine",
        "Old Radio",
        "Cultist Prototype",
        "Washing Machine",
        "Morsel",
        "Cake",
        "Berry",
        "Carrot",
        "Steak",
        "Anvil Front",
        "Anvil Base",
        "Anvil Back",
        "Cultist Gem",
        "Gem of the Forest Fragment"
    },
    Multi = true,
    Default = {},
})

MultiDropdown:OnChanged(function(Value)
    selectedItems = {}
    for itemName, isSelected in pairs(Value) do
        if isSelected then
            table.insert(selectedItems, itemName)
        end
    end
end)

-- Toggle for auto-store loop
local autoStoreEnabled = false

local AutoStoreToggle = Tabs.Main:CreateToggle("AutoStoreToggle", {
    Title = "Auto Store (repeat 0.5s)",
    Default = false
})

AutoStoreToggle:OnChanged(function(state)
    autoStoreEnabled = state

    if autoStoreEnabled then
        task.spawn(function()
            while autoStoreEnabled do
                for _, item in ipairs(itemsFolder:GetChildren()) do
                    for _, wanted in ipairs(selectedItems) do
                        if item.Name == wanted then
                            local args = {sack, item}
                            remote:InvokeServer(unpack(args))
                        end
                    end
                end
                task.wait(0.5) -- repeat every 0.5 seconds
            end
        end)
    end
end)
