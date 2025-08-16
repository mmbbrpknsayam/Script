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
local selectedItem = {}
local autoStoreEnabled = false
local storeConnections = {}

-- Dropdown for selecting which items to auto-store
local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Item",
    Description = "Select items to auto-store",
    Values = {
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
        "Log", -- important one
        "Coal",
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
    selectedItem = {}
    for ItemName, IsSelected in pairs(Value) do
        if IsSelected then
            table.insert(selectedItem, ItemName)
        end
    end
end)

-- Toggle for auto-store
local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "Auto Store", Default = false})

-- Cleanup function for disconnecting
local function removeAllConnections()
    for _, conn in pairs(storeConnections) do
        if conn.Connected then
            conn:Disconnect()
        end
    end
    storeConnections = {}
end

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    autoStoreEnabled = not autoStoreEnabled

    if autoStoreEnabled then
        local player = game.Players.LocalPlayer
        local inventory = player:WaitForChild("Inventory")
        local sack = inventory:WaitForChild("Old Sack")

        local function tryStoreItem(item)
            -- Check if name matches selected
            for _, wanted in ipairs(selectedItem) do
                if item.Name == wanted then
                    local args = {sack, item}
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")
                        :WaitForChild("RequestBagStoreItem"):InvokeServer(unpack(args))
                end
            end
        end

        -- Check already existing items
        local itemBag = player:WaitForChild("ItemBag")
        for _, item in ipairs(itemBag:GetChildren()) do
            tryStoreItem(item)
        end

        -- Listen for new items being added
        local conn = itemBag.ChildAdded:Connect(function(item)
            if autoStoreEnabled then
                tryStoreItem(item)
            end
        end)
        table.insert(storeConnections, conn)

    else
        removeAllConnections()
    end
end)
