local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `test`,
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
        Title = "main",
        Icon = "nil"
    }
}

Tabs.Main:CreateButton({
    Title = "auto generators",
    Description = "",
    Callback = function()
        task.spawn(function()
            while true do
                local openFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")
                for _, open in ipairs(generatorFolder:GetChildren()) do
                    local invo = open:FindFirstChild("Remotes")
                    if invo then
                        local rf = remotes:FindFirstChild("RF")
                        if rf and rf:IsA("RemoteFunction") then
                            pcall(function()
                                rf:InvokeServer("Enter")
                            end)
                        end
                    end
                end
                task.wait(4)
            end
        end)
    end
})
