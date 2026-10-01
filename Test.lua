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
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.Q,
    Transparent = true,
    Theme = "Sherya",
    Resizable = false,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = true,
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
    Radius = 0,
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


Home:Select()
