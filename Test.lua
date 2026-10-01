local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local WHITELIST_URL = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Whitelist.json"
local BLACKLIST_URL = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Blacklist.json"

local function fetchUsers(url)
    local ok, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if ok and type(result) == "table" and type(result.users) == "table" then
        return result.users
    end
    return {}
end

local blacklist = fetchUsers(BLACKLIST_URL)
for _, entry in ipairs(blacklist) do
    if tonumber(entry.UserId) == LocalPlayer.UserId then
        LocalPlayer:Kick(entry.Reason or "You are blacklisted.")
        return
    end
end

local isWhitelisted = false
local whitelist = fetchUsers(WHITELIST_URL)
for _, entry in ipairs(whitelist) do
    if tonumber(entry.UserId) == LocalPlayer.UserId then
        isWhitelisted = true
        break
    end
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "Sherya",

    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#2e1065"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#1e0a3c"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
    Background = Color3.fromHex("#0d0816"),
    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#7c3aed"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#8b7aa8"),
    Button = Color3.fromHex("#4c1d95"),
    Icon = Color3.fromHex("#a78bfa"),
    Hover = Color3.fromHex("#6d28d9"),

    WindowBackground = Color3.fromHex("#0d0816"),
    WindowShadow = Color3.fromHex("#000000"),

    WindowTopbarButtonIcon = Color3.fromHex("#a78bfa"),
    WindowTopbarTitle = Color3.fromHex("#FFFFFF"),
    WindowTopbarAuthor = Color3.fromHex("#c4b5fd"),
    WindowTopbarIcon = Color3.fromHex("#FFFFFF"),

    TabBackground = Color3.fromHex("#7c3aed"),
    TabTitle = Color3.fromHex("#FFFFFF"),
    TabIcon = Color3.fromHex("#a78bfa"),

    ElementBackground = Color3.fromHex("#a78bfa"),
    ElementTitle = Color3.fromHex("#FFFFFF"),
    ElementDesc = Color3.fromHex("#c4b5fd"),
    ElementIcon = Color3.fromHex("#a78bfa"),

    PopupBackground = Color3.fromHex("#0d0816"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#FFFFFF"),
    PopupContent = Color3.fromHex("#FFFFFF"),
    PopupIcon = Color3.fromHex("#a78bfa"),

    DialogBackground = Color3.fromHex("#0d0816"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#FFFFFF"),
    DialogContent = Color3.fromHex("#FFFFFF"),
    DialogIcon = Color3.fromHex("#a78bfa"),

    Toggle = Color3.fromHex("#4c1d95"),
    ToggleBar = Color3.fromHex("#FFFFFF"),

    Checkbox = Color3.fromHex("#4c1d95"),
    CheckboxIcon = Color3.fromHex("#FFFFFF"),

    Slider = Color3.fromHex("#4c1d95"),
    SliderThumb = Color3.fromHex("#FFFFFF"),
})

WindUI:SetTheme("Sherya")

local windowConfig = {
    Title = "Mystery Hub",
    Icon = "layout-dashboard",
    Author = "Muscle Legends",
    Folder = "MySuperHub",
    Size = UDim2.fromOffset(600, 540),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.Q,
    Transparent = true,
    Theme = "Sherya",
    Resizable = false,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
    },
}

if not isWhitelisted then
    windowConfig.KeySystem = {
        Key = { "MHONTOP" },
        Note = "Enter the key to unlock the hub.",
        SaveKey = false,
    }
end

local Window = WindUI:CreateWindow(windowConfig)

Window:Tag({
    Title = "v1.1.1",
    Icon = "github",
    Color = Color3.fromHex("#7c3aed"),
    Radius = 12,
})

