local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `Slap`,
    SubTitle = "[Premium]",
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
        Title = "Main",
        Icon = "nil"
    }
}

-- Store selected items
local selectedItem = {}

-- Create dropdown
local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Item",
    Description = "",
    Values = {"Apple", "Bandage", "Boba", "Bull's essence", "Cube of Ice", "Forcefield Crystal", "Frog Potion", "Lightning Potion", "Speed Potion", "Sphere of fury", "True Power"},
    Multi = true,
    Default = {},
})

-- Update selected items when changed
MultiDropdown:OnChanged(function(Value)
    selectedItem = {} -- Reset
    for ItemName, IsSelected in pairs(Value) do
        if IsSelected then
            table.insert(selectedItem, ItemName)
        end
    end
end)

-- ESP Toggle
local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp", Default = false})

local espVisuals = {}

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

            -- Check if the model's name is in the selected items
            for _, item in ipairs(selectedItem) do
                if model.Name == item then
                    -- Check if model already has Highlight
                    if model:FindFirstChildOfClass("Highlight") then return end

                    local highlight = Instance.new("Highlight")
                    highlight.Parent = model
                    highlight.Adornee = model
                    highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Yellow
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
                    textLabel.Text = "[" .. model.Name .. " - Distance: --]"

                    local basePart = model:FindFirstChildWhichIsA("BasePart")
                    if not basePart then return end

                    -- Attachments and beam
                    local objectAttachment = Instance.new("Attachment")
                    objectAttachment.Name = "ESPObjectAttachment"
                    objectAttachment.Parent = basePart

                    local playerAttachment = Instance.new("Attachment")
                    playerAttachment.Name = "ESPPlayerAttachment"
                    playerAttachment.Parent = humanoidRootPart

                    local beam = Instance.new("Beam")
                    beam.Attachment0 = objectAttachment
                    beam.Attachment1 = playerAttachment
                    beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
                    beam.Width0 = 0.1
                    beam.Width1 = 0.1
                    beam.FaceCamera = true
                    beam.LightInfluence = 0
                    beam.Transparency = NumberSequence.new(0.3)
                    beam.Parent = objectAttachment

                    -- Store visuals
                    table.insert(espVisuals, highlight)
                    table.insert(espVisuals, billboardGui)
                    table.insert(espVisuals, objectAttachment)
                    table.insert(espVisuals, playerAttachment)
                    table.insert(espVisuals, beam)

                    local heartbeatConn
                    heartbeatConn = game:GetService("RunService").Heartbeat:Connect(function()
                        if not espEnabled then
                            if heartbeatConn then heartbeatConn:Disconnect() end
                            return
                        end
                        local distance = (model:GetModelCFrame().Position - humanoidRootPart.Position).Magnitude
                        textLabel.Text = "[" .. model.Name .. " - Distance: " .. math.floor(distance) .. " studs]"
                    end)

                    return -- No need to continue checking if already highlighted
                end
            end
        end

        -- Initial ESP on models
        local itemsFolder = workspace:FindFirstChild("Items")
        if itemsFolder then
            for _, model in pairs(itemsFolder:GetChildren()) do
                highlightModel(model)
            end
        end

        -- Listen for new models being added
        if itemsFolder then
            itemsFolder.ChildAdded:Connect(function(newModel)
                if espEnabled then
                    highlightModel(newModel)
                end
            end)
        end
    else
        -- Turn off ESP visuals
        for _, v in pairs(espVisuals) do
            if v and v.Parent then
                v:Destroy()
            end
        end
        espVisuals = {}
    end
end)

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "slap aura", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    auraEnabled = not auraEnabled

    if auraEnabled then
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            -- Make sure the player has a character and torso
            if player.Character and player.Character:FindFirstChild("Torso") then
                -- Define the arguments for the FireServer function
                local args = {
                    [1] = player.Character.Torso
                }

                task.spawn(function()
                    while auraEnabled do
                        game:GetService("ReplicatedStorage").Events.Slap:FireServer(unpack(args))
                        task.wait(0.1)
                    end
                end)
            end
        end
    end
end)
