local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local StatsService = game:GetService("Stats")
local TeleportService = game:GetService("TeleportService")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

local Config = {
    HubName = "Mystery Hub",
    Key = "MHONTOP",
    DiscordLink = "https://discord.gg/CHANGE_ME",
    WhitelistUrl = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Whitelist.json",
    BlacklistUrl = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Blacklist.json",
    WindUiUrl = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
}

local function fetchUsers(url)
    local ok, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if ok and type(result) == "table" and type(result.users) == "table" then
        return result.users
    end
    return {}
end

local function findUser(list, userId)
    for _, entry in ipairs(list) do
        if type(entry) == "table" and tonumber(entry.UserId) == userId then
            return entry
        end
    end
    return nil
end

local banned = findUser(fetchUsers(Config.BlacklistUrl), LocalPlayer.UserId)
if banned then
    LocalPlayer:Kick(tostring(banned.Reason or "You are blacklisted."))
    return
end

local isWhitelisted = findUser(fetchUsers(Config.WhitelistUrl), LocalPlayer.UserId) ~= nil

local env = (getgenv and getgenv()) or _G
local runId = tostring(os.clock()) .. tostring(math.random(1000, 9999))

if env.MysteryHubWindow then
    pcall(function()
        env.MysteryHubWindow:Destroy()
    end)
end
env.MysteryHubRun = runId

local function isAlive()
    return env.MysteryHubRun == runId
end

local loaded, WindUI = pcall(function()
    return loadstring(game:HttpGet(Config.WindUiUrl))()
end)
if not loaded or type(WindUI) ~= "table" then
    return
end

local themeName = "Sherya"
local themeOk = pcall(function()
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
end)
if not themeOk then
    themeName = "Dark"
end

local windowConfig = {
    Title = Config.HubName,
    Icon = "layout-dashboard",
    Author = "Muscle Legends",
    Folder = "MySuperHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.Q,
    Transparent = true,
    Theme = themeName,
    Resizable = false,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = false,
    },
}

if not isWhitelisted then
    windowConfig.KeySystem = {
        Key = { Config.Key },
        Note = "Enter the key to unlock the hub.",
        SaveKey = false,
    }
end

local Window = WindUI:CreateWindow(windowConfig)
env.MysteryHubWindow = Window

