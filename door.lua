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

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "ESP Door", Default = false})

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    espDoor = not espDoor

    -- Find all Door models in workspace
    local Doors = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Door" then
            table.insert(Doors, obj)
        end
    end

    -- Function to create highlight
    local function createHighlight(model)
        if not model:FindFirstChild("CustomHighlight") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "CustomHighlight"
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.FillColor = Color3.fromRGB(255, 191, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 191, 0)
            highlight.OutlineTransparency = 0
            highlight.Parent = model
        end
    end

    if espDoor then
        -- Add highlight to all existing doors
        for _, model in ipairs(Doors) do
            createHighlight(model)
        end

        -- Automatically highlight new doors added later
        workspace.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("Model") and descendant.Name == "Door" then
                createHighlight(descendant)
            end
        end)
    else
        -- Remove highlights
        for _, model in ipairs(Doors) do
            local hl = model:FindFirstChild("CustomHighlight")
            if hl then
                hl:Destroy()
            end
        end
    end
end)

local Slider = Tabs.Main:CreateSlider("Slider", {
    Title = "SpeedBoost",
    Description = "drag to set speedboost(this script doesnt have any bypass)",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character:SetAttribute("SpeedBoost", Value)
        print("Slider was changed:", Value)
    end
})

Tabs.Main:CreateButton{
    Title = "speed",
    Description = "speed",
    Callback = function()
        task.spawn(function()
            while true do
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    player.Character:SetAttribute("SpeedBoost", 40)
                end
                task.wait(0.1) -- wait 1 second before repeating
            end
        end)
    end
}
