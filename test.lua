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

local Toggle3 = Tabs.Main:CreateToggle("MyToggle", {Title = "esp killer", Default = false})

Toggle3:OnChanged(function()
    if not Toggle3Interacted then
        Toggle3Interacted = true
        return
    end

    espGenerator = not espGenerator

    local Generatorlol = workspace.Map.Ingame.Map

    local function updateHighlight(model, highlight)
        local numVal = model:FindFirstChildWhichIsA("NumberValue")
        if numVal then
            if numVal.Value < 100 then
                highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Blue
                highlight.OutlineColor = Color3.fromRGB(0, 0, 127)
            elseif numVal.Value >= 100 then
                highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green
                highlight.OutlineColor = Color3.fromRGB(0, 170, 0)
            end
        end
    end

    local function createHighlight(model)
        local highlight = Instance.new("Highlight")
        highlight.Name = "CustomHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = model

        -- Update immediately
        updateHighlight(model, highlight)

        -- Keep updating when NumberValue changes
        local numVal = model:FindFirstChildWhichIsA("NumberValue")
        if numVal then
            numVal:GetPropertyChangedSignal("Value"):Connect(function()
                updateHighlight(model, highlight)
            end)
        end
    end

    if espGenerator then
        for _, model in ipairs(Generatorlol:GetChildren()) do
            if model:IsA("Model") then
                createHighlight(model)
            end
        end

        Generatorlol.ChildAdded:Connect(function(child)
            if child:IsA("Model") then
                createHighlight(child)
            end
        end)
    else
        for _, model in ipairs(Generatorlol:GetChildren()) do
            local hl = model:FindFirstChild("CustomHighlight")
            if hl then
                hl:Destroy()
            end
        end
    end
end)
