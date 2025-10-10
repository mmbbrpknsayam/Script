local HttpService = game:GetService("HttpService")

local Config = {
    Folder = "Loader",
    File = "settings.json"
}

if not isfolder(Config.Folder) then
    makefolder(Config.Folder)
end

local filePath = Config.Folder .. "/" .. Config.File

local settings
if not isfile(filePath) then
    writefile(filePath, "{}")
    settings = {}
else
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(filePath))
    end)
    settings = success and result or {}
end

local function SaveSettings()
    writefile(filePath, HttpService:JSONEncode(settings))
end

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Library:CreateWindow{
    Title = `plant`,
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
        Title = "Shop",
        Icon = "nil"
    }
}

local selectedSeeds = settings.selectedSeeds or {}

local MultiDropdown = Tabs.Main:CreateDropdown("MultiDropdown", {
    Title = "Seed",
    Description = "",
    Values = {
        "Cactus Seed",
        "Strawberry Seed",
        "Pumpkin Seed",
        "Sunflower Seed",
        "Dragon Fruit Seed",
        "Eggplant Seed",
        "Watermelon Seed",
        "Grape Seed",
        "Cocotank Seed",
        "Carnivorous Plant Seed",
        "Mr Carrot Seed",
        "Tomatrio Seed",
        "Shroombino Seed",
        "Mango Seed"
    },
    Multi = true,
    Default = settings.selectedSeeds
})

MultiDropdown:OnChanged(function(Value)
    local selected = {}
    for SeedName, IsSelected in pairs(Value) do
        if IsSelected then
            table.insert(selected, SeedName)
        end
    end

    settings.selectedSeeds = selected
    SaveSettings()
end)

local Toggle2 = Tabs.Main:CreateToggle("MyToggle", {Title = "Auto buy", Default = false})

Toggle2:OnChanged(function(value)
    if not Toggle2Interacted then
        Toggle2Interacted = true
        return
    end

    BuyEnabled = (value)
    settings.AutoBuy = (value)
    SaveSettings()

    if BuyEnabled then
        task.spawn(function()
            while BuyEnabled do
                for _, seed in ipairs(selectedSeeds) do
                    local args = {
                        seed, true
                    }
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("Remotes")
                        :WaitForChild("BuyItem")
                        :FireServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)
