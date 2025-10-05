local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `setting`,
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
        Title = "Server hop",
        Icon = "nil"
    }
}

local placeId = game.PlaceId
local jobid = ""

Tabs.Main:CreateButton{
    Title = "Copy jobid",
    Description = "",
    Callback = function()
        local clipboardFunc = setclipboard or toclipboard
        if clipboardFunc then
            clipboardFunc(tostring(game.JobId))
            print("Copied Job ID:", game.JobId)
        else
            warn("Clipboard not supported on this executor.")
        end
    end
}

local Input = Tabs.Main:CreateInput("Input", {
    Title = "JobId",
    Default = "",
    Placeholder = "",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        jobid = Value
        print("Job ID set to:", jobid)
    end
})

Tabs.Main:CreateButton{
    Title = "Join Server",
    Description = "",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local instanceId = tostring(jobid)

        if instanceId ~= "" then
            TeleportService:TeleportToPlaceInstance(placeId, instanceId, game.Players.LocalPlayer)
        else
            warn("Invalid Job ID.")
        end
    end
}
