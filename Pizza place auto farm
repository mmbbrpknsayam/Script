local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `nil`,
    SubTitle = "test1",
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
    Title = "Button",
    Description = "Very important button",
    Callback = function()
        local TweenService = game:GetService("TweenService")
        local player = game.Players.LocalPlayer
        local tweenSpeed = 1 -- Adjust tween speed

        -- Mapping of items to corresponding houses
        local itemHouseMap = {
            A1 = "House4",
            A2 = "House8",
            A3 = "House12",
            B1 = "House2",
            B2 = "House3",
            B3 = "House6",
            B4 = "House7",
            B5 = "House10",
            B6 = "House11",
            C1 = "House1",
            C2 = "House5",
            C3 = "House9"
        }

        -- Function to equip a valid item from the player's backpack
        local function equipItem()
            local backpack = player:FindFirstChild("Backpack")
            if not backpack then 
                warn("Backpack not found!")
                return nil
            end

            local character = player.Character or player.CharacterAdded:Wait()
            if not character then 
                warn("Character not found!")
                return nil
            end

            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid then 
                warn("Humanoid not found in Character!")
                return nil
            end

            -- Loop through items in the map
            for itemName, _ in pairs(itemHouseMap) do
                local tool = backpack:FindFirstChild(itemName)
                if tool then
                    humanoid:EquipTool(tool) -- Equip the tool
                    return tool -- Return the actual tool instance
                end
            end

            warn("No matching item found in Backpack!")
            return nil
        end

        -- Function to tween player to the correct house based on the equipped item
        local function tweenToHouse(houseName)
            local character = player.Character or player.CharacterAdded:Wait()
            if not character then 
                warn("Character is nil!")
                return 
            end

            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then 
                warn("HumanoidRootPart not found!")
                return 
            end

            -- Find Houses model
            local houses = workspace:FindFirstChild("Houses")
            if not houses then
                warn("Houses model not found in workspace!")
                return
            end

            -- Find the correct house
            local house = houses:FindFirstChild(houseName)
            if not house then
                warn(houseName .. " not found in Houses model!")
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
                warn("No valid house type found inside " .. houseName .. "!")
                return
            end

            local doors = houseTypeModel:FindFirstChild("Doors")
            if not doors then 
                warn("Doors model not found in " .. houseTypeModel.Name)
                return 
            end

            local frontDoorMain = doors:FindFirstChild("FrontDoorMain")
            if not frontDoorMain then 
                warn("FrontDoorMain not found in Doors.") 
                return 
            end

            local doorTouch = frontDoorMain:FindFirstChild("DoorTouch")
            if not doorTouch then 
                warn("DoorTouch not found in FrontDoorMain.") 
                return 
            end

            -- Tween to DoorTouch
            local tweenInfo = TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local goal = { CFrame = doorTouch.CFrame }

            local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
            tween:Play()

            -- Wait for the tween to complete
            tween.Completed:Wait()
        end

        -- Function to wait until the equipped item is gone (fully removed from character)
        local function waitForItemRemoval(equippedTool)
            local character = player.Character or player.CharacterAdded:Wait()
            
            -- Wait until the equipped tool is no longer in the character
            while character and character:FindFirstChildOfClass("Tool") == equippedTool do
                task.wait(0.5) -- Check every 0.5 seconds
            end

            warn(equippedTool.Name .. " has been given to NPC. Moving to next item.")
        end

        -- Main Autofarm Logic
        while true do
            task.wait(1) -- Avoids lag

            local equippedTool = equipItem() -- Try to equip an item
            if equippedTool and itemHouseMap[equippedTool.Name] then
                tweenToHouse(itemHouseMap[equippedTool.Name]) -- Move to the corresponding house
                waitForItemRemoval(equippedTool) -- Wait until the equipped tool is fully removed
            end
        end
    end
}
