local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `testnig`,
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

local Lighting = game:GetService("Lighting")

local Toggle1 = Tabs.Main:CreateToggle("MyToggle", {Title = "fb", Default = false})

local fbConnections = {}
local Toggle1Interacted = false
local fb = false

Toggle1:OnChanged(function()
    if not Toggle1Interacted then
        Toggle1Interacted = true
        return
    end

    fb = not fb

    if fb then
        -- Apply lighting instantly
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 14

        -- Remove existing Atmosphere
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") then
                v:Destroy()
            end
        end

        -- Enforce settings if changed by other scripts
        fbConnections.Brightness = Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
            if Lighting.Brightness ~= 2 then
                Lighting.Brightness = 2
            end
        end)

        fbConnections.GlobalShadows = Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
            if Lighting.GlobalShadows ~= false then
                Lighting.GlobalShadows = false
            end
        end)

        fbConnections.ClockTime = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            if Lighting.ClockTime ~= 14 then
                Lighting.ClockTime = 14
            end
        end)

        -- Remove any new Atmosphere automatically
        fbConnections.ChildAdded = Lighting.ChildAdded:Connect(function(child)
            if child:IsA("Atmosphere") then
                task.wait()
                child:Destroy()
            end
        end)

    else
        -- Disable all signals
        for _, conn in pairs(fbConnections) do
            if conn and conn.Disconnect then
                conn:Disconnect()
            end
        end
        fbConnections = {}
    end
end)
