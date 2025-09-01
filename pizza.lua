local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `pizza place`,
    SubTitle = "",
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

Tabs.Main:CreateButton{
    Title = "Position",
    Description = "check console",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Print your current position
        local playerPosition = humanoidRootPart.Position
        print("You are at position: ", playerPosition)
    end
}

Tabs.Main:CreateButton{
    Title = "Take pizza",
    Description = "tween",
    Callback = function()
                -- Get the required services
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait() -- Wait for character to load
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Get the HumanoidRootPart

        -- Target position (change these coordinates to your desired position)
        local targetPosition = Vector3.new(64.37987518310547, 6.600000381469727, -8.49511432647705) -- Example position (X, Y, Z)

        -- Create the CFrame goal directly (use the new position)
        local targetCFrame = CFrame.new(targetPosition)

        -- Tween info (duration, easing style, and direction)
        local tweenInfo = TweenInfo.new(
            2, -- Duration of the tween in seconds
            Enum.EasingStyle.Linear, -- Easing style (Linear, Bounce, etc.)
            Enum.EasingDirection.InOut -- Easing direction (In, Out, InOut)
        )

        -- Goal for tween (target CFrame)
        local goal = {
            CFrame = targetCFrame
        }

        -- Create the tween
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

        -- Play the tween
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "Be cashier",
    Description = "tween",
    Callback = function()
                -- Get the required services
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait() -- Wait for character to load
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Get the HumanoidRootPart

        -- Target position (change these coordinates to your desired position)
        local targetPosition = Vector3.new(49.106937408447266, 3.800133228302002, 83.02983093261719) -- Example position (X, Y, Z)

        -- Create the CFrame goal directly (use the new position)
        local targetCFrame = CFrame.new(targetPosition)

        -- Tween info (duration, easing style, and direction)
        local tweenInfo = TweenInfo.new(
            2, -- Duration of the tween in seconds
            Enum.EasingStyle.Linear, -- Easing style (Linear, Bounce, etc.)
            Enum.EasingDirection.InOut -- Easing direction (In, Out, InOut)
        )

        -- Goal for tween (target CFrame)
        local goal = {
            CFrame = targetCFrame
        }

        -- Create the tween
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

        -- Play the tween
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "Be cooking",
    Description = "tween",
    Callback = function()
                -- Get the required services
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait() -- Wait for character to load
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Get the HumanoidRootPart

        -- Target position (change these coordinates to your desired position)
        local targetPosition = Vector3.new(36.846946716308594, 3.800133228302002, 53.98762893676758) -- Example position (X, Y, Z)

        -- Create the CFrame goal directly (use the new position)
        local targetCFrame = CFrame.new(targetPosition)

        -- Tween info (duration, easing style, and direction)
        local tweenInfo = TweenInfo.new(
            2, -- Duration of the tween in seconds
            Enum.EasingStyle.Linear, -- Easing style (Linear, Bounce, etc.)
            Enum.EasingDirection.InOut -- Easing direction (In, Out, InOut)
        )

        -- Goal for tween (target CFrame)
        local goal = {
            CFrame = targetCFrame
        }

        -- Create the tween
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

        -- Play the tween
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "Be pizza boxer",
    Description = "tween",
    Callback = function()
                -- Get the required services
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait() -- Wait for character to load
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Get the HumanoidRootPart

        -- Target position (change these coordinates to your desired position)
        local targetPosition = Vector3.new(59.498779296875, 3.799999713897705, 12.086231231689453) -- Example position (X, Y, Z)

        -- Create the CFrame goal directly (use the new position)
        local targetCFrame = CFrame.new(targetPosition)

        -- Tween info (duration, easing style, and direction)
        local tweenInfo = TweenInfo.new(
            2, -- Duration of the tween in seconds
            Enum.EasingStyle.Linear, -- Easing style (Linear, Bounce, etc.)
            Enum.EasingDirection.InOut -- Easing direction (In, Out, InOut)
        )

        -- Goal for tween (target CFrame)
        local goal = {
            CFrame = targetCFrame
        }

        -- Create the tween
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

        -- Play the tween
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "Be pizza delivery",
    Description = "tween",
    Callback = function()
                -- Get the required services
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait() -- Wait for character to load
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Get the HumanoidRootPart

        -- Target position (change these coordinates to your desired position)
        local targetPosition = Vector3.new(65.29915618896484, 3.799999713897705, -15.989310264587402) -- Example position (X, Y, Z)

        -- Create the CFrame goal directly (use the new position)
        local targetCFrame = CFrame.new(targetPosition)

        -- Tween info (duration, easing style, and direction)
        local tweenInfo = TweenInfo.new(
            2, -- Duration of the tween in seconds
            Enum.EasingStyle.Linear, -- Easing style (Linear, Bounce, etc.)
            Enum.EasingDirection.InOut -- Easing direction (In, Out, InOut)
        )

        -- Goal for tween (target CFrame)
        local goal = {
            CFrame = targetCFrame
        }

        -- Create the tween
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

        -- Play the tween
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "Be Supplier",
    Description = "tween",
    Callback = function()
                -- Get the required services
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait() -- Wait for character to load
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- Get the HumanoidRootPart

        -- Target position (change these coordinates to your desired position)
        local targetPosition = Vector3.new(6.675780296325684, 12.999999046325684, -1022.7083740234375) -- Example position (X, Y, Z)

        -- Create the CFrame goal directly (use the new position)
        local targetCFrame = CFrame.new(targetPosition)

        -- Tween info (duration, easing style, and direction)
        local tweenInfo = TweenInfo.new(
            2, -- Duration of the tween in seconds
            Enum.EasingStyle.Linear, -- Easing style (Linear, Bounce, etc.)
            Enum.EasingDirection.InOut -- Easing direction (In, Out, InOut)
        )

        -- Goal for tween (target CFrame)
        local goal = {
            CFrame = targetCFrame
        }

        -- Create the tween
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)

        -- Play the tween
        tween:Play()
    end
}

