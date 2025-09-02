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
                task.wait(1)
            end
        end)
    end
})
