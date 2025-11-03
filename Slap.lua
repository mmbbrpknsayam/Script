local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `MarbleHub`,
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "Main",
        Icon = "nil"
    }
}

local selectedItem = {}

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Item",
    Description = "",
    Values = {
        "Apple", "Bandage", "Boba", "Bull's essence", "Cube of Ice",
        "Forcefield Crystal", "Frog Potion", "Lightning Potion",
        "Speed Potion", "Sphere of fury", "True Power"
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

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "ESP", Default = false})

local espVisuals = {}
local espEnabled = false
local Toggle1Interacted = false

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

        local function createTextESP(model)
            if not model:IsA("Model") then return end
            if not model:FindFirstChildWhichIsA("BasePart") then return end

            -- Check if this model matches a selected item
            for _, item in ipairs(selectedItem) do
                if model.Name == item then
                    -- Create text above the model
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
                    textLabel.TextStrokeTransparency = 0.3
                    textLabel.TextSize = 8
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.Text = "[" .. model.Name .. " - Distance: --]"

                    table.insert(espVisuals, billboardGui)

                    local heartbeatConn
                    heartbeatConn = game:GetService("RunService").Heartbeat:Connect(function()
                        if not espEnabled then
                            if heartbeatConn then heartbeatConn:Disconnect() end
                            return
                        end
                        if not model.Parent then
                            billboardGui:Destroy()
                            if heartbeatConn then heartbeatConn:Disconnect() end
                            return
                        end
                        local distance = (model:GetModelCFrame().Position - humanoidRootPart.Position).Magnitude
                        textLabel.Text = "[" .. model.Name .. " - Distance: " .. math.floor(distance) .. " studs]"
                    end)
                end
            end
        end

        local itemsFolder = workspace:FindFirstChild("Items")
        if itemsFolder then
            for _, model in pairs(itemsFolder:GetChildren()) do
                createTextESP(model)
            end
        end

        if itemsFolder then
            itemsFolder.ChildAdded:Connect(function(newModel)
                if espEnabled then
                    createTextESP(newModel)
                end
            end)
        end
    else

        for _, v in pairs(espVisuals) do
            if v and v.Parent then
                v:Destroy()
            end
        end
        espVisuals = {}
    end
end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local selectedPlayers = {}
local auraEnabled = false
local Toggle2Interacted = false

local function getPlayerList()
    local playerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    return playerNames
end

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Select Players",
    Description = "Choose players to slap",
    Values = getPlayerList(),
    Multi = true,
    Default = {},
})

MultiDropdown:OnChanged(function(Value)
    selectedPlayers = {}
    for PlayerName, IsSelected in pairs(Value) do
        if IsSelected then
            table.insert(selectedPlayers, PlayerName)
        end
    end
end)

Players.PlayerAdded:Connect(function()
    MultiDropdown:SetValues(getPlayerList())
end)

Players.PlayerRemoving:Connect(function()
    MultiDropdown:SetValues(getPlayerList())
end)

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "Slap Aura", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    auraEnabled = not auraEnabled

    if auraEnabled then
        task.spawn(function()
            while auraEnabled do
                for _, player in pairs(Players:GetPlayers()) do
                    if table.find(selectedPlayers, player.Name) and player.Character and player.Character:FindFirstChild("Torso") then
                        local args = {
                            [1] = player.Character.Torso
                        }
                        ReplicatedStorage.Events.Slap:FireServer(unpack(args))
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)