Window:EditOpenButton({
    Title = "Open Mystery Hub",
    Icon = "layout-dashboard",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("#4c1d95"),
        Color3.fromHex("#7c3aed")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

local Dashboard = Window:Section({
    Title = "Dashboard",
    Opened = true,
})

local Home = Dashboard:Tab({
    Title = "Home",
    Icon = "house",
    Locked = false,
})

local Farming = Window:Section({
    Title = "Farming",
    Opened = true,
})

local Farm = Farming:Tab({
    Title = "Farm",
    Icon = "pickaxe",
    Locked = false,
})

local Packs = Farming:Tab({
    Title = "Packs",
    Icon = "package",
    Locked = false,
})

local Miscellaneous = Window:Section({
    Title = "Miscellaneous",
    Opened = true,
})

local Extras = Miscellaneous:Tab({
    Title = "Extras",
    Icon = "folders",
    Locked = false,
})

local Snacks = Miscellaneous:Tab({
    Title = "Snacks",
    Icon = "popcorn",
    Locked = false,
})

local Calculator = Miscellaneous:Tab({
    Title = "Data",
    Icon = "calculator",
    Locked = false,
})

local Player = Window:Section({
    Title = "Player",
    Opened = true,
})

local Stats = Player:Tab({
    Title = "Stats",
    Icon = "users",
    Locked = false,
})

local Killer = Player:Tab({
    Title = "Killer",
    Icon = "skull",
    Locked = false,
})

local Teleport = Player:Tab({
    Title = "Teleport",
    Icon = "map-pin",
    Locked = false,
})

local Library = Window:Section({
    Title = "Library",
    Opened = true,
})

local Settings = Library:Tab({
    Title = "Settings",
    Icon = "settings",
    Locked = false,
})

local ConfigManager = Window.ConfigManager
local configCache = {}
local currentConfigName = "default"
local newConfigName = ""
local autoSaveEnabled = false

local function sanitizeName(name)
    local clean = tostring(name or ""):gsub("[^%w_%- ]", "")
    clean = clean:gsub("^%s+", ""):gsub("%s+$", "")
    return clean
end

local function getConfigNames()
    local ok, names = pcall(function()
        return ConfigManager:AllConfigs()
    end)
    if ok and type(names) == "table" and #names > 0 then
        return names
    end
    return { "default" }
end

local themeNames = {}
for name in pairs(WindUI:GetThemes()) do
    table.insert(themeNames, name)
end
table.sort(themeNames)

Settings:Section({
    Title = "Appearance",
})

local ThemeDropdown = Settings:Dropdown({
    Title = "Theme",
    Desc = "Change the UI colors",
    Values = themeNames,
    Value = "Sherya",
    Callback = function(option)
        WindUI:SetTheme(option)
    end,
})

local TransparencyToggle = Settings:Toggle({
    Title = "Transparency",
    Desc = "Make the window transparent",
    Value = true,
    Callback = function(state)
        Window:ToggleTransparency(state)
    end,
})

Settings:Section({
    Title = "Configuration",
})

local AutoSaveToggle = Settings:Toggle({
    Title = "Auto Save",
    Desc = "Saves the current config every 5 seconds",
    Value = false,
    Callback = function(state)
        autoSaveEnabled = state
    end,
})

local function getConfig(name)
    if configCache[name] then
        return configCache[name]
    end
    local config = ConfigManager:CreateConfig(name)
    config:Register("theme", ThemeDropdown)
    config:Register("transparency", TransparencyToggle)
    config:Register("autosave", AutoSaveToggle)
    configCache[name] = config
    return config
end

local ConfigDropdown = Settings:Dropdown({
    Title = "Select config",
    Values = getConfigNames(),
    Value = currentConfigName,
    Callback = function(option)
        currentConfigName = option
    end,
})

Settings:Input({
    Title = "New config name",
    Placeholder = "My config",
    Value = "",
    Callback = function(text)
        newConfigName = text
    end,
})

Settings:Button({
    Title = "Create config",
    Desc = "Creates and saves a new config with the typed name",
    Callback = function()
        local name = sanitizeName(newConfigName)
        if name == "" then
            WindUI:Notify({
                Title = "Config",
                Content = "Type a valid name first.",
                Duration = 3,
                Icon = "triangle-alert",
            })
            return
        end
        currentConfigName = name
        pcall(function()
            getConfig(name):Save()
        end)
        ConfigDropdown:Refresh(getConfigNames())
        ConfigDropdown:Select(name)
        WindUI:Notify({
            Title = "Config",
            Content = "Created: " .. name,
            Duration = 3,
            Icon = "check",
        })
    end,
})

Settings:Button({
    Title = "Save config",
    Callback = function()
        local ok = pcall(function()
            getConfig(currentConfigName):Save()
        end)
        WindUI:Notify({
            Title = "Config",
            Content = ok and ("Saved: " .. currentConfigName) or "Could not save.",
            Duration = 3,
            Icon = ok and "check" or "triangle-alert",
        })
    end,
})

Settings:Button({
    Title = "Load config",
    Callback = function()
        local ok = pcall(function()
            getConfig(currentConfigName):Load()
        end)
        WindUI:Notify({
            Title = "Config",
            Content = ok and ("Loaded: " .. currentConfigName) or "Could not load.",
            Duration = 3,
            Icon = ok and "check" or "triangle-alert",
        })
    end,
})

Settings:Button({
    Title = "Delete config",
    Callback = function()
        local name = currentConfigName
        pcall(function()
            getConfig(name):Delete()
        end)
        configCache[name] = nil
        currentConfigName = "default"
        ConfigDropdown:Refresh(getConfigNames())
        ConfigDropdown:Select("default")
        WindUI:Notify({
            Title = "Config",
            Content = "Deleted: " .. name,
            Duration = 3,
            Icon = "trash-2",
        })
    end,
})

task.spawn(function()
    while task.wait(5) do
        if autoSaveEnabled then
            pcall(function()
                getConfig(currentConfigName):Save()
            end)
        end
    end
end)

pcall(function()
    getConfig(currentConfigName):Load()
end)

Home:Select()
