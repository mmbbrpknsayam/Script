--// 🧠 Services
local HttpService = game:GetService("HttpService")

--// 🗂️ Config
local Config = {
    Folder = "Loader",
    File = "settings.json"
}

--// 📂 Ensure folder exists
if not isfolder(Config.Folder) then
    makefolder(Config.Folder)
end

local filePath = Config.Folder .. "/" .. Config.File

--// 📝 Ensure settings file exists & valid
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

--// 💾 Save function
local function SaveSettings()
    writefile(filePath, HttpService:JSONEncode(settings))
end

-------------------------------------------------------------------
-- 🪟 FLUENT SETUP
-------------------------------------------------------------------

local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local Window = Library:CreateWindow{
    Title = "Fluent Script Hub",
    SubTitle = "Save Seeds Example",
    Size = UDim2.fromOffset(700, 450),
    Acrylic = true,
    Theme = "Dark"
}

local Tabs = {
    Main = Window:CreateTab{ Title = "Main", Icon = "leaf" },
}

settings.selectedSeeds = settings.selectedSeeds or {}

local MultiDropdown = Tabs.Main:CreateDropdown("SeedDropdown", {
    Title = "Seed",
    Description = "Choose seeds to plant.",
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
    print("[🌱] Saved selected seeds:", table.concat(selected, ", "))
end)
