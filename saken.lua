local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `forsaken [ cheat ]`,
    SubTitle = "",
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
        -- Set the range limit for the aimbot (in studs)
        local AIMBOT_RANGE = 50  -- Change this value to adjust the range

        -- Function to find the nearest player within range
        local function getClosestPlayer()
            local closestPlayer = nil
            local shortestDist = AIMBOT_RANGE  -- Start with the range limit
            local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

            -- Loop through all players to find the closest one within range
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local dist = (player.Character.Head.Position - myPosition).Magnitude
                    -- Only consider players within the range
                    if dist < shortestDist then
                        shortestDist = dist
                        closestPlayer = player
                    end
                end
            end

            return closestPlayer
        end

        -- Function to aim the camera at the nearest player
        local function aimAtNearestPlayer()
            local closestPlayer = getClosestPlayer()

            if closestPlayer then
                -- Get the position of the nearest player
                local targetPosition = closestPlayer.Character.HumanoidRootPart.Position
                local myPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

                -- Set the camera's CFrame to focus on the nearest player
                local camera = game.Workspace.CurrentCamera
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
            end
        end

        -- Call the function to update the camera aim towards the nearest player
        while aimbotEnabled and wait(0) do  -- You can adjust the interval
            aimAtNearestPlayer()
        end
    end
end)

Tabs.Main:CreateButton({
    Title = "all generators",
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

Tabs.Main:CreateButton({
    Title = "enter generators",
    Description = "",
    Callback = function()
        task.spawn(function()
            while true do
                local generatorFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")
                for _, gen in ipairs(generatorFolder:GetChildren()) do
                    local remotes = gen:FindFirstChild("Remotes")
                    if remotes then
                        local rf = remotes:FindFirstChild("RF")
                        if rf and rf:IsA("RemoteFuction") then
                            pcall(function()
                                rf:InvokeServer()
                            end)
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})