local Slider = Tabs.Main:CreateSlider("Slider", {
    Title = "WalkSpeed",
    Description = "drag",
    Default = 1,
    Min = 16,
    Max = 500,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
        print("Slider was changed:", Value)
    end
})

local Tabs = {
    Main = Window:CreateTab{
        Title = "House",
        Icon = "nil"
    }
}

local Paragraph = Tabs.Main:CreateParagraph("Paragraph", {
    Title = "block A",
    Content = ""
})

Tabs.Main:CreateButton{
    Title = "A1",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House4")
        if not house then
            warn("House4 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House4!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "A2",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House8")
        if not house then
            warn("House8 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House8!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "A3",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House12")
        if not house then
            warn("House12 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House12!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

local Paragraph = Tabs.Main:CreateParagraph("Paragraph", {
    Title = "block B",
    Content = ""
})

Tabs.Main:CreateButton{
    Title = "B1",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House2")
        if not house then
            warn("House2 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House2!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "B2",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House3")
        if not house then
            warn("House3 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House3!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "B3",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House6")
        if not house then
            warn("House6 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House6!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "B4",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House7")
        if not house then
            warn("House7 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House7!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "B5",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House10")
        if not house then
            warn("House10 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House10!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "B6",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House11")
        if not house then
            warn("House11 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House11!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

local Paragraph = Tabs.Main:CreateParagraph("Paragraph", {
    Title = "block C",
    Content = ""
})

Tabs.Main:CreateButton{
    Title = "C1",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House1")
        if not house then
            warn("House1 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House1!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "C2",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House5")
        if not house then
            warn("House5 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House5!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}

Tabs.Main:CreateButton{
    Title = "C3",
    Description = "tween",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Find Houses model
        local houses = workspace:FindFirstChild("Houses")
        if not houses then
            warn("Houses model not found in workspace!")
            return
        end

        -- Find House8
        local house = houses:FindFirstChild("House9")
        if not house then
            warn("House9 not found in Houses model!")
            return
        end

        -- List of possible house types
        local houseTypes = {"Shack", "Tiny", "Small", "Medium", "Large", "TwoStory", "ThreeStory", "Backyard", "Basement", "Mansion", "Estate"}
        local houseTypeModel = nil

        -- Check which house type exists
        for _, houseType in ipairs(houseTypes) do
            local foundType = house:FindFirstChild(houseType)
            if foundType then
                houseTypeModel = foundType
                break -- Stop searching once a valid house type is found
            end
        end

        if not houseTypeModel then
            warn("No valid house type found inside House9!")
            return
        end

        local doors = houseTypeModel:FindFirstChild("Doors")
        if not doors then warn("Doors model not found in " .. houseTypeModel.Name) return end

        local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
        if not frontDoorMain then warn("FrontDoorMain not found in Doors.") return end

        local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
        if not doorTouch then warn("DoorTouch not found in FrontDoorMain.") return end

        -- Tween to DoorTouch
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = { CFrame = doorTouch.CFrame }

        local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
        tween:Play()
    end
}
