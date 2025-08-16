local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `testing [gg]`,
    SubTitle = "w wave",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "esp",
        Icon = "nil"
    }
}

local selectedItem = {}
local espVisuals = {}
local espConnections = {}
local espEnabled = false

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Item",
    Description = "",
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
        "Log",
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
        "a",
        "a",
        "a",
        "a",
        "a",
        "a",
        "a",
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

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp", Default = false})

-- Full cleanup function
local function removeAllESP()
    -- Destroy everything we tracked
    for _, v in pairs(espVisuals) do
        if v and v.Parent then
            v:Destroy()
        end
    end
    espVisuals = {}

    -- Disconnect all events
    for _, conn in pairs(espConnections) do
        if conn.Connected then
            conn:Disconnect()
        end
    end
    espConnections = {}

    -- Safety wipe: remove ANY leftover ESP objects from items
    local itemsFolder = workspace:FindFirstChild("Items")
    if itemsFolder then
        for _, model in pairs(itemsFolder:GetChildren()) do
            for _, obj in pairs(model:GetChildren()) do
                if obj:IsA("BillboardGui") or obj:IsA("Highlight") then
                    obj:Destroy()
                end
            end
        end
    end
end

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    espEnabled = not espEnabled

    if espEnabled then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local function highlightModel(model)
            if not model:IsA("Model") then return end

            for _, item in ipairs(selectedItem) do
                if model.Name == item and not model:FindFirstChildOfClass("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = model
                    highlight.Adornee = model
                    highlight.FillColor = Color3.fromRGB(255, 255, 0)
                    highlight.FillTransparency = 0.4
                    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                    highlight.OutlineTransparency = 0.5

                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Parent = model
                    billboardGui.Adornee = model
                    billboardGui.Size = UDim2.new(0, 200, 0, 30)
                    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    billboardGui.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboardGui
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextSize = 8
                    textLabel.Text = string.format("%s (--)", model.Name)

                    table.insert(espVisuals, highlight)
                    table.insert(espVisuals, billboardGui)

                    local heartbeatConn = game:GetService("RunService").Heartbeat:Connect(function()
                        if not espEnabled then return end
                        local distance = (model:GetModelCFrame().Position - humanoidRootPart.Position).Magnitude
                        textLabel.Text = string.format("%s (%d)", model.Name, math.floor(distance))
                    end)
                    table.insert(espConnections, heartbeatConn)

                    return
                end
            end
        end

        local itemsFolder = workspace:FindFirstChild("Items")
        if itemsFolder then
            for _, model in pairs(itemsFolder:GetChildren()) do
                highlightModel(model)
            end

            local conn = itemsFolder.ChildAdded:Connect(function(newModel)
                if espEnabled then
                    highlightModel(newModel)
                end
            end)
            table.insert(espConnections, conn)
        end

    else
        removeAllESP()
    end
end)

local player = game:GetService("Players").LocalPlayer
local inventory = player:WaitForChild("Inventory")
local itemsFolder = workspace:WaitForChild("Items")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestBagStoreItem")

-- Dropdown setup
local selectedItems = {}

local MultiDropdown = Tabs.Main:CreateDropdown("StoreDropdown", {
    Title = "Item to Store",
    Description = "",
    Values = {
        "Log","Coal","Spear","Rifle","Rifle Ammo","Revolver","Revolver Ammo",
        "MedKit","Bandage","Item chest","Iron Body","Leather Body","Fuel Canister",
        "Oil Barrel","Chair","Feather","Metal Chair","Bolt","Broken Fan",
        "Broken Microwave","Sheet Metal","Tyre","Old Car Engine","Old Radio",
        "Cultist Prototype","Washing Machine","Morsel","Cake","Berry","Carrot",
        "Steak","Anvil Front","Anvil Base","Anvil Back","Cultist Gem",
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

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "Auto Store", Default = false})
local Toggle1Interacted = false
local autoStoreEnabled = false

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    autoStoreEnabled = not autoStoreEnabled

    if autoStoreEnabled then
        task.spawn(function()
            while autoStoreEnabled do
                -- dynamically find a sack
                local sack = inventory:FindFirstChild("Old Sack")
                    or inventory:FindFirstChild("Good Sack")
                    or inventory:FindFirstChild("Giant Sack")

                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

                if sack and root and #selectedItems > 0 then
                    -- find nearest item
                    local nearestItem
                    local nearestDist = math.huge

                    for _, item in ipairs(itemsFolder:GetChildren()) do
                        if table.find(selectedItems, item.Name) then
                            local pos
                            if item:IsA("Model") and item.PrimaryPart then
                                pos = item.PrimaryPart.Position
                            elseif item:IsA("BasePart") then
                                pos = item.Position
                            else
                                pos = item:GetModelCFrame().Position
                            end

                            local dist = (pos - root.Position).Magnitude
                            if dist < nearestDist then
                                nearestDist = dist
                                nearestItem = item
                            end
                        end
                    end

                    if nearestItem then
                        remote:InvokeServer(sack, nearestItem)
                    end
                end

                task.wait(0.05) -- fast repeat
            end
        end)
    end
end)

local player = game:GetService("Players").LocalPlayer
local Inventory = player:WaitForChild("Inventory")
local charactersFolder = workspace:WaitForChild("Characters")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject")

-- mob picker
local selectedMobs = {}
local MultiDropdown = Tabs.Main:CreateDropdown("MobDropdown", {
    Title = "Select Mobs",
    Values = {"Bunny", "Wolf", "Cultist", "Crossbow Cultist", "Juggernaut Cultist", "Mammoth", "Polar Bear", "Arctic Fox", "Alpha Wolf", "Bear", "Alpha Bear"},
    Multi = true,
    Default = {}
})
MultiDropdown:OnChanged(function(val)
    selectedMobs = {}
    for name, chosen in pairs(val) do
        if chosen then table.insert(selectedMobs, name) end
    end
end)

local autoHitEnabled = false
local Toggle3Interacted = false

local Toggle3 = Tabs.Main:CreateToggle("KillAuraToggle", {Title = "Kill", Default = false})

Toggle3:OnChanged(function()
    if not Toggle3Interacted then
        Toggle3Interacted = true
        return
    end

    autoHitEnabled = not autoHitEnabled

    if autoHitEnabled then
        task.spawn(function()
            while autoHitEnabled do
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")

                -- find axe quickly
                local axe = Inventory:FindFirstChild("Old Axe")
                    or Inventory:FindFirstChild("Good Axe")
                    or Inventory:FindFirstChild("Spear")

                -- no giant condition: just check inside
                if axe and root then
                    for _, inst in ipairs(charactersFolder:GetDescendants()) do
                        if inst:IsA("Model") and table.find(selectedMobs, inst.Name) then
                            pcall(function()
                                remote:InvokeServer(inst, axe, "11_7500899975", root.CFrame)
                            end)
                        end
                    end
                end

                task.wait(0.2)
            end
        end)
    end
end)
