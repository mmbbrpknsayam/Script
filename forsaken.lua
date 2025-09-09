local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `forsaken`,
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
        -- Auto Generator Repair (clean version)
        local repairing = false
        local currentGen = nil
        local repairThread = nil
        local genConnections = {}

        local function stopAutoRepair()
            if repairThread then
                pcall(task.cancel, repairThread)
                repairThread = nil
            end
            repairing = false
            currentGen = nil
        end

        local function startAutoRepair(generator)
            stopAutoRepair()
            if not generator or not generator.Parent then return end

            local progress = generator:FindFirstChild("Progress")
            local remotes = generator:FindFirstChild("Remotes")
            if not (progress and progress:IsA("NumberValue")) then return end
            if not remotes then return end

            local re = remotes:FindFirstChild("RE")
            if not (re and re:IsA("RemoteEvent")) then return end

            currentGen = generator
            repairing = true

            local progressConn
            progressConn = progress:GetPropertyChangedSignal("Value"):Connect(function()
                if progress.Value >= 100 then
                    progressConn:Disconnect()
                    stopAutoRepair()
                end
            end)
            table.insert(genConnections, progressConn)

            repairThread = task.spawn(function()
                while repairing and currentGen == generator do
                    if progress.Value >= 100 then
                        stopAutoRepair()
                        break
                    end
                    task.wait(0.5) -- wait 3s before firing
                    if repairing and progress.Value < 100 then
                        pcall(function()
                            re:FireServer()
                        end)
                    end
                end
            end)
        end

        local function setupGenerator(gen)
            if not gen or not gen:IsA("Model") then return end
            if genConnections[gen] then return end

            local prompt
            local main = gen:FindFirstChild("Main")
            if main then
                prompt = main:FindFirstChildWhichIsA("ProximityPrompt", true) or main:FindFirstChild("Prompt")
            end
            if not prompt then
                prompt = gen:FindFirstChildWhichIsA("ProximityPrompt", true)
            end

            if prompt then
                local conn = prompt.Triggered:Connect(function()
                    local progress = gen:FindFirstChild("Progress")
                    if progress and progress.Value < 100 then
                        startAutoRepair(gen)
                    end
                end)
                table.insert(genConnections, conn)
                genConnections[gen] = true
            end
        end

        local generatorFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")
        for _, g in ipairs(generatorFolder:GetChildren()) do
            pcall(setupGenerator, g)
        end

        generatorFolder.ChildAdded:Connect(function(child)
            pcall(setupGenerator, child)
        end)
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
        Title = "esp",
        Icon = "nil"
    }
}

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp generator", Default = false})

Toggle2:OnChanged(function()
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    espGenerator = not espGenerator
    local connections = {}

    local function updateHighlight(generator, highlight)
        local numVal = generator:FindFirstChildWhichIsA("NumberValue")
        if numVal then
            if numVal.Value < 100 then
                highlight.FillColor = Color3.fromRGB(0, 0, 255)
                highlight.OutlineColor = Color3.fromRGB(0, 0, 127)
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(0, 170, 0)
            end
        end
    end

    local function createHighlight(generator)
        if generator:FindFirstChild("CustomHighlight") then return end
        if not generator:IsA("Model") then return end
        if generator.Name ~= "Generator" then return end

        local highlight = Instance.new("Highlight")
        highlight.Name = "CustomHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = generator

        updateHighlight(generator, highlight)

        local numVal = generator:FindFirstChildWhichIsA("NumberValue")
        if numVal then
            table.insert(connections, numVal:GetPropertyChangedSignal("Value"):Connect(function()
                updateHighlight(generator, highlight)
            end))
        end
    end

    local function applyToMap(map)
        -- Apply to all current generators
        for _, obj in ipairs(map:GetChildren()) do
            if obj.Name == "Generator" then
                createHighlight(obj)
            end
        end

        -- Listen for new generators in this map
        table.insert(connections, map.ChildAdded:Connect(function(child)
            if child.Name == "Generator" then
                createHighlight(child)
            end
        end))
    end

    if espGenerator then

        local function hookMap(map)
            if map.Name == "Map" then
                applyToMap(map)
            end
        end

        local ingame = workspace:WaitForChild("Map"):WaitForChild("Ingame")
        for _, child in ipairs(ingame:GetChildren()) do
            hookMap(child)
        end

        table.insert(connections, ingame.ChildAdded:Connect(hookMap))
    else

        for _, c in ipairs(connections) do
            c:Disconnect()
        end
        table.clear(connections)

        local currentMap = workspace:FindFirstChild("Map") and workspace.Map.Ingame:FindFirstChild("Map")
        if currentMap then
            for _, obj in ipairs(currentMap:GetChildren()) do
                if obj.Name == "Generator" then
                    local hl = obj:FindFirstChild("CustomHighlight")
                    if hl then
                        hl:Destroy()
                    end
                end
            end
        end
    end
end)

local Toggle3 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp survivor", Default = false})

Toggle3:OnChanged(function()
    if not Toggle3Interacted then
        Toggle3Interacted = true
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

local Toggle4 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp killer", Default = false})

Toggle4:OnChanged(function()
    if not Toggle4Interacted then
        Toggle4Interacted = true
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

local Tabs = {
    Main = Window:CreateTab{
        Title = "in-dev",
        Icon = "nil"
    }
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
    Title = "inf stamina",
    Description = "",
    Callback = function()
        local staminagg = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
        staminagg.StaminaLossDisabled = true
    end
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
