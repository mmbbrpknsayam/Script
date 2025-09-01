local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `forsaken`,
    SubTitle = "v1",
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
        Title = "Main",
        Icon = "nil"
    }
}

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "aimbot", Default = false})

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    aimbotEnabled = not aimbotEnabled

    if aimbotEnabled then

        local AIMBOT_RANGE = 50

        local function getClosestPlayer()
            local closestPlayer = nil
            local shortestDist = AIMBOT_RANGE
            local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local dist = (player.Character.Head.Position - myPosition).Magnitude

                    if dist < shortestDist then
                        shortestDist = dist
                        closestPlayer = player
                    end
                end
            end

            return closestPlayer
        end

        local function aimAtNearestPlayer()
            local closestPlayer = getClosestPlayer()

            if closestPlayer then

                local targetPosition = closestPlayer.Character.HumanoidRootPart.Position
                local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

                local camera = game.Workspace.CurrentCamera
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
            end
        end

        while aimbotEnabled and wait(0) do
            aimAtNearestPlayer()
        end
    end
end)

Tabs.Main:CreateButton({
    Title = "auto generators",
    Description = "",
    Callback = function()
        task.spawn(function()
            while true do
                local generatorFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")
                for _, gen in ipairs(generatorFolder:GetChildren()) do
                    local remotes = gen:FindFirstChild("Remotes")
                    if remotes then
                        local re = remotes:FindFirstChild("RE")
                        if re and re:IsA("RemoteEvent") then
                            pcall(function()
                                re:FireServer()
                            end)
                        end
                    end
                end
                task.wait(4)
            end
        end)
    end
})

Tabs.Main:CreateButton{
    Title = "inf stamina",
    Description = "",
    Callback = function()
        local staminagg = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
        staminagg.StaminaLossDisabled = true
    end
}

local staminaa = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)

local Slider = Tabs.Main:CreateSlider("Slider", {
    Title = "stamina bar",
    Description = "",
    Default = 100,
    Min = 100,
    Max = 10000,
    Rounding = 1,
    Callback = function(Value)
        staminaa.MaxStamina = Value
        staminaa.Stamina = Value
    end
})

Tabs.Main:CreateButton{
    Title = "1k stamina",
    Description = "",
    Callback = function()
        local staminaModule = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)

        staminaModule.MaxStamina = 1000
        staminaModule.Stamina = 1000
    end
}

local Tabs = {
    Main = Window:CreateTab{
        Title = "in-dev",
        Icon = "nil"
    }
}

local staminainput = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)

local Input = Tabs.Main:CreateInput("Input", {
    Title = "Stamina",
    Default = "",
    Placeholder = "",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        staminainput1 = Value
        print("staminainput1 :", staminainput1)
    end
})

Tabs.Main:CreateButton{
    Title = "apply stamina",
    Description = "",
    Callback = function()
        staminainput.MaxStamina = staminainput1
        staminainput.Stamina = math.min(staminainput1, staminainput.staminainput1)
        print("Stamina applied:", staminainput.Stamina, "/", staminainput.MaxStamina)
    end
}

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp survivor", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    espSurvivor = not espSurvivor

    local SurvivorFolder = workspace.Players.Survivors

    local function createHighlight(model)
        local highlight = Instance.new("Highlight")
        highlight.Name = "CustomHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = Color3.fromRGB(255, 191, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 191, 0)
        highlight.OutlineTransparency = 0
        highlight.Parent = model
    end

    if espSurvivor then

        for _, model in ipairs(SurvivorFolder:GetChildren()) do
            if model:IsA("Model") then
                createHighlight(model)
            end
        end

        SurvivorFolder.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                createHighlight(child)
            end
        end)
    else

        for _, model in ipairs(SurvivorFolder:GetChildren()) do
            local hl = model:FindFirstChild("CustomHighlight")
            if hl then
                hl:Destroy()
            end
        end
    end
end)

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp survivor", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    espSurvivor = not espSurvivor

    local SurvivorFolder = workspace.Players.Survivors

    local function createHighlight(model)
        local highlight = Instance.new("Highlight")
        highlight.Name = "CustomHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = Color3.fromRGB(255, 191, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 191, 0)
        highlight.OutlineTransparency = 0
        highlight.Parent = model
    end

    if espSurvivor then

        for _, model in ipairs(SurvivorFolder:GetChildren()) do
            if model:IsA("Model") then
                createHighlight(model)
            end
        end

        SurvivorFolder.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                createHighlight(child)
            end
        end)
    else

        for _, model in ipairs(SurvivorFolder:GetChildren()) do
            local hl = model:FindFirstChild("CustomHighlight")
            if hl then
                hl:Destroy()
            end
        end
    end
end)

local Toggle3 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp killer", Default = false})

Toggle3:OnChanged(function()
    if not Toggle3Interacted then
        Toggle3Interacted = true
        return
    end

    espKiller = not espKiller

    local KillerFolder = workspace.Players.Killers

    local function createHighlight(model)
        local highlight = Instance.new("Highlight")
        highlight.Name = "CustomHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(170, 0, 0)
        highlight.OutlineTransparency = 0
        highlight.Parent = model
    end

    if espKiller then

        for _, model in ipairs(KillerFolder:GetChildren()) do
            if model:IsA("Model") then
                createHighlight(model)
            end
        end

        KillerFolder.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                createHighlight(child)
            end
        end)
    else

        for _, model in ipairs(KillerFolder:GetChildren()) do
            local hl = model:FindFirstChild("CustomHighlight")
            if hl then
                hl:Destroy()
            end
        end
    end
end)

local Toggle4 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp item", Default = false})

local espVisuals = {}
local espConnections = {}

local selectedItem = {"BloxyCola", "Medkit"}

local function removeAllESP()
    for _, v in pairs(espVisuals) do
        if v and v.Parent then
            v:Destroy()
        end
    end
    espVisuals = {}

    for _, conn in pairs(espConnections) do
        if conn.Connected then
            conn:Disconnect()
        end
    end
    espConnections = {}

    local itemsFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")
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

            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

            local heartbeatConn = game:GetService("RunService").Heartbeat:Connect(function()
                if not espEnabled then return end
                if model.PrimaryPart then
                    local distance = (model.PrimaryPart.Position - humanoidRootPart.Position).Magnitude
                    textLabel.Text = string.format("%s (%d)", model.Name, math.floor(distance))
                end
            end)
            table.insert(espConnections, heartbeatConn)

            return
        end
    end
end

Toggle4:OnChanged(function()
    if not Toggle4Interacted then
        Toggle4Interacted = true
        return
    end

    espEnabled = not espEnabled

    local itemsFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")

    if espEnabled then
        for _, model in pairs(itemsFolder:GetChildren()) do
            highlightModel(model)
        end

        local conn = itemsFolder.ChildAdded:Connect(function(newModel)
            if espEnabled then
                highlightModel(newModel)
            end
        end)
        table.insert(espConnections, conn)
    else
        removeAllESP()
    end
end)