pcall(function()
    Window:EditOpenButton({
        Title = "Open " .. Config.HubName,
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
end)

local Util = {}
local Registry = {}
local Sections = {}
local Tabs = {}

function Util.register(flag, element)
    Registry[flag] = element
end

function Util.notify(title, content, icon)
    pcall(function()
        WindUI:Notify({
            Title = title,
            Content = content,
            Duration = 3,
            Icon = icon or "check",
        })
    end)
end

function Util.copyText(text)
    local fn = setclipboard or toclipboard or (syn and syn.write_clipboard) or (Clipboard and Clipboard.set)
    if fn then
        local ok = pcall(fn, text)
        return ok
    end
    return false
end

function Util.copyWithNotice(label, text)
    if Util.copyText(text) then
        Util.notify("Copied", label .. " copied to clipboard.", "copy")
    else
        Util.notify("Error", "Your executor can't copy to clipboard.", "triangle-alert")
    end
end

function Util.formatTime(total)
    total = math.floor(total)
    return string.format("%02d:%02d:%02d", math.floor(total / 3600), math.floor(total % 3600 / 60), total % 60)
end

function Util.yesNo(value)
    return value and "Yes" or "No"
end

function Util.getExecutor()
    local ok, name, version = pcall(function()
        if identifyexecutor then
            return identifyexecutor()
        end
        if getexecutorname then
            return getexecutorname()
        end
        return nil
    end)
    if ok and name then
        return tostring(name), version and tostring(version) or "Unknown"
    end
    return "Unknown", "Unknown"
end

function Util.getGameName()
    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if ok and type(info) == "table" and info.Name then
        return tostring(info.Name)
    end
    return "Unknown"
end

function Util.getPing()
    local ok, value = pcall(function()
        return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    if ok and type(value) == "number" then
        return math.floor(value)
    end
    return 0
end

function Util.sanitizeName(name)
    local clean = tostring(name or ""):gsub("[^%w_%- ]", "")
    clean = clean:gsub("^%s+", ""):gsub("%s+$", "")
    return clean:sub(1, 32)
end

local layout = {
    {
        Title = "Dashboard",
        Tabs = {
            { Key = "Home", Title = "Home", Icon = "house" },
        },
    },
    {
        Title = "Farming",
        Tabs = {
            { Key = "Farm", Title = "Farm", Icon = "pickaxe" },
            { Key = "Packs", Title = "Packs", Icon = "package" },
        },
    },
    {
        Title = "Miscellaneous",
        Tabs = {
            { Key = "Extras", Title = "Extras", Icon = "folders" },
            { Key = "Snacks", Title = "Snacks", Icon = "popcorn" },
            { Key = "Data", Title = "Data", Icon = "calculator" },
        },
    },
    {
        Title = "Player",
        Tabs = {
            { Key = "Stats", Title = "Stats", Icon = "users" },
            { Key = "Killer", Title = "Killer", Icon = "skull" },
            { Key = "Teleport", Title = "Teleport", Icon = "map-pin" },
        },
    },
    {
        Title = "Library",
        Tabs = {
            { Key = "Settings", Title = "Settings", Icon = "settings" },
        },
    },
}

for _, sectionData in ipairs(layout) do
    local section = Window:Section({
        Title = sectionData.Title,
        Opened = true,
    })
    Sections[sectionData.Title] = section
    for _, tabData in ipairs(sectionData.Tabs) do
        Tabs[tabData.Key] = section:Tab({
            Title = tabData.Title,
            Icon = tabData.Icon,
            Locked = false,
        })
    end
end

do
    local Home = Tabs.Home

    local fps, frames, lastCheck = 0, 0, os.clock()
    local fpsConnection = RunService.RenderStepped:Connect(function()
        frames = frames + 1
        local now = os.clock()
        if now - lastCheck >= 1 then
            fps = math.floor(frames / (now - lastCheck) + 0.5)
            frames = 0
            lastCheck = now
        end
    end)

    local createdAt = os.date("%Y-%m-%d", os.time() - LocalPlayer.AccountAge * 86400)

    Home:Section({
        Title = "Player",
    })

    Home:Paragraph({
        Title = "Player info",
        Desc = table.concat({
            "Display name: " .. LocalPlayer.DisplayName,
            "Username: " .. LocalPlayer.Name,
            "User ID: " .. LocalPlayer.UserId,
            "Account age: " .. LocalPlayer.AccountAge .. " days",
            "Created: " .. createdAt,
            "Membership: " .. LocalPlayer.MembershipType.Name,
        }, "\n"),
    })

    Home:Button({
        Title = "Copy User ID",
        Icon = "copy",
        Callback = function()
            Util.copyWithNotice("User ID", tostring(LocalPlayer.UserId))
        end,
    })

    Home:Section({
        Title = "Game",
    })

    Home:Paragraph({
        Title = "Game info",
        Desc = table.concat({
            "Name: " .. Util.getGameName(),
            "Place ID: " .. game.PlaceId,
            "Game ID: " .. game.GameId,
            "Job ID: " .. game.JobId,
            "Max players: " .. Players.MaxPlayers,
        }, "\n"),
    })

    local ServerParagraph = Home:Paragraph({
        Title = "Live server stats",
        Desc = "Loading...",
    })

    Home:Button({
        Title = "Copy Place ID",
        Icon = "copy",
        Callback = function()
            Util.copyWithNotice("Place ID", tostring(game.PlaceId))
        end,
    })

    Home:Button({
        Title = "Copy Job ID",
        Icon = "copy",
        Callback = function()
            Util.copyWithNotice("Job ID", tostring(game.JobId))
        end,
    })

    Home:Button({
        Title = "Rejoin server",
        Icon = "refresh-cw",
        Callback = function()
            local ok = pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end)
            if not ok then
                pcall(function()
                    TeleportService:Teleport(game.PlaceId, LocalPlayer)
                end)
            end
        end,
    })

    Home:Section({
        Title = "Executor",
    })

    local executorName, executorVersion = Util.getExecutor()

    local capabilities = {
        { "Clipboard", (setclipboard or toclipboard) ~= nil },
        { "HTTP requests", (request or http_request or (syn and syn.request)) ~= nil },
        { "File system", (writefile and readfile) ~= nil },
        { "Hook functions", hookfunction ~= nil },
        { "Drawing library", Drawing ~= nil },
        { "Queue on teleport", (queue_on_teleport or (syn and syn.queue_on_teleport)) ~= nil },
    }

    local lines = {
        "Name: " .. executorName,
        "Version: " .. executorVersion,
    }
    for _, item in ipairs(capabilities) do
        table.insert(lines, item[1] .. ": " .. Util.yesNo(item[2]))
    end

    Home:Paragraph({
        Title = "Executor info",
        Desc = table.concat(lines, "\n"),
    })

    Home:Section({
        Title = "Community",
    })

    Home:Button({
        Title = "Copy Discord link",
        Desc = "Join the community server",
        Icon = "message-circle",
        Callback = function()
            Util.copyWithNotice("Discord link", Config.DiscordLink)
        end,
    })

    task.spawn(function()
        while task.wait(1) and isAlive() do
            pcall(function()
                ServerParagraph:SetDesc(table.concat({
                    "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers,
                    "FPS: " .. fps,
                    "Ping: " .. Util.getPing() .. " ms",
                    "Server time: " .. Util.formatTime(workspace.DistributedGameTime),
                    "Memory: " .. math.floor(StatsService:GetTotalMemoryUsageMb()) .. " MB",
                }, "\n"))
            end)
        end
        fpsConnection:Disconnect()
    end)
end

do
    local Settings = Tabs.Settings

    local ConfigManager = Window.ConfigManager
    local configCache = {}
    local currentConfig = "default"
    local newConfigName = ""
    local autoSaveEnabled = false

    local themeNames = {}
    local themesOk, themes = pcall(function()
        return WindUI:GetThemes()
    end)
    if themesOk and type(themes) == "table" then
        for name in pairs(themes) do
            table.insert(themeNames, name)
        end
    end
    if #themeNames == 0 then
        themeNames = { "Sherya", "Dark", "Light" }
    end
    table.sort(themeNames)

    Settings:Section({
        Title = "Appearance",
    })

    local ThemeDropdown = Settings:Dropdown({
        Title = "Theme",
        Desc = "Change the UI colors",
        Values = themeNames,
        Value = themeName,
        Callback = function(option)
            if type(option) ~= "string" then
                return
            end
            pcall(function()
                WindUI:SetTheme(option)
            end)
        end,
    })
    Util.register("theme", ThemeDropdown)

    local TransparencyToggle = Settings:Toggle({
        Title = "Transparency",
        Desc = "Make the window transparent",
        Value = true,
        Callback = function(state)
            pcall(function()
                Window:ToggleTransparency(state)
            end)
        end,
    })
    Util.register("transparency", TransparencyToggle)

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
    Util.register("autosave", AutoSaveToggle)

    local function getConfig(name)
        if not ConfigManager then
            return nil
        end
        if configCache[name] then
            return configCache[name]
        end
        local config = ConfigManager:CreateConfig(name)
        for flag, element in pairs(Registry) do
            config:Register(flag, element)
        end
        configCache[name] = config
        return config
    end

    local function runConfig(action, name)
        return pcall(function()
            local config = getConfig(name)
            config[action](config)
        end)
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

    local ConfigDropdown = Settings:Dropdown({
        Title = "Select config",
        Values = getConfigNames(),
        Value = currentConfig,
        Callback = function(option)
            if type(option) == "string" then
                currentConfig = option
            end
        end,
    })

    local function refreshConfigs(selectName)
        pcall(function()
            ConfigDropdown:Refresh(getConfigNames())
        end)
        pcall(function()
            ConfigDropdown:Select(selectName)
        end)
    end

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
            local name = Util.sanitizeName(newConfigName)
            if name == "" then
                Util.notify("Config", "Type a valid name first.", "triangle-alert")
                return
            end
            currentConfig = name
            runConfig("Save", name)
            refreshConfigs(name)
            Util.notify("Config", "Created: " .. name, "check")
        end,
    })

    Settings:Button({
        Title = "Save config",
        Callback = function()
            local ok = runConfig("Save", currentConfig)
            Util.notify("Config", ok and ("Saved: " .. currentConfig) or "Could not save.", ok and "check" or "triangle-alert")
        end,
    })

    Settings:Button({
        Title = "Load config",
        Callback = function()
            local ok = runConfig("Load", currentConfig)
            Util.notify("Config", ok and ("Loaded: " .. currentConfig) or "Could not load.", ok and "check" or "triangle-alert")
        end,
    })

    Settings:Button({
        Title = "Delete config",
        Callback = function()
            local name = currentConfig
            runConfig("Delete", name)
            configCache[name] = nil
            currentConfig = "default"
            refreshConfigs("default")
            Util.notify("Config", "Deleted: " .. name, "trash-2")
        end,
    })

    task.spawn(function()
        while task.wait(5) and isAlive() do
            if autoSaveEnabled then
                runConfig("Save", currentConfig)
            end
        end
    end)

    function Util.autoLoad()
        runConfig("Load", currentConfig)
    end
end

if Util.autoLoad then
    Util.autoLoad()
end

pcall(function()
    Tabs.Home:Select()
end)
