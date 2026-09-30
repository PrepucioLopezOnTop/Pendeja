local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Auth = getgenv()._MYSTERYHUB_AUTH

if not Auth then
    Player:Kick("DON'T TRY SKIP THE KEY NIGGA")
    return
end

if Auth.Key ~= "MHONTOP"
or Auth.UserId ~= Player.UserId
or Auth.PlaceId ~= game.PlaceId then
    Player:Kick("DON'T TRY SKIP THE KEY NIGGA")
    return
end

local Expected = (game.PlaceId * 7 + Player.UserId * 13) % 1000000

if Auth.Calc ~= Expected then
    Player:Kick("DON'T TRY SKIP THE KEY NIGGA")
    return
end

getgenv()._MYSTERYHUB_AUTH = nil

print("Sherya Mi Perra En Celo, Le Pico El Hoyo y Grita De Alegria")

getgenv().MysteryHub = getgenv().MysteryHub or {}

MH = getgenv().MysteryHub

MH.Gen = (MH.Gen or 0) + 1
myGen = MH.Gen

MH.S = {
    RS = game:GetService("ReplicatedStorage"),
    TP = game:GetService("TeleportService"),
    HTTP = game:GetService("HttpService"),
    Run = game:GetService("RunService"),
    UIS = game:GetService("UserInputService"),
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    VirtualUser = game:GetService("VirtualUser"),
    Stats = game:GetService("Stats"),
    VIM = game:GetService("VirtualInputManager"),
    StarterGui = game:GetService("StarterGui"),
    GuiService = game:GetService("GuiService"),
    CollectionService = game:GetService("CollectionService"),
}

MH.S.LP = MH.S.Players.LocalPlayer
MH.S.Camera = workspace.CurrentCamera
MH.S.JobId = game.JobId
MH.S.PlaceId = game.PlaceId

MH.V = MH.V or {
    ScriptName = "Mystery Hub",
    ScriptVersion = "Muscle Legends V1.0.0",
    FPS = 0,
    Ping = 0,

    AutoRock = false,
    SelectedRock = "",
    RockTime = 0,
    SelectedTool = "",
    AutoTool = false,
    FastTools = false,
    SelectedCombo = "",
    AutoCombo = false,
    RebirthTarget = 0,
    AutoRebirthTarget = false,
    AutoRebirthInfinite = false,
    AutoTeleportKing = false,

    StrengthTracking = false,
    StrengthStartTime = 0,
    StrengthInitialStr = 0,
    StrengthInitialDur = 0,
    StrengthPausedTime = 0,
    AutoStrengthFarm = false,
    StrengthRepSpeed = 20,
    SelectedEggMode = "",

    RebirthTracking = false,
    RebirthStartTime = 0,
    RebirthStartCount = 0,
    RebirthPausedTime = 0,
    AutoFastRebirth = false,
    FastRebirthSlots = 1,

    AntiFling = false,
    LockPosition = false,
    HideFrames = false,
    AutoSpinWheel = false,
    InfiniteJump = false,
    WalkOnWater = false,
    Noclip = false,
    SizeValue = 2,
    AutoSetSize = false,
    SpeedValue = 200,
    AutoSetSpeed = false,
    JumpValue = 50,
    SuperJump = false,
    GravityValue = 196,
    CustomGravity = false,
    AutoReconnect = false,
    AutoReconnectAuto = false,

    SelectedPet = "",
    SelectedAura = "",
    SelectedUltimate = "",
    SelectedTradePlayer = "",
    SelectedTradePet = "",
    AutoBuyPet = false,
    AutoBuyAura = false,
    AutoBuyUltimate = false,
    AutoEvolvePets = false,
    AutoEvolveAuras = false,
    AutoTrade = false,
    AutoTradeAll = false,

    EggGiftCount = 0,
    ShakeGiftCount = 0,
    FastEatEggAmount = 0,
    AutoEgg = false,
    AutoEat = false,
    AutoEatFastEggs = false,
    SelectedFoodItems = {},

    CalculatorActive = false,
    CalcInitialStr = 0,
    CalcInitialDur = 0,
    CalcInitialKills = 0,
    CalcInitialAgility = 0,
    CalcInitialGems = 0,
    CalcInitialRebirths = 0,

    RemoveAttackAnims = false,
    KillWhileDead = false,
    BlockEatingEggs = false,
    PackSpam = false,
    KillEveryone = false,
    WhitelistFriends = false,
    SelectedWhitelistPlayers = {},
    AutoGoodKarma = false,
    AutoBadKarma = false,
    KillList = false,
    KillListMethod = "No Teleport",
    SelectedKillListPlayers = {},
    Spectating = false,
    SelectedSpectatePlayer = "",
    ClanKillEnabled = false,
    DeathRingEnabled = false,
    ShowDeathRing = false,
    DeathRingRange = 20,
    SelectedFollowPlayer = "",
    FollowTarget = false,
    AutoSlams = false,

    SelectedStatsPlayer = "",
    FakeStatsEnabled = false,
    FakeStrength = 0,
    FakeDurability = 0,
    FakeRebirths = 0,
    FakeKills = 0,
    FakeGems = 0,
    FakeAgility = 0,
    FakeEvilKarma = 0,
    FakeGoodKarma = 0,
    WebhookURL = "",
    WebhookTargetPlayer = "",
    WebhookColor = 0x4B0082,

    SelectedWorkoutType = "",
    SelectedWorkoutLocation = "",
    SelectedTreadmillLocation = "",
    SelectedIsland = "",
    SelectedBrawlIsland = "",
}

MH.T = MH.T or {
    FrameCount = 0,
    LastCheck = os.clock(),
}

MH.C = MH.C or {}
MH.St = MH.St or {}

MH.D = MH.D or {}
MH.D.Whitelist = MH.D.Whitelist or {}
MH.D.Blacklist = MH.D.Blacklist or {}
MH.D.ClanBlacklistWords = MH.D.ClanBlacklistWords or {}
MH.D.ClanActiveTargets = MH.D.ClanActiveTargets or {}

MH.H = MH.H or {}

S = MH.S
V = MH.V
D = MH.D
T = MH.T
C = MH.C
H = MH.H
St = MH.St

U = {
    pcall_ = pcall,
    string_format = string.format,
    table_insert = table.insert,
    table_concat = table.concat,
    table_sort = table.sort,
    math_min = math.min,
    math_max = math.max,
}

player = S.LP

Refs = Refs or {}

Refs.leaderstats = Refs.leaderstats or player:WaitForChild("leaderstats")

function H.SafeTouchInterest(part, hand, delay)
    if not part or not hand then
        return false
    end

    fire = firetouchinterest

    if not fire then
        return false
    end

    ok = pcall(function()
        fire(part, hand, 0)

        if delay and delay > 0 then
            task.wait(delay)
        end

        fire(part, hand, 1)
    end)

    return ok
end

function formatRate(perSecond)
    perSecond = tonumber(perSecond) or 0

    return formatShort(perSecond * 3600) .. " /Hora | " ..
        formatShort(perSecond * 86400) .. " /Dia | " ..
        formatShort(perSecond * 604800) .. " /Semana | " ..
        formatShort(perSecond * 2592000) .. " /Mes"
end

function checkCharacter()
    char = S.LP.Character

    if not char then
        return nil
    end

    if not char:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    return char
end

function teleportToTarget(target)
    char = checkCharacter()
    targetChar = target and target.Character
    targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

    if not char or not targetRoot then
        return false
    end

    minDist = 4
    maxDist = 7
    angle = math.random() * math.pi * 2
    dist = minDist + math.random() * (maxDist - minDist)

    offset = Vector3.new(
        math.cos(angle) * dist,
        0,
        math.sin(angle) * dist
    )

    char.HumanoidRootPart.CFrame =
        CFrame.new(targetRoot.Position + offset, targetRoot.Position)

    return true
end

function tpAndKill(target, isActiveFn)
    startTime = tick()
    timeoutSeconds = 6

    while isActiveFn
        and isActiveFn()
        and target
        and target.Character
        and target.Character:FindFirstChild("HumanoidRootPart") do

        if tick() - startTime >= timeoutSeconds then
            break
        end

        character = checkCharacter()
        humanoid = target.Character:FindFirstChildOfClass("Humanoid")

        if not character or not humanoid or humanoid.Health <= 0 then
            break
        end

        teleportToTarget(target)

        pcall(function()
            S.LP.muscleEvent:FireServer("punch", "rightHand")
            S.LP.muscleEvent:FireServer("punch", "leftHand")
        end)

        task.wait(0.05)
    end
end

function formatShort(value)
    if value >= 1e18 then
        return U.string_format("%.2fQi", value / 1e18)
    elseif value >= 1e15 then
        return U.string_format("%.2fQa", value / 1e15)
    elseif value >= 1e12 then
        return U.string_format("%.2fT", value / 1e12)
    elseif value >= 1e9 then
        return U.string_format("%.2fB", value / 1e9)
    elseif value >= 1e6 then
        return U.string_format("%.2fM", value / 1e6)
    elseif value >= 1e3 then
        return U.string_format("%.2fK", value / 1e3)
    end

    return tostring(value)
end

R = {}

Refs.leaderstats = Refs.leaderstats or S.LP:WaitForChild("leaderstats")
Refs.strengthStat = Refs.strengthStat or Refs.leaderstats:WaitForChild("Strength")
Refs.rebirthsStat = Refs.rebirthsStat or Refs.leaderstats:WaitForChild("Rebirths")
Refs.durabilityStat = Refs.durabilityStat or S.LP:WaitForChild("Durability")
Refs.muscleEvent = Refs.muscleEvent or S.LP:WaitForChild("muscleEvent")
Refs.eggEvent = Refs.eggEvent or Refs.muscleEvent
Refs.petsFolder = Refs.petsFolder or S.LP:WaitForChild("petsFolder")
Refs.rEvents = Refs.rEvents or S.RS:WaitForChild("rEvents")
Refs.equipPetEvent = Refs.equipPetEvent or Refs.rEvents:WaitForChild("equipPetEvent")
Refs.rebirthRemote = Refs.rebirthRemote or Refs.rEvents:WaitForChild("rebirthRemote")
Refs.openFortuneWheelRemote = Refs.openFortuneWheelRemote or Refs.rEvents:WaitForChild("openFortuneWheelRemote")
Refs.fortuneWheelChances = Refs.fortuneWheelChances
    or S.RS:WaitForChild("shared")
        :WaitForChild("catalogs")
        :WaitForChild("fortuneWheelChances")["Fortune Wheel"]

WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/4479cantcode/Library/refs/heads/main/WindUI/Source.lua"
))()

R.Window = WindUI:CreateWindow({
    Title = "Mystery Hub | Welcome " .. (S.LP.DisplayName or S.LP.Name),
    Author = "Made By Rafael and Sherya",
    Folder = "MysteryHub",
    Icon = "layout-dashboard",
    IconSize = 22,
    IconThemed = true,
    IconRadius = 0,

    Size = UDim2.fromOffset(700, 520),
    MinSize = Vector2.new(560, 500),
    MaxSize = Vector2.new(850, 600),

    Theme = "Dark",
    Transparent = false,
    Acrylic = true,
    Resizable = true,
    AutoScale = true,

    NewElements = true,
    Radius = 16,
    ShadowTransparency = 0.7,

    SideBarWidth = 200,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    HidePanelBackground = false,
    IgnoreAlerts = false,

    ToggleKey = Enum.KeyCode.RightShift,

    TopBar = {
        Height = 52,
        ButtonsType = "Default",
    },

    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "User",
                Content = S.LP.DisplayName .. " (@" .. S.LP.Name .. ")",
                Icon = "user",
                Duration = 3,
            })
        end,
    },

    OpenButton = {
        Title = "Open Mystery Hub",
        Icon = "layout-dashboard",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        OnlyIcon = false,
        Scale = 1,
    },
})

R.DashBoard = R.Window:Section({
    Title = "Dashboard",
    Icon = "layout-dashboard",
    Opened = true
})

R.Home = R.DashBoard:Tab({
    Title = "Home",
    Icon = "house",
    ShowTabTitle = true
})

R.Home:Paragraph({
    Title = "Script Info",
    Desc =
        V.ScriptName ..
        "\nVersion: " .. V.ScriptVersion ..
        "\nAuthor: Made By Rafael and Sherya" ..
        "\nUI Library: WindUI"
})

R.Home:Divider()

R.Home:Paragraph({
    Title = "Mystery Hub Server",
    Desc = "Discord Server"
})

R.Home:Button({
    Title = "Server Discord",
    Desc = "Copy Discord invite",
    Icon = "message-circle",
    Callback = function()
        discord = "https://discord.gg/YDYMTWZUuD"

        if setclipboard then
            setclipboard(discord)
        end

        S.StarterGui:SetCore("SendNotification", {
            Title = "Discord",
            Text = "Server Copiado",
            Duration = 10
        })
    end
})

function H.GetAccountAge()
    return tostring(S.LP.AccountAge) .. " days"
end

function H.GetExecutor()
    name, version = "Unknown", nil

    if identifyexecutor then
        name, version = identifyexecutor()
    elseif getexecutorname then
        name = getexecutorname()
    end

    if version and version ~= "" then
        return name .. " " .. tostring(version)
    end

    return name
end

MH.ExecutorName = H.GetExecutor()

if C.RenderStep then
    C.RenderStep:Disconnect()
end

C.RenderStep = S.Run.RenderStepped:Connect(function()
    T.FrameCount = T.FrameCount + 1

    now = os.clock()

    if now - T.LastCheck >= 1 then
        V.FPS = T.FrameCount
        T.FrameCount = 0
        T.LastCheck = now
    end
end)

R.Home:Divider()

R.HomeAccount = R.Home:Paragraph({
    Title = "Account Info",
    Desc =
        "Username: " .. S.LP.Name ..
        "\nDisplay Name: " .. S.LP.DisplayName ..
        "\nUser ID: " .. tostring(S.LP.UserId) ..
        "\nAccount Age: " .. H.GetAccountAge()
})

R.Home:Divider()

R.HomeFPS = R.Home:Paragraph({
    Title = "FPS",
    Desc = "FPS: Loading..."
})

R.HomePing = R.Home:Paragraph({
    Title = "Ping",
    Desc = "Ping: Loading..."
})

R.HomeExecutor = R.Home:Paragraph({
    Title = "Executor",
    Desc = "Executor: " .. MH.ExecutorName
})

R.Home:Divider()

R.HomeGame = R.Home:Paragraph({
    Title = "Game Info",
    Desc =
        "Place ID: " .. tostring(S.PlaceId) ..
        "\nJob ID: " .. tostring(S.JobId) ..
        "\nPlayers: " .. #S.Players:GetPlayers() ..
        "/" .. S.Players.MaxPlayers
})

task.spawn(function()
    while task.wait(1) do
        if MH.Gen ~= myGen then
            break
        end

        ok, ping = pcall(function()
            return S.Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        end)

        V.Ping = ok and math.floor(ping) or 0

        if R.HomeFPS then
            R.HomeFPS:SetDesc("FPS: " .. tostring(V.FPS))
        end

        if R.HomePing then
            R.HomePing:SetDesc("Ping: " .. tostring(V.Ping) .. " ms")
        end
    end
end)

R.Farming = R.Window

R.SimpleFarm = R.Farming:Tab({
    Title = "Farm",
    Icon = "pickaxe",
    ShowTabTitle = true
})

R.AntiAFK = R.SimpleFarm:Toggle({
    Title = "Anti AFK",
    Value = false,
    Callback = function(State)
        if State then
            if C.Idled then
                C.Idled:Disconnect()
            end

            C.Idled = S.LP.Idled:Connect(function()
                S.VirtualUser:CaptureController()
                S.VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            if C.Idled then
                C.Idled:Disconnect()
                C.Idled = nil
            end
        end
    end
})

R.AntiAFK:Set(true)

V.HidePets = false
V.HidePopups = false

R.HidePetsSwitch = R.SimpleFarm:Toggle({
    Title = "Hide Pets",
    Value = true,
    Callback = function(state)
        V.HidePets = state

        local event = S.RS:FindFirstChild("rEvents")
            and S.RS.rEvents:FindFirstChild("showPetsEvent")

        if event then
            event:FireServer(state and "hidePets" or "showPets")
        end
    end
})

R.HidePetsSwitch:Set(true)

R.HidePopupsSwitch = R.SimpleFarm:Toggle({
    Title = "Hide Popups",
    Value = true,
    Callback = function(state)
        V.HidePopups = state

        local event = S.RS:FindFirstChild("rEvents")
            and S.RS.rEvents:FindFirstChild("savePlayerSizeEvent")

        if event then
            event:FireServer("showPopupsOption")
        end
    end
})

R.HidePopupsSwitch:Set(true)

R.RockSystem = R.SimpleFarm:Section({
    Title = "Farm Rocks",
    Icon = "mountain"
})

D.rockList = D.rockList or {
    { name = "Tiny Island Rock", durability = 0 },
    { name = "Starter Island Rock", durability = 100 },
    { name = "Legend Beach Rock", durability = 5000 },
    { name = "Frost Gym Rock", durability = 150000 },
    { name = "Mythical Gym Rock", durability = 400000 },
    { name = "Eternal Gym Rock", durability = 750000 },
    { name = "Legend Gym Rock", durability = 1000000 },
    { name = "Muscle King Gym Rock", durability = 5000000 },
    { name = "Ancient Jungle Rock", durability = 10000000 },
    { name = "Industrial Rock", durability = 25000000 },
}

D.rockNames = {}

for _, rock in pairs(D.rockList) do
    table.insert(D.rockNames, rock.name)
end

V.SelectedRock = V.SelectedRock or ""
V.AutoRock = V.AutoRock or false
V.RockTime = V.RockTime or 0

function H.RockFormatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60

    return string.format("%02d:%02d:%02d", h, m, s)
end

function H.PunchLoop(callback)
    task.spawn(function()
        while callback() do
            local char = S.LP.Character
            local punch = char and (
                char:FindFirstChild("Punch")
                or S.LP.Backpack:FindFirstChild("Punch")
            )

            if punch then
                if punch.Parent ~= char then
                    punch.Parent = char
                end

                local attackTime = punch:FindFirstChild("attackTime")

                if attackTime then
                    attackTime.Value = 0
                end

                punch:Activate()
            end

            task.wait()
        end
    end)
end

H.RockPunch = H.PunchLoop

function H.FarmRock(character)
    if not character or not character.Parent then
        return
    end

    local leftHand = character:FindFirstChild("LeftHand")
    local rightHand = character:FindFirstChild("RightHand")

    if not leftHand or not rightHand then
        return
    end

    local durability = 0

    for _, rock in pairs(D.rockList) do
        if rock.name == V.SelectedRock then
            durability = rock.durability
            break
        end
    end

    local okDur, durValue = pcall(function()
        return S.LP.Durability.Value
    end)

    if not okDur or durValue < durability then
        return
    end

    local machinesFolder = workspace:FindFirstChild("machinesFolder")

    if not machinesFolder then
        return
    end

    for _, v in pairs(machinesFolder:GetDescendants()) do
        if v.Name == "neededDurability" and v.Value == durability then
            local rockPart = v.Parent and v.Parent:FindFirstChild("Rock")

            if rockPart then
                H.SafeTouchInterest(rockPart, rightHand)
                H.SafeTouchInterest(rockPart, leftHand)
            end
        end
    end
end

R.RockSystem:Paragraph({
    Title = "Farm Timer",
    Desc = "Time: 00:00:00"
})

R.RockCounter = R.RockSystem:Paragraph({
    Title = "Time",
    Desc = "00:00:00"
})

task.spawn(function()
    while task.wait(1) do
        if MH.Gen ~= myGen then
            break
        end

        if V.AutoRock then
            V.RockTime = V.RockTime + 1
        end

        if R.RockCounter then
            R.RockCounter:SetDesc(H.RockFormatTime(V.RockTime))
        end
    end
end)

R.RockDropdown = R.RockSystem:Dropdown({
    Title = "Select Rock",
    Values = D.rockNames,
    Value = V.SelectedRock ~= "" and V.SelectedRock or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(val)
        V.SelectedRock = val
    end
})

R.AutoRockToggle = R.RockSystem:Toggle({
    Title = "Auto Farm Rock",
    Value = V.AutoRock,
    Callback = function(state)
        V.AutoRock = state

        if C.RockCharConn then
            C.RockCharConn:Disconnect()
            C.RockCharConn = nil
        end

        if not state then
            return
        end

        C.RockCharConn = S.LP.CharacterAdded:Connect(function(char)
            if not V.AutoRock then
                return
            end

            char:WaitForChild("Humanoid", 10)
            task.wait(1)
        end)

        H.RockPunch(function()
            return V.AutoRock
        end)

        task.spawn(function()
            while V.AutoRock do
                local char = S.LP.Character

                if char and char.Parent then
                    H.FarmRock(char)
                end

                task.wait(0.01)
            end
        end)
    end
})

R.ToolsSystem = R.SimpleFarm:Section({
    Title = "Auto Tools",
    Icon = "dumbbell"
})

D.toolList = D.toolList or {
    { name = "Weight", rep = "repTime", default = 1 },
    { name = "Pushups", rep = "repTime", default = 1 },
    { name = "Situps", rep = "repTime", default = 1 },
    { name = "Handstands", rep = "repTime", default = 1 },
    { name = "Punch", rep = "attackTime", default = 0.35 },
}

D.toolNames = {}

for _, tool in pairs(D.toolList) do
    table.insert(D.toolNames, tool.name)
end

V.SelectedTool = V.SelectedTool or ""
V.AutoTool = V.AutoTool or false
V.FastTools = V.FastTools or false

function H.ToolEquip(toolName)
    local character = S.LP.Character
    local backpack = S.LP:FindFirstChild("Backpack")

    if not character or not backpack or not toolName or toolName == "" then
        return
    end

    local tool = backpack:FindFirstChild(toolName)
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if tool and humanoid and not character:FindFirstChild(toolName) then
        humanoid:EquipTool(tool)
    end
end

function H.ToolUnequip(toolName)
    local character = S.LP.Character

    if not character or not toolName or toolName == "" then
        return
    end

    local tool = character:FindFirstChild(toolName)

    if tool then
        tool.Parent = S.LP.Backpack
    end
end

function H.ToolFireMuscle(action, hand)
    pcall(function()
        if hand then
            S.LP.muscleEvent:FireServer(action, hand)
        else
            S.LP.muscleEvent:FireServer(action)
        end
    end)
end

H.ToolPunch = H.PunchLoop

R.ToolsSystem:Button({
    Title = "Gamepass AutoLift",
    Callback = function()
        for _, gamepass in pairs(S.RS.gamepassIds:GetChildren()) do
            local value = Instance.new("IntValue")

            value.Name = gamepass.Name
            value.Value = gamepass.Value
            value.Parent = S.LP.ownedGamepasses
        end
    end
})

R.ToolDropdown = R.ToolsSystem:Dropdown({
    Title = "Select Tool",
    Values = D.toolNames,
    Value = V.SelectedTool ~= "" and V.SelectedTool or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(val)
        V.SelectedTool = val
    end
})

R.AutoToolToggle = R.ToolsSystem:Toggle({
    Title = "Auto Use Tool",
    Value = V.AutoTool,
    Callback = function(state)
        V.AutoTool = state

        if C.ToolCharConn then
            C.ToolCharConn:Disconnect()
            C.ToolCharConn = nil
        end

        if not state then
            H.ToolUnequip(V.SelectedTool)
            return
        end

        if not V.SelectedTool or V.SelectedTool == "" then
            return
        end

        if V.SelectedTool == "Punch" then
            H.ToolPunch(function()
                return V.AutoTool and V.SelectedTool == "Punch"
            end)

            C.ToolCharConn = S.LP.CharacterAdded:Connect(function(char)
                if not V.AutoTool or V.SelectedTool ~= "Punch" then
                    return
                end

                char:WaitForChild("Humanoid", 10)
                task.wait(1)
            end)
        else
            H.ToolEquip(V.SelectedTool)

            task.spawn(function()
                while V.AutoTool do
                    local toolName = V.SelectedTool
                    local character = S.LP.Character

                    if character and toolName ~= "" and not character:FindFirstChild(toolName) then
                        H.ToolEquip(toolName)
                    end

                    H.ToolFireMuscle("rep")

                    task.wait(0.1)
                end
            end)
        end
    end
})

R.FastToolsToggle = R.ToolsSystem:Toggle({
    Title = "Fast Tools",
    Value = V.FastTools,
    Callback = function(state)
        V.FastTools = state

        for _, toolInfo in pairs(D.toolList) do
            local speed = state and 0 or toolInfo.default

            local backpackTool = S.LP.Backpack:FindFirstChild(toolInfo.name)

            if backpackTool and backpackTool:FindFirstChild(toolInfo.rep) then
                backpackTool[toolInfo.rep].Value = speed
            end

            local character = S.LP.Character

            if character then
                local equippedTool = character:FindFirstChild(toolInfo.name)

                if equippedTool and equippedTool:FindFirstChild(toolInfo.rep) then
                    equippedTool[toolInfo.rep].Value = speed
                end
            end
        end
    end
})

R.ToolsSystem:Paragraph({
    Title = "Tool + Rock",
    Desc = "Combina entrenamiento y daño al Rock"
})

D.comboToolList = D.comboToolList or {
    {
        name = "Auto Pushup + Punch Rock",
        toolName = "Pushups",
        rockName = "Industrial Rock",
        delay = 0.0001
    },
    {
        name = "Auto Situp + Punch Rock",
        toolName = "Situps",
        rockName = "Industrial Rock",
        delay = 0.0001
    },
    {
        name = "Auto Handstands + Punch Rock",
        toolName = "Handstands",
        rockName = "Industrial Rock",
        delay = 0.0001
    },
    {
        name = "Auto Weight + Punch Rock",
        toolName = "Weight",
        rockName = "Industrial Rock",
        delay = 0.0001
    },
}

D.comboToolNames = {}

for _, combo in pairs(D.comboToolList) do
    table.insert(D.comboToolNames, combo.name)
end

V.SelectedCombo = V.SelectedCombo or ""
V.AutoCombo = V.AutoCombo or false

H.ComboPunch = H.PunchLoop

function H.RunCombo(toolName, rockName, delay)
    local character = S.LP.Character

    if not character or not character.Parent then
        return
    end

    H.ToolFireMuscle("rep")

    local machinesFolder = workspace:FindFirstChild("machinesFolder")
    local rock = machinesFolder and machinesFolder:FindFirstChild(rockName)
    local leftHand = character:FindFirstChild("LeftHand")

    if rock and leftHand and rock:FindFirstChild("Rock") then
        H.SafeTouchInterest(rock.Rock, leftHand, delay)
    end

    H.ToolEquip(toolName)
end

R.ComboDropdown = R.ToolsSystem:Dropdown({
    Title = "Select Combo",
    Values = D.comboToolNames,
    Value = V.SelectedCombo ~= "" and V.SelectedCombo or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(val)
        V.SelectedCombo = val
    end
})

R.AutoComboToggle = R.ToolsSystem:Toggle({
    Title = "Auto Tool + Rock",
    Value = V.AutoCombo,
    Callback = function(state)
        V.AutoCombo = state

        if C.ComboCharConn then
            C.ComboCharConn:Disconnect()
            C.ComboCharConn = nil
        end

        if not state then
            for _, combo in pairs(D.comboToolList) do
                if combo.name == V.SelectedCombo then
                    H.ToolUnequip(combo.toolName)
                    break
                end
            end

            return
        end

        if not V.SelectedCombo or V.SelectedCombo == "" then
            return
        end

        H.ComboPunch(function()
            return V.AutoCombo
        end)

        C.ComboCharConn = S.LP.CharacterAdded:Connect(function(char)
            if not V.AutoCombo then
                return
            end

            char:WaitForChild("Humanoid", 10)
            task.wait(1)
        end)

        local function runComboLoop(character)
            task.spawn(function()
                while V.AutoCombo and character.Parent do
                    for _, combo in pairs(D.comboToolList) do
                        if combo.name == V.SelectedCombo then
                            H.RunCombo(
                                combo.toolName,
                                combo.rockName,
                                combo.delay
                            )
                            break
                        end
                    end

                    task.wait(0)
                end
            end)
        end

        if S.LP.Character then
            runComboLoop(S.LP.Character)
        end
    end
})

R.RebirthsSystem = R.SimpleFarm:Section({
    Title = "Farm Rebirths",
    Icon = "refresh-cw"
})

R.RebirthTargetInput = R.RebirthsSystem:Input({
    Title = "Rebirth Target",
    Placeholder = "Cantidad de Rebirths",
    Value = tostring(V.RebirthTarget or ""),
    Callback = function(text)
        local value = tonumber(text)

        if value and value > 0 then
            V.RebirthTarget = value
        end
    end
})

R.AutoRebirthTarget = R.RebirthsSystem:Toggle({
    Title = "Auto Rebirth Target",
    Value = V.AutoRebirthTarget,
    Callback = function(state)
        V.AutoRebirthTarget = state

        if state and V.AutoRebirthInfinite then
            R.AutoRebirthInfinite:Set(false)
            V.AutoRebirthInfinite = false
        end

        if not state then
            if not V.AutoRebirthInfinite then
                pcall(function()
                    local character = S.LP.Character
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

                    if humanoid then
                        humanoid:UnequipTools()
                    end
                end)
            end

            return
        end

        if not V.RebirthTarget or V.RebirthTarget <= 0 then
            R.AutoRebirthTarget:Set(false)
            V.AutoRebirthTarget = false
            return
        end

        task.spawn(function()
            while V.AutoRebirthTarget do
                if not V.AutoRebirthTarget then
                    break
                end

                pcall(function()
                    local character = S.LP.Character
                    local backpack = S.LP:FindFirstChild("Backpack")
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

                    if character and backpack and humanoid then
                        local weight = character:FindFirstChild("Weight")

                        if not weight then
                            weight = backpack:FindFirstChild("Weight")

                            if weight then
                                humanoid:EquipTool(weight)
                            end
                        end
                    end
                end)

                pcall(function()
                    S.LP.muscleEvent:FireServer("rep")
                end)

                task.wait(0.05)

                local ok, current = pcall(function()
                    return S.LP.leaderstats.Rebirths.Value
                end)

                if ok and current >= V.RebirthTarget then
                    R.AutoRebirthTarget:Set(false)
                    V.AutoRebirthTarget = false

                    pcall(function()
                        local character = S.LP.Character
                        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

                        if humanoid then
                            humanoid:UnequipTools()
                        end
                    end)

                    break
                end

                pcall(function()
                    S.RS.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end)
            end
        end)
    end
})

R.AutoRebirthInfinite = R.RebirthsSystem:Toggle({
    Title = "Auto Rebirth Infinite",
    Value = V.AutoRebirthInfinite,
    Callback = function(state)
        V.AutoRebirthInfinite = state

        if state and V.AutoRebirthTarget then
            R.AutoRebirthTarget:Set(false)
            V.AutoRebirthTarget = false
        end

        if not state then
            if not V.AutoRebirthTarget then
                pcall(function()
                    local character = S.LP.Character
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

                    if humanoid then
                        humanoid:UnequipTools()
                    end
                end)
            end

            return
        end

        task.spawn(function()
            while V.AutoRebirthInfinite do
                if not V.AutoRebirthInfinite then
                    break
                end

                pcall(function()
                    local character = S.LP.Character
                    local backpack = S.LP:FindFirstChild("Backpack")
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

                    if character and backpack and humanoid then
                        local weight = character:FindFirstChild("Weight")

                        if not weight then
                            weight = backpack:FindFirstChild("Weight")

                            if weight then
                                humanoid:EquipTool(weight)
                            end
                        end
                    end
                end)

                pcall(function()
                    S.LP.muscleEvent:FireServer("rep")
                end)

                task.wait(0.05)

                pcall(function()
                    S.RS.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                end)
            end
        end)
    end
})

R.RebirthsSystem:Paragraph({
    Title = "Información",
    Desc = "Primero Oprime El Boton (Teleport King) Y Despues Aprieta Lock Position"
})

R.RebirthLockPosition = R.RebirthsSystem:Toggle({
    Title = "Lock Position",
    Value = V.RebirthLockPosition,
    Callback = function(state)
        V.RebirthLockPosition = state

        if St.rebirthLockPosConn then
            St.rebirthLockPosConn:Disconnect()
            St.rebirthLockPosConn = nil
        end

        if C.RebirthLockPosCharConn then
            C.RebirthLockPosCharConn:Disconnect()
            C.RebirthLockPosCharConn = nil
        end

        local function applyRebirthLock(character)
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local root = character and character:FindFirstChild("HumanoidRootPart")

            if not humanoid or not root then
                return
            end

            if St.rebirthLockPosConn then
                St.rebirthLockPosConn:Disconnect()
                St.rebirthLockPosConn = nil
            end

            if V.RebirthLockPosition then
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
                humanoid.AutoRotate = false
                humanoid:ChangeState(Enum.HumanoidStateType.Physics)

                local savedCFrame = root.CFrame

                St.rebirthLockPosConn = S.Run.Heartbeat:Connect(function()
                    if not V.RebirthLockPosition then
                        return
                    end

                    local character = S.LP.Character

                    if not character then
                        return
                    end

                    local root = character:FindFirstChild("HumanoidRootPart")

                    if not root then
                        return
                    end

                    root.Velocity = Vector3.zero
                    root.RotVelocity = Vector3.zero
                    root.CFrame = savedCFrame
                end)
            else
                humanoid.WalkSpeed = 250
                humanoid.JumpPower = 50
                humanoid.AutoRotate = true
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end

        if S.LP.Character then
            applyRebirthLock(S.LP.Character)
        end

        if state then
            C.RebirthLockPosCharConn = S.LP.CharacterAdded:Connect(function(character)
                if V.RebirthLockPosition then
                    task.wait(1)
                    applyRebirthLock(character)
                end
            end)
        end
    end
})

R.AutoTeleportKingButton = R.RebirthsSystem:Button({
    Title = "Teleport King",
    Callback = function()
        local character = S.LP.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if root then
            local base = Vector3.new(-8636, 17, -5759)

            local offset = Vector3.new(
                (math.random() * 2 - 1) * 0.3,
                0,
                (math.random() * 2 - 1) * 0.3
            )

            root.CFrame = CFrame.new(base + offset)
        end
    end
})

R.RebirthsSystem:Button({
    Title = "Anti Rebirth",
    Callback = function()
        if not hookmetamethod or not newcclosure then
            pcall(function()
                S.StarterGui:SetCore("SendNotification", {
                    Title = "Mystery Hub",
                    Text = "Anti Rebirth no soportado por tu executor",
                    Duration = 3
                })
            end)

            return
        end

        if C.AntiRebirthHooked then
            pcall(function()
                S.StarterGui:SetCore("SendNotification", {
                    Title = "Mystery Hub",
                    Text = "Anti Rebirth ya estaba activo",
                    Duration = 3
                })
            end)

            return
        end

        C.AntiRebirthHooked = true

        local oldNamecall

        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()

            local ok, name = pcall(function()
                return self.Name
            end)

            if ok and name and (method == "InvokeServer" or method == "FireServer") then
                if string.find(string.lower(name), "rebirth") then
                    return nil
                end
            end

            return oldNamecall(self, ...)
        end))

        pcall(function()
            S.StarterGui:SetCore("SendNotification", {
                Title = "Mystery Hub",
                Text = "Rebirths bloqueados permanentemente",
                Duration = 3
            })
        end)
    end
})

V.AutoWinBrawl = V.AutoWinBrawl or false
V.BrawlPhase = V.BrawlPhase or "IDLE"
V.BrawlBusy = V.BrawlBusy or false
V.BrawlCombat = V.BrawlCombat or false
V.BrawlJoined = V.BrawlJoined or false
V.BrawlJoinSent = V.BrawlJoinSent or false
V.BrawlChosen = V.BrawlChosen or nil
V.BrawlBaselineWins = V.BrawlBaselineWins or nil
V.BrawlReturnCFrame = V.BrawlReturnCFrame or nil
V.BrawlMovement = V.BrawlMovement or nil
V.BrawlLastWin = V.BrawlLastWin or false
V.BrawlSizeInvokeBusy = V.BrawlSizeInvokeBusy or false
V.BrawlLastSizeInvoke = V.BrawlLastSizeInvoke or 0

C.BrawlRunning = C.BrawlRunning or false
C.BrawlFinishToken = C.BrawlFinishToken or 0

Refs.BrawlState = Refs.BrawlState or S.RS
    :WaitForChild("shared")
    :WaitForChild("state")
    :WaitForChild("Brawl")

Refs.BrawlEvent = Refs.BrawlEvent or S.RS
    :WaitForChild("rEvents")
    :WaitForChild("brawlEvent")

function H.BrawlInside(target)
    local character = target and target.Character

    return character ~= nil
        and character:GetAttribute("LastMapCFrame") ~= nil
end

function H.BrawlInBattle(target)
    local character = target and target.Character

    return character ~= nil
        and character:GetAttribute("InBattle") == true
end

function H.BrawlWins()
    local leaderstats = S.LP:FindFirstChild("leaderstats")
    local brawls = leaderstats and leaderstats:FindFirstChild("Brawls")

    if not brawls then
        return nil
    end

    local value = tonumber(brawls.Value)

    if not value then
        return nil
    end

    return math.floor(value)
end

function H.BrawlPromptVisible()
    local playerGui = S.LP:FindFirstChild("PlayerGui")
    local gameGui = playerGui and playerGui:FindFirstChild("gameGui")
    local prompt = gameGui and gameGui:FindFirstChild("brawlJoinLabel")

    return prompt ~= nil and prompt.Visible == true
end

function H.BrawlProtected(target)
    if not target or target == S.LP then
        return true
    end

    local character = target.Character

    if not character then
        return true
    end

    local protectedUntil = character:GetAttribute("SpawnProtectedUntil")

    if type(protectedUntil) == "number"
        and workspace:GetServerTimeNow() < protectedUntil then
        return true
    end

    if character:FindFirstChildOfClass("ForceField")
        or character:FindFirstChild("spawnProtectionHighlight") then
        return true
    end

    if character:GetAttribute("InTinyIsland") == true then
        return true
    end

    return false
end

function H.KSetSizeOne()
    local now = time()

    if V.BrawlSizeInvokeBusy
        or now - V.BrawlLastSizeInvoke < 0.15 then
        return
    end

    local events = S.RS:FindFirstChild("rEvents")

    if not events then
        return
    end

    local remote = events:FindFirstChild("changeSpeedSizeRemote")

    if not remote then
        return
    end

    V.BrawlSizeInvokeBusy = true
    V.BrawlLastSizeInvoke = now

    task.spawn(function()
        pcall(function()
            remote:InvokeServer("changeSize", 1)
        end)

        V.BrawlSizeInvokeBusy = false
    end)
end

function H.BrawlTargets()
    local targets = {}
    local added = {}

    if not V.BrawlCombat
        or not H.BrawlInside(S.LP)
        or not H.BrawlInBattle(S.LP) then
        return targets
    end

    local function add(target)
        if not target
            or target == S.LP
            or added[target.UserId]
            or H.BrawlProtected(target) then
            return
        end

        local character = target.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if not humanoid
            or humanoid.Health <= 0
            or not root
            or not H.BrawlInside(target)
            or not H.BrawlInBattle(target)
            or H.BrawlProtected(target) then
            return
        end

        added[target.UserId] = true

        targets[#targets + 1] = {
            player = target,
            health = humanoid.Health
        }
    end

    add(V.BrawlChosen)

    for _, target in ipairs(S.Players:GetPlayers()) do
        add(target)
    end

    table.sort(targets, function(a, b)
        if a.player == V.BrawlChosen then
            return true
        end

        if b.player == V.BrawlChosen then
            return false
        end

        return a.health < b.health
    end)

    return targets
end

function H.BrawlRestore()
    local character = S.LP.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if character
        and root
        and typeof(V.BrawlReturnCFrame) == "CFrame" then

        pcall(function()
            character:PivotTo(V.BrawlReturnCFrame)
        end)

        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end

    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid and type(V.BrawlMovement) == "table" then
        pcall(function()
            humanoid.WalkSpeed = V.BrawlMovement.walkSpeed
            humanoid.AutoRotate = V.BrawlMovement.autoRotate

            if V.BrawlMovement.usesJumpPower then
                humanoid.JumpPower = V.BrawlMovement.jumpValue
            else
                humanoid.JumpHeight = V.BrawlMovement.jumpValue
            end
        end)
    end

    V.BrawlReturnCFrame = nil
    V.BrawlMovement = nil
end

function H.BrawlPrepare()
    if not V.BrawlBusy then
        V.BrawlBaselineWins = H.BrawlWins()

        local character = S.LP.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        V.BrawlReturnCFrame = root and root.CFrame or nil

        V.BrawlMovement = humanoid and {
            walkSpeed = humanoid.WalkSpeed,
            autoRotate = humanoid.AutoRotate,
            usesJumpPower = humanoid.UseJumpPower,
            jumpValue = humanoid.UseJumpPower
                and humanoid.JumpPower
                or humanoid.JumpHeight
        } or nil
    end

    V.BrawlBusy = true
    V.BrawlCombat = false
    V.BrawlJoined = H.BrawlInside(S.LP)
    V.BrawlJoinSent = false
    V.BrawlChosen = nil

    V.BrawlPhase =
        V.BrawlJoined
        and "WAITING"
        or "JOINING"
end

function H.BrawlFinish()
    if not V.BrawlBusy and V.BrawlPhase == "IDLE" then
        return
    end

    C.BrawlFinishToken = C.BrawlFinishToken + 1

    local token = C.BrawlFinishToken

    V.BrawlPhase = "RESTORING"
    V.BrawlCombat = false
    V.BrawlChosen = nil

    task.spawn(function()
        local deadline = os.clock() + 15

        while V.AutoWinBrawl
            and token == C.BrawlFinishToken
            and H.BrawlInside(S.LP)
            and os.clock() < deadline do

            if Refs.BrawlState:GetAttribute("BrawlInProgress") ~= true then
                break
            end

            task.wait(0.25)
        end

        if token ~= C.BrawlFinishToken then
            return
        end

        local wins = H.BrawlWins()

        V.BrawlLastWin =
            wins ~= nil
            and V.BrawlBaselineWins ~= nil
            and wins > V.BrawlBaselineWins

        H.BrawlRestore()

        V.BrawlBusy = false
        V.BrawlCombat = false
        V.BrawlJoined = false
        V.BrawlJoinSent = false
        V.BrawlChosen = nil
        V.BrawlPhase = "IDLE"
        V.BrawlBaselineWins = nil
    end)
end

function H.BrawlCombatLoop()
    if C.BrawlRunning then
        return
    end

    C.BrawlRunning = true

    task.spawn(function()
        while V.AutoWinBrawl and V.BrawlCombat do
            local targets = H.BrawlTargets()
            local killedAny = false

            for _, data in ipairs(targets) do
                if not V.AutoWinBrawl
                    or not V.BrawlCombat then
                    break
                end

                local target = data.player

                if target
                    and target ~= S.LP
                    and target.Character then

                    local humanoid =
                        target.Character:FindFirstChildOfClass("Humanoid")

                    local root =
                        target.Character:FindFirstChild("HumanoidRootPart")

                    if humanoid
                        and humanoid.Health > 0
                        and root
                        and H.BrawlInside(target)
                        and H.BrawlInBattle(target)
                        and not H.BrawlProtected(target) then

                        killedAny = true

                        tpAndKill(target, function()
                            return V.AutoWinBrawl
                                and V.BrawlCombat
                                and H.BrawlInside(S.LP)
                                and H.BrawlInBattle(S.LP)
                                and H.BrawlInside(target)
                                and H.BrawlInBattle(target)
                        end)
                    end
                end
            end

            task.wait(killedAny and 0.05 or 0.15)
        end

        C.BrawlRunning = false
    end)
end

function H.BrawlBegin()
    if not V.AutoWinBrawl
        or not H.BrawlInside(S.LP) then
        return false
    end

    if not V.BrawlBusy then
        H.BrawlPrepare()
    end

    V.BrawlJoined = true
    V.BrawlCombat = true
    V.BrawlPhase = "FIGHTING"
    V.BrawlChosen = nil

    H.BrawlCombatLoop()

    return true
end

function H.BrawlJoin()
    if not V.AutoWinBrawl
        or V.BrawlJoinSent
        or Refs.BrawlState:GetAttribute("BrawlInProgress") ~= true
        or Refs.BrawlState:GetAttribute("BrawlStarted") == true then
        return false
    end

    H.BrawlPrepare()
    H.KSetSizeOne()

    V.BrawlJoinSent = true

    local success = pcall(function()
        Refs.BrawlEvent:FireServer("joinBrawl")
    end)

    if not success then
        V.BrawlJoinSent = false
        H.BrawlFinish()
        return false
    end

    return true
end

function H.SetAutoWinBrawl(state)
    V.AutoWinBrawl = state == true

    if not V.AutoWinBrawl then
        C.BrawlFinishToken = C.BrawlFinishToken + 1

        V.BrawlCombat = false
        V.BrawlBusy = false
        V.BrawlJoined = false
        V.BrawlJoinSent = false
        V.BrawlChosen = nil
        V.BrawlPhase = "IDLE"

        H.BrawlRestore()

        return true
    end

    if Refs.BrawlState:GetAttribute("BrawlStarted") == true then
        H.BrawlBegin()
    elseif H.BrawlPromptVisible() then
        H.BrawlJoin()
    end

    return true
end

Refs.BrawlEvent.OnClientEvent:Connect(function(action, ...)
    if not V.AutoWinBrawl then
        return
    end

    if action == "brawlStarting" then
        V.BrawlJoinSent = false

        task.defer(function()
            if V.AutoWinBrawl then
                H.BrawlJoin()
            end
        end)

    elseif action == "joinedBrawl" then
        if not V.BrawlBusy then
            H.BrawlPrepare()
        end

        V.BrawlJoined = true
        V.BrawlPhase = "WAITING"

    elseif action == "beginBrawl" then
        H.BrawlBegin()

    elseif action == "playerChosen" then
        local chosen = select(1, ...)

        if typeof(chosen) == "Instance"
            and chosen:IsA("Player")
            and chosen ~= S.LP
            and H.BrawlInBattle(S.LP) then

            V.BrawlChosen = chosen
        else
            V.BrawlChosen = nil
        end

    elseif action == "noOtherBrawlers"
        or action == "endBrawl" then

        H.BrawlFinish()
    end
end)

Refs.BrawlState:GetAttributeChangedSignal("BrawlStarted"):Connect(function()
    if not V.AutoWinBrawl then
        return
    end

    if Refs.BrawlState:GetAttribute("BrawlStarted") == true then
        H.BrawlBegin()
    elseif Refs.BrawlState:GetAttribute("BrawlInProgress") ~= true then
        H.BrawlFinish()
    end
end)

Refs.BrawlState:GetAttributeChangedSignal("BrawlInProgress"):Connect(function()
    if not V.AutoWinBrawl then
        return
    end

    if Refs.BrawlState:GetAttribute("BrawlInProgress") ~= true
        and V.BrawlBusy then

        H.BrawlFinish()
    end
end)

R.Brawls = R.SimpleFarm:Section({
    Title = "Brawls",
    Icon = "swords"
})

R.Brawls:Toggle({
    Title = "Auto Win Brawl",
    Value = V.AutoWinBrawl,
    Callback = function(state)
        H.SetAutoWinBrawl(state)
    end
})

V.AutoBoss = false

local BossFarm = {
    active = false,
    generation = 0,
    engagedBoss = nil,
    originalCharacter = nil,
    originalPivot = nil,
    originalSize = nil,
    originalRootAnchored = nil,
    lastPlayerHealth = nil,
    safeAttackPosition = nil,
    cameraSaved = nil,
    cameraFocusPosition = nil,
    cameraStableCFrame = nil,
    cameraShakeHooks = nil,
    cameraRenderName = "MysteryHubBossCamera",
    antiLag = false,
    antiLagOriginals = setmetatable({}, {__mode = "k"}),
    antiLagConnection = nil,
    hitInterval = 0.31,
    attacks = 0,
    confirmedDamage = 0,
    durabilityRunning = false,
    durabilityGeneration = 0,
    safetyTriggered = false
}

H.BossFarm = BossFarm

local function getCharacter()
    return S.LP.Character
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getDurability()
    local durability = S.LP:FindFirstChild("Durability")

    if not durability then
        return 0
    end

    return tonumber(durability.Value) or 0
end

local function findBoss()
    for _, boss in ipairs(S.CollectionService:GetTagged("BossEventBoss")) do
        if boss and boss.Parent then
            local part =
                boss:FindFirstChild("BossDamageHitbox", true)
                or boss.PrimaryPart
                or boss:FindFirstChild("Boss", true)
                or boss:FindFirstChild("Head", true)
                or boss:FindFirstChildWhichIsA("BasePart", true)

            if part and part:IsA("BasePart") then
                local target =
                    boss:FindFirstChild("Boss")
                    or boss:FindFirstChild("Head", true)
                    or boss.PrimaryPart
                    or part

                if not target:IsA("BasePart") then
                    target = part
                end

                return boss, part, target
            end
        end
    end
end

local function getBossHealth()
    return math.max(
        0,
        tonumber(workspace:GetAttribute("BossHealth")) or 0
    )
end

local function setCharacterSize(size)
    local events = S.RS:FindFirstChild("rEvents")
    local remote = events and events:FindFirstChild("changeSpeedSizeRemote")

    if not remote then
        return false
    end

    size = math.clamp(
        math.floor((tonumber(size) or 2) + 0.5),
        1,
        100
    )

    if remote:IsA("RemoteEvent") then
        return pcall(
            remote.FireServer,
            remote,
            "changeSize",
            size
        )
    end

    if remote:IsA("RemoteFunction") then
        return pcall(
            remote.InvokeServer,
            remote,
            "changeSize",
            size
        )
    end

    return false
end

local function getCharacterSize()
    local humanoid = getHumanoid()
    local scale = humanoid and humanoid:FindFirstChild("BodyHeightScale")

    return math.clamp(
        math.floor(((scale and scale.Value) or 2) + 0.5),
        1,
        100
    )
end

local function equipBossPunch()
    local char = getCharacter()
    local humanoid = getHumanoid()
    local backpack = S.LP:FindFirstChild("Backpack")

    local punch =
        char and char:FindFirstChild("Punch")
        or backpack and backpack:FindFirstChild("Punch")

    if punch and humanoid and punch.Parent ~= char then
        pcall(
            humanoid.EquipTool,
            humanoid,
            punch
        )

        S.Run.Heartbeat:Wait()
    end

    local attackTime = punch and punch:FindFirstChild("attackTime")

    if attackTime and attackTime:IsA("ValueBase") then
        attackTime.Value = 0
    end

    return punch
end

function BossFarm:ApplyAntiLagObject(object)
    if not self.antiLag or not object then
        return
    end

    local property

    if object:IsA("ParticleEmitter")
        or object:IsA("Trail")
        or object:IsA("Beam")
        or object:IsA("Fire")
        or object:IsA("Smoke")
        or object:IsA("Sparkles")
        or object:IsA("PointLight")
        or object:IsA("SpotLight")
        or object:IsA("SurfaceLight")
        or object:IsA("Highlight") then

        property = "Enabled"

    elseif object:IsA("BasePart") then
        property = "CastShadow"
    end

    if property and self.antiLagOriginals[object] == nil then
        self.antiLagOriginals[object] = {
            property = property,
            value = object[property]
        }

        pcall(function()
            object[property] = false
        end)
    end
end

function BossFarm:SetAntiLag(enabled)
    enabled = enabled == true
    self.antiLag = enabled

    if self.antiLagConnection then
        self.antiLagConnection:Disconnect()
        self.antiLagConnection = nil
    end

    if not enabled then
        for object, saved in pairs(self.antiLagOriginals) do
            if object and object.Parent then
                pcall(function()
                    object[saved.property] = saved.value
                end)
            end

            self.antiLagOriginals[object] = nil
        end

        return true
    end

    local events = workspace:FindFirstChild("Events")
    local arena = events and events:FindFirstChild("BossArena")

    if not arena then
        self.antiLag = false
        return false
    end

    for _, object in ipairs(arena:GetDescendants()) do
        self:ApplyAntiLagObject(object)
    end

    self.antiLagConnection = arena.DescendantAdded:Connect(function(object)
        task.defer(function()
            self:ApplyAntiLagObject(object)
        end)
    end)

    return true
end

function BossFarm:StopCamera()
    pcall(
        S.Run.UnbindFromRenderStep,
        S.Run,
        self.cameraRenderName
    )

    local camera = workspace.CurrentCamera
    local saved = self.cameraSaved

    if camera and saved then
        pcall(function()
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = saved.cframe
            camera.Focus = saved.focus

            if saved.subject and saved.subject.Parent then
                camera.CameraSubject = saved.subject
            end

            camera.CameraType = saved.cameraType
        end)
    end

    self.cameraSaved = nil
    self.cameraFocusPosition = nil
    self.cameraStableCFrame = nil
    self.cameraShakeHooks = nil
end

function BossFarm:StartCamera()
    self:StopCamera()

    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    self.cameraSaved = {
        cameraType = camera.CameraType,
        subject = camera.CameraSubject,
        cframe = camera.CFrame,
        focus = camera.Focus
    }

    camera.CameraType = Enum.CameraType.Scriptable

    S.Run:BindToRenderStep(
        self.cameraRenderName,
        Enum.RenderPriority.Camera.Value + 50,
        function(delta)
            local focus = self.cameraFocusPosition
            local currentCamera = workspace.CurrentCamera

            if not self.engagedBoss
                or not focus
                or not currentCamera then
                return
            end

            local desired = CFrame.lookAt(
                focus + Vector3.new(0, 34, 48),
                focus + Vector3.new(0, -5, 0)
            )

            self.cameraStableCFrame =
                self.cameraStableCFrame
                and self.cameraStableCFrame:Lerp(
                    desired,
                    math.clamp(delta * 4, 0.04, 0.22)
                )
                or desired

            currentCamera.CameraType = Enum.CameraType.Scriptable
            currentCamera.CFrame = self.cameraStableCFrame
            currentCamera.Focus = CFrame.new(focus)
        end
    )
end

function BossFarm:WaitForReadyCharacter(timeout)
    local deadline = os.clock() + (tonumber(timeout) or 8)
    local stableCharacter
    local stableRoot
    local stableAt

    while self.active and os.clock() < deadline do
        local character = getCharacter()
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local machine = S.LP:FindFirstChild("machineInUse")

        local mounted =
            machine and machine.Value ~= nil
            or humanoid and humanoid.SeatPart ~= nil

        if character
            and root
            and humanoid
            and humanoid.Health > 0
            and not mounted then

            if character ~= stableCharacter
                or root ~= stableRoot then

                stableCharacter = character
                stableRoot = root
                stableAt = os.clock()

            elseif os.clock() - stableAt >= 0.18 then
                return character, root, humanoid
            end
        else
            stableCharacter = nil
            stableRoot = nil
            stableAt = nil
        end

        task.wait(0.05)
    end
end

local function getBestRock()
    local folder = workspace:FindFirstChild("machinesFolder")

    if not folder then
        return
    end

    local durability = getDurability()
    local bestRock
    local bestRequirement = -math.huge

    for _, machine in ipairs(folder:GetChildren()) do
        local needed = machine:FindFirstChild("neededDurability", true)
        local rock = machine:FindFirstChild("Rock", true)

        if needed
            and rock
            and rock:IsA("BasePart") then

            local requirement = tonumber(needed.Value) or 0

            if requirement <= durability
                and requirement > bestRequirement then

                bestRequirement = requirement

                bestRock = {
                    machine = machine,
                    rock = rock,
                    durability = requirement
                }
            end
        end
    end

    return bestRock
end

function BossFarm:StopDurability()
    self.durabilityRunning = false
    self.durabilityGeneration = self.durabilityGeneration + 1
end

function BossFarm:StartDurability()
    self.durabilityRunning = true
    self.durabilityGeneration = self.durabilityGeneration + 1

    local generation = self.durabilityGeneration

    task.spawn(function()
        while self.active
            and self.durabilityRunning
            and self.durabilityGeneration == generation do

            local character = getCharacter()
            local root = getRoot()
            local humanoid = getHumanoid()

            if not character
                or not root
                or not humanoid
                or humanoid.Health <= 0 then

                task.wait(0.1)
                continue
            end

            local rockData = getBestRock()

            if not rockData then
                task.wait(0.25)
                continue
            end

            local rock = rockData.rock

            local leftHand =
                character:FindFirstChild("LeftHand")
                or character:FindFirstChild("Left Arm")

            local rightHand =
                character:FindFirstChild("RightHand")
                or character:FindFirstChild("Right Arm")

            local punch = equipBossPunch()

            if not leftHand
                or not rightHand
                or not punch then

                task.wait(0.1)
                continue
            end

            local events = S.RS:FindFirstChild("rEvents")
            local muscleEvent =
                events and events:FindFirstChild("muscleEvent")

            if muscleEvent and muscleEvent:IsA("RemoteEvent") then
                pcall(function()
                    muscleEvent:FireServer(
                        "punch",
                        "leftHand"
                    )

                    muscleEvent:FireServer(
                        "punch",
                        "rightHand"
                    )
                end)
            end

            pcall(
                punch.Activate,
                punch
            )

            if firetouchinterest then
                pcall(function()
                    firetouchinterest(
                        rightHand,
                        rock,
                        0
                    )

                    firetouchinterest(
                        leftHand,
                        rock,
                        0
                    )
                end)

                task.wait(0.04)

                pcall(function()
                    firetouchinterest(
                        rightHand,
                        rock,
                        1
                    )

                    firetouchinterest(
                        leftHand,
                        rock,
                        1
                    )
                end)
            end

            task.wait(0.08)
        end
    end)
end

function BossFarm:BeginBattle(boss)
    if self.engagedBoss == boss then
        return true
    end

    local character, root, humanoid =
        self:WaitForReadyCharacter(8)

    if not character
        or not root
        or not humanoid
        or not boss.Parent
        or workspace:GetAttribute("BossActive") ~= true then

        return false
    end

    self.originalCharacter = character
    self.originalPivot = character:GetPivot()
    self.originalSize = getCharacterSize()
    self.originalRootAnchored = root.Anchored

    self.engagedBoss = boss
    self.confirmedDamage = 0
    self.attacks = 0
    self.safetyTriggered = false
    self.lastPlayerHealth = humanoid.Health
    self.safeAttackPosition = nil

    self:StartCamera()

    setCharacterSize(5)

    task.wait(0.55)

    humanoid = getHumanoid()

    if humanoid then
        self.lastPlayerHealth = humanoid.Health
    end

    self:StartDurability()

    return true
end

function BossFarm:RestoreBattle()
    self:StopDurability()

    local character = getCharacter()
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if character
        and character == self.originalCharacter
        and root
        and self.originalPivot then

        character:PivotTo(self.originalPivot)

        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero

        if self.originalRootAnchored ~= nil then
            root.Anchored = self.originalRootAnchored
        end
    end

    if self.originalSize then
        setCharacterSize(self.originalSize)
    end

    self:StopCamera()

    local backpack = S.LP:FindFirstChild("Backpack")
    local punch = character and character:FindFirstChild("Punch")

    if punch and backpack then
        punch.Parent = backpack
    end

    self.originalCharacter = nil
    self.originalPivot = nil
    self.originalSize = nil
    self.originalRootAnchored = nil
    self.engagedBoss = nil
    self.lastPlayerHealth = nil
    self.safeAttackPosition = nil
end

function BossFarm:CollectChest(timeout)
    if type(fireproximityprompt) ~= "function" then
        return false
    end

    local opened = false
    local connection

    local events = S.RS:FindFirstChild("rEvents")
    local openedEvent =
        events and events:FindFirstChild("bossChestOpenedEvent")

    if openedEvent and openedEvent:IsA("RemoteEvent") then
        connection = openedEvent.OnClientEvent:Connect(function()
            opened = true
        end)
    end

    local deadline = os.clock() + (tonumber(timeout) or 12)
    local pendingWasSeen = false
    local attempted = false
    local lastAttempt = 0

    while self.active and os.clock() < deadline do
        if opened then
            if connection then
                connection:Disconnect()
            end

            return true
        end

        local chestModel
        local prompt

        for _, candidate in ipairs(
            S.CollectionService:GetTagged("BossEventChest")
        ) do
            prompt =
                candidate:FindFirstChild(
                    "bossChestPrompt",
                    true
                )

            if prompt then
                chestModel = candidate
                break
            end
        end

        if not prompt then
            events = workspace:FindFirstChild("Events")

            prompt =
                events
                and events:FindFirstChild(
                    "bossChestPrompt",
                    true
                )

            chestModel =
                prompt
                and prompt:FindFirstAncestorOfClass("Model")
        end

        local eligible =
            S.LP:GetAttribute("BossChestEligible") == true

        local pending =
            S.LP:GetAttribute("BossChestPending") == true

        if pending then
            pendingWasSeen = true
        elseif attempted and pendingWasSeen then
            if connection then
                connection:Disconnect()
            end

            return true
        end

        local emerging =
            chestModel
            and chestModel:GetAttribute(
                "BossChestEmerging"
            ) == true

        if prompt
            and prompt:IsA("ProximityPrompt")
            and eligible
            and pending
            and not emerging then

            local character = getCharacter()
            local root = getRoot()
            local parent = prompt.Parent

            if character
                and root
                and parent
                and parent:IsA("BasePart") then

                character:PivotTo(
                    parent.CFrame
                    * CFrame.new(
                        0,
                        math.max(
                            4,
                            parent.Size.Y * 0.5 + 3
                        ),
                        0
                    )
                )

                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero

                task.wait(0.12)
            end

            if prompt.Enabled
                and os.clock() - lastAttempt >= 0.45 then

                lastAttempt = os.clock()

                attempted =
                    pcall(
                        fireproximityprompt,
                        prompt
                    )
                    or attempted
            end
        end

        task.wait(0.1)
    end

    if connection then
        connection:Disconnect()
    end

    return opened
        or (
            attempted
            and pendingWasSeen
            and S.LP:GetAttribute(
                "BossChestPending"
            ) ~= true
        )
end

function BossFarm:Fight(boss)
    if not self:BeginBattle(boss) then
        return
    end

    local lastHealth = getBossHealth()
    local lastAttack = 0

    while self.active
        and boss.Parent
        and workspace:GetAttribute("BossActive") == true do

        local currentBoss, part, target = findBoss()

        if currentBoss ~= boss
            or not part
            or not target then

            break
        end

        local character = getCharacter()
        local root = getRoot()
        local humanoid = getHumanoid()
        local punch = equipBossPunch()

        if not character
            or not root
            or not humanoid
            or humanoid.Health <= 0
            or not punch then

            task.wait(0.25)
        else
            if self.lastPlayerHealth
                and humanoid.Health < self.lastPlayerHealth then

                self.safetyTriggered = true
                self.active = false

                self:StopDurability()
                self:SetAntiLag(false)

                break
            end

            self.lastPlayerHealth = humanoid.Health

            local bossTop =
                target.Position.Y
                + target.Size.Y * 0.5

            local clearance =
                math.max(
                    6,
                    root.Size.Y * 0.5 + 4
                )

            local desiredPosition =
                Vector3.new(
                    part.Position.X,
                    bossTop + clearance,
                    part.Position.Z
                )

            if not self.safeAttackPosition
                or (
                    desiredPosition
                    - self.safeAttackPosition
                ).Magnitude > 45 then

                self.safeAttackPosition =
                    desiredPosition
            else
                self.safeAttackPosition =
                    self.safeAttackPosition:Lerp(
                        desiredPosition,
                        0.16
                    )
            end

            local attackPosition =
                self.safeAttackPosition

            local aimPosition =
                target.Position
                + Vector3.new(
                    0,
                    target.Size.Y * 0.32,
                    0
                )

            self.cameraFocusPosition =
                self.cameraFocusPosition
                and self.cameraFocusPosition:Lerp(
                    aimPosition,
                    0.08
                )
                or aimPosition

            character:PivotTo(
                CFrame.lookAt(
                    attackPosition,
                    aimPosition
                )
            )

            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero

            local now = os.clock()

            if now - lastAttack >= self.hitInterval then
                lastAttack = now

                pcall(
                    punch.Deactivate,
                    punch
                )

                pcall(
                    punch.Activate,
                    punch
                )

                local attackTime =
                    punch:FindFirstChild("attackTime")

                if attackTime
                    and attackTime:IsA("ValueBase") then

                    attackTime.Value = 0
                end

                self.attacks =
                    self.attacks + 1
            end

            local health = getBossHealth()

            if health < lastHealth then
                self.confirmedDamage =
                    self.confirmedDamage
                    + lastHealth
                    - health
            end

            lastHealth = health

            task.wait(0.04)
        end
    end

    local defeated =
        workspace:GetAttribute("BossActive") ~= true
        or getBossHealth() <= 0

    if defeated and self.active then
        self:CollectChest(12)
    end

    self:RestoreBattle()
end

function BossFarm:Set(enabled)
    enabled = enabled == true

    self.generation =
        self.generation + 1

    local generation =
        self.generation

    self.active = enabled

    if not enabled then
        self:RestoreBattle()
        self:SetAntiLag(false)
        return true
    end

    local config =
        S.RS:FindFirstChild("shared")

    config =
        config
        and config:FindFirstChild("config")

    config =
        config
        and config:FindFirstChild("BossEventConfig")

    local ok, values =
        pcall(function()
            return config and require(config)
        end)

    if not ok
        or type(values) ~= "table"
        or values.ENABLED ~= true then

        self.active = false
        self:SetAntiLag(false)

        return false
    end

    self:SetAntiLag(true)

    self.hitInterval =
        math.max(
            0.31,
            (tonumber(values.MIN_HIT_INTERVAL) or 0.3)
            + 0.01
        )

    task.spawn(function()
        while self.active
            and self.generation == generation do

            local boss = findBoss()

            if boss
                and workspace:GetAttribute("BossActive") == true then

                self:Fight(boss)
            else
                self.engagedBoss = nil
                task.wait(0.4)
            end
        end

        if self.generation == generation then
            self:RestoreBattle()
        end
    end)

    return true
end

R.BossFolder = R.SimpleFarm:Section({
    Title = "Auto Boss",
    Icon = "skull"
})

R.BossFolder:Toggle({
    Title = "Auto Boss",
    Value = V.AutoBoss,
    Callback = function(state)
        V.AutoBoss = state

        if state then
            local accepted = BossFarm:Set(true)

            if accepted == false then
                V.AutoBoss = false
            end
        else
            BossFarm:Set(false)
        end
    end
})

C.BossFarmCleanup = function()
    V.AutoBoss = false
    BossFarm.active = false
    BossFarm.generation =
        BossFarm.generation + 1

    BossFarm:StopDurability()
    BossFarm:RestoreBattle()
    BossFarm:SetAntiLag(false)
end

R.PacksFarm = R.Farming:Tab({
    Title = "Packs",
    Icon = "package",
    ShowTabTitle = true
})

function H.FormatRaw(n)
    n = math.floor(n or 0)
    local formatted = tostring(n)
    local sign = ""
    if formatted:sub(1, 1) == "-" then
        sign = "-"
        formatted = formatted:sub(2)
    end
    local result = formatted:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    result = result:gsub("^,", "")
    return sign .. result
end

function H.FormatNumber(n)
    n = n or 0
    local sign = n < 0 and "-" or ""
    n = math.abs(n)

    if n >= 1e15 then
        return sign .. string.format("%.2fQA", n / 1e15)
    elseif n >= 1e12 then
        return sign .. string.format("%.2fT", n / 1e12)
    elseif n >= 1e9 then
        return sign .. string.format("%.2fB", n / 1e9)
    elseif n >= 1e6 then
        return sign .. string.format("%.2fM", n / 1e6)
    elseif n >= 1e3 then
        return sign .. string.format("%.2fK", n / 1e3)
    else
        return sign .. string.format("%.0f", n)
    end
end

getgenv().AutoFarm = false

State = State or {}

State.FastRep = State.FastRep or {
    repsPerTick = 1,
    isRunning = false,
    currentPing = 0
}

function pingNow()
    local ok, ping = pcall(function()
        return S.Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)

    return ok, ping
end

task.spawn(function()
    while true do
        local ok, ping = pingNow()
        State.FastRep.currentPing = ok and ping or 999
        task.wait(1)
    end
end)

R.PacksFarm:Paragraph({
    Title = "Recommended Speed 40",
    Desc = "Recommended Speed 40"
})

R.PacksFarm:Input({
    Title = "Speed Of Reps",
    Placeholder = "40",
    Callback = function(value)
        local num = tonumber(value)

        if num and num > 0 then
            State.FastRep.repsPerTick = math.floor(num)
        end
    end
})

function fastRepLoop()
    while getgenv().AutoFarm do
        if State.FastRep.currentPing < 3000 then
            for _ = 1, State.FastRep.repsPerTick do
                Refs.muscleEvent:FireServer("rep")
            end
        end

        task.wait()
    end
end

R.PacksFarm:Toggle({
    Title = "Start",
    Value = false,
    Callback = function(state)
        getgenv().AutoFarm = state

        if state then
            if not State.Tracking.trackingStarted then
                State.Tracking.trackingStarted = true
                State.Tracking.startTime = tick()
                State.Tracking.strengthHistory = {}
                State.Tracking.durabilityHistory = {}
            end

            if not State.FastRep.isRunning then
                State.FastRep.isRunning = true

                task.spawn(function()
                    fastRepLoop()
                    State.FastRep.isRunning = false
                end)
            end
        else
            if State.Tracking.trackingStarted then
                State.Tracking.pausedElapsedTime += tick() - State.Tracking.startTime
                State.Tracking.trackingStarted = false
            end
        end
    end
})

State.EggState = {
    autoEat30m = false,
    autoEat01s = false,
    running30m = false,
    running01s = false
}

function eatProteinEgg()
    local char = player.Character or player.CharacterAdded:Wait()
    local backpack = player:WaitForChild("Backpack")
    local egg = backpack:FindFirstChild("Protein Egg") or char:FindFirstChild("Protein Egg")
    if not egg then return end

    if egg.Parent ~= char then
        egg.Parent = char
    end

    Refs.eggEvent:FireServer("proteinEgg", egg)
end

R.PacksFarm:Toggle({
    Title = "Eat Egg 30 Min",
    Value = false,
    Callback = function(state)
        State.EggState.autoEat30m = state

        if state and not State.EggState.running30m then
            State.EggState.running30m = true

            task.spawn(function()
                while State.EggState.autoEat30m do
                    eatProteinEgg()
                    task.wait(1800)
                end

                State.EggState.running30m = false
            end)
        end
    end
})

R.PacksFarm:Toggle({
    Title = "Fast Eat Egg",
    Value = false,
    Callback = function(state)
        State.EggState.autoEat01s = state

        if state and not State.EggState.running01s then
            State.EggState.running01s = true

            task.spawn(function()
                while State.EggState.autoEat01s do
                    eatProteinEgg()
                    task.wait(0.1)
                end

                State.EggState.running01s = false
            end)
        end
    end
})

State.AutoSpin = {
    enabled = false,
    isRunning = false
}

function autoSpinLoop()
    while State.AutoSpin.enabled do
        pcall(function()
            Refs.openFortuneWheelRemote:InvokeServer(
                "openFortuneWheel",
                Refs.fortuneWheelChances
            )
        end)

        task.wait(1)
    end

    State.AutoSpin.isRunning = false
end

R.PacksFarm:Toggle({
    Title = "Auto Spin",
    Value = false,
    Callback = function(state)
        State.AutoSpin.enabled = state

        if state and not State.AutoSpin.isRunning then
            State.AutoSpin.isRunning = true
            task.spawn(autoSpinLoop)
        end
    end
})

function teleportAndUseMachine(cf, machineName)
    local char = player.Character or player.CharacterAdded:Wait()
    char:WaitForChild("HumanoidRootPart").CFrame = cf
    task.wait(0.2)

    local machine = workspace.machinesFolder:FindFirstChild(machineName)

    if machine then
        Refs.rEvents.machineInteractRemote:InvokeServer(
            "useMachine",
            machine.interactSeat
        )
    end
end

R.PacksFarm:Button({
    Title = "Industrial Squat",
    Callback = function()
        teleportAndUseMachine(
            CFrame.new(-5219.5, 59, 5419.8),
            "Industrial Squat"
        )
    end
})

function forEachPet(petsFolder, callback)
    for _, folder in ipairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in ipairs(folder:GetChildren()) do
                callback(pet)
            end
        end
    end
end

R.PacksFarm:Button({
    Title = "Equip The Best Pets To Farm",
    Callback = function()
        if not player.Character then
            player.CharacterAdded:Wait()
        end

        local petsByName = {}

        forEachPet(Refs.petsFolder, function(pet)
            petsByName[pet.Name] = petsByName[pet.Name] or {}
            table.insert(petsByName[pet.Name], pet)
        end)

        local infernoCount = #(petsByName["Inferno Drake"] or {})

        local omegaCount = 5
        local powercoreCount = 7

        if infernoCount == 1 then
            omegaCount = 3
            powercoreCount = 8
        elseif infernoCount == 2 then
            omegaCount = 1
            powercoreCount = 9
        elseif infernoCount >= 3 then
            omegaCount = 0
            powercoreCount = 9
        end

        forEachPet(Refs.petsFolder, function(pet)
            Refs.equipPetEvent:FireServer("unequipPet", pet)
            task.wait(0.1)
        end)

        task.wait(0.1)

        local equipped = 0
        local target = 12

        local function equip(name, amount)
            local pool = petsByName[name] or {}
            local count = math.min(amount, #pool, target - equipped)

            for i = 1, count do
                Refs.equipPetEvent:FireServer("equipPet", pool[i])
                task.wait(0.1)
                equipped = equipped + 1
            end
        end

        equip("Inferno Drake", infernoCount)
        equip("Omega Overlord", omegaCount)
        equip("Powercore Hound", powercoreCount)

        local priority = {
            "Omega Overlord",
            "Swift Samurai",
            "Mythic Boss Pet",
            "Legendary Boss Pet",
            "Rainbow Boss Pet",
            "Epic Boss Pet",
            "Rare Boss Pet",
            "Common Boss Pet"
        }

        for _, name in ipairs(priority) do
            if equipped >= target then
                break
            end

            equip(name, target - equipped)
        end
    end
})

R.PacksFarm:Divider()

R.PacksFarmPing = R.PacksFarm:Paragraph({
    Title = "Ping",
    Desc = "Ping: 0 ms"
})

task.spawn(function()
    while true do
        local ok, ping = pingNow()

        if ok then
            R.PacksFarmPing:SetDesc("Ping: " .. math.floor(ping) .. " ms")
        else
            R.PacksFarmPing:SetDesc("Ping: ?")
        end

        task.wait(0.05)
    end
end)

R.PacksFarm:Paragraph({
    Title = "Farming Time",
    Desc = "Farming Time:"
})

FarmLabels = {
    stopwatch = R.PacksFarm:Paragraph({
        Title = "Tiempo",
        Desc = "0d 0h 0m 0s - Fast Rep Apagadas"
    }),

    projectedStrength = R.PacksFarm:Paragraph({
        Title = "Fuerza Aproximada",
        Desc = "Fuerza Aprox Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    }),

    projectedDurability = R.PacksFarm:Paragraph({
        Title = "Durabilidad Aproximada",
        Desc = "Durabilidad Aprox Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    }),

    averageStrength = R.PacksFarm:Paragraph({
        Title = "Promedio De Fuerza",
        Desc = "Promedio De Fuerza Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    }),

    averageDurability = R.PacksFarm:Paragraph({
        Title = "Promedio De Durabilidad",
        Desc = "Promedio De Durabilidad Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    })
}

R.PacksFarm:Divider()

R.PacksFarm:Paragraph({
    Title = "Stats",
    Desc = "Stats:"
})

FarmLabels.strength = R.PacksFarm:Paragraph({
    Title = "Fuerza",
    Desc = "Fuerza: 0 | Ganada: 0"
})

FarmLabels.durability = R.PacksFarm:Paragraph({
    Title = "Durabilidad",
    Desc = "Durabilidad: 0 | Ganada: 0"
})

State.Tracking = {
    startTime = 0,
    pausedElapsedTime = 0,
    trackingStarted = false,
    strengthHistory = {},
    durabilityHistory = {},
    calculationInterval = 10,
    initialStrength = Refs.strengthStat.Value,
    initialDurability = Refs.durabilityStat.Value,
}

function resetProjectionLabels()
    FarmLabels.projectedStrength:SetDesc(
        "Fuerza Aprox Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    )

    FarmLabels.projectedDurability:SetDesc(
        "Durabilidad Aprox Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    )

    FarmLabels.averageStrength:SetDesc(
        "Promedio De Fuerza Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    )

    FarmLabels.averageDurability:SetDesc(
        "Promedio De Durabilidad Por: 0 /Hora | 0 /Dia | 0 /Semana | 0 /Mes"
    )
end

function formatDuration(seconds)
    seconds = math.max(0, math.floor(seconds))
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60

    return string.format(
        "%dd %dh %dm %ds",
        days,
        hours,
        minutes,
        secs
    )
end

function formatCommas(value)
    local formatted = tostring(math.floor(tonumber(value) or 0))
    local result = formatted

    while true do
        local newResult, count = result:gsub(
            "^(-?%d+)(%d%d%d)",
            "%1,%2"
        )

        result = newResult

        if count == 0 then
            break
        end
    end

    return result
end

task.spawn(function()
    local lastCalcTime = tick()

    while true do
        local currentTime = tick()
        local currentStrength = Refs.strengthStat.Value
        local currentDurability = Refs.durabilityStat.Value

        FarmLabels.strength:SetDesc(
            "Fuerza: " ..
            formatShort(currentStrength) ..
            " | Ganada: " ..
            formatShort(
                currentStrength - State.Tracking.initialStrength
            )
        )

        FarmLabels.durability:SetDesc(
            "Durabilidad: " ..
            formatShort(currentDurability) ..
            " | Ganada: " ..
            formatShort(
                currentDurability - State.Tracking.initialDurability
            )
        )

        if State.Tracking.trackingStarted then
            local elapsedTime =
                State.Tracking.pausedElapsedTime +
                (currentTime - State.Tracking.startTime)

            FarmLabels.stopwatch:SetDesc(
                formatDuration(elapsedTime) ..
                " - Fast Rep Running"
            )

            table.insert(
                State.Tracking.strengthHistory,
                {
                    time = currentTime,
                    value = currentStrength
                }
            )

            table.insert(
                State.Tracking.durabilityHistory,
                {
                    time = currentTime,
                    value = currentDurability
                }
            )

            while #State.Tracking.strengthHistory > 0
                and currentTime -
                    State.Tracking.strengthHistory[1].time >
                    State.Tracking.calculationInterval do

                table.remove(
                    State.Tracking.strengthHistory,
                    1
                )
            end

            while #State.Tracking.durabilityHistory > 0
                and currentTime -
                    State.Tracking.durabilityHistory[1].time >
                    State.Tracking.calculationInterval do

                table.remove(
                    State.Tracking.durabilityHistory,
                    1
                )
            end

            if currentTime - lastCalcTime >=
                State.Tracking.calculationInterval then

                lastCalcTime = currentTime

                if #State.Tracking.strengthHistory >= 2 then
                    local sh = State.Tracking.strengthHistory

                    local sps =
                        (sh[#sh].value - sh[1].value) /
                        (sh[#sh].time - sh[1].time)

                    FarmLabels.projectedStrength:SetDesc(
                        "Fuerza Aprox Por: " ..
                        formatRate(sps)
                    )
                end

                if #State.Tracking.durabilityHistory >= 2 then
                    local dh = State.Tracking.durabilityHistory

                    local dps =
                        (dh[#dh].value - dh[1].value) /
                        (dh[#dh].time - dh[1].time)

                    FarmLabels.projectedDurability:SetDesc(
                        "Durabilidad Aprox Por: " ..
                        formatRate(dps)
                    )
                end

                local totalElapsed =
                    State.Tracking.pausedElapsedTime +
                    (currentTime - State.Tracking.startTime)

                if totalElapsed > 0 then
                    local avgS =
                        (currentStrength -
                            State.Tracking.initialStrength) /
                        totalElapsed

                    local avgD =
                        (currentDurability -
                            State.Tracking.initialDurability) /
                        totalElapsed

                    FarmLabels.averageStrength:SetDesc(
                        "Promedio De Fuerza Por: " ..
                        formatRate(avgS)
                    )

                    FarmLabels.averageDurability:SetDesc(
                        "Promedio De Durabilidad Por: " ..
                        formatRate(avgD)
                    )
                end
            end

        elseif getgenv().AutoFarm == false then
            if not State.Tracking.trackingStarted then
                local elapsed = State.Tracking.pausedElapsedTime

                if elapsed > 0 then
                    FarmLabels.stopwatch:SetDesc(
                        formatDuration(elapsed) ..
                        " - Fast Rep Stopped"
                    )
                end
            end
        end

        task.wait(0.05)
    end
end)

RebirthFolder = R.PacksFarm:Section({
    Title = "Fast Rebirth",
    Icon = "repeat",
    Opened = true
})

function petsAction(action, name)
    local pets = player:FindFirstChild("petsFolder")
    if not pets then return end

    forEachPet(pets, function(pet)
        if action == "equipPet" and pet.Name == name then
            Refs.equipPetEvent:FireServer("equipPet", pet)

        elseif action == "unequipPet" then
            Refs.equipPetEvent:FireServer("unequipPet", pet)
        end
    end)

    if action == "unequipPet" then
        task.wait(0.1)
    end
end

function getGoldenRebirthCount()
    local ult = player:FindFirstChild("ultimatesFolder")

    if ult and ult:FindFirstChild("Golden Rebirth") then
        return ult["Golden Rebirth"].Value
    end

    return 0
end

function getStrengthRequiredForRebirth()
    local rebirths = Refs.leaderstats.Rebirths.Value
    local base = 10000 + (2500 * rebirths)
    local golden = getGoldenRebirthCount()

    if golden >= 1 and golden <= 5 then
        base = base * (1 - golden * 0.1)
    end

    return math.floor(base)
end

function equipPriorityPets(...)
    local pets = player:FindFirstChild("petsFolder")
    if not pets then return end

    local priority = {...}
    local equipped = 0

    for _, petName in ipairs(priority) do
        if equipped >= 12 then
            break
        end

        forEachPet(pets, function(pet)
            if equipped < 12 and pet.Name == petName then
                Refs.equipPetEvent:FireServer("equipPet", pet)
                equipped += 1
            end
        end)
    end
end

RebirthFolder:Paragraph({
    Title = "Rebirths",
    Desc = "Rebirths:"
})

EtiquetasRebirth = {
    tiempo = RebirthFolder:Paragraph({
        Title = "Tiempo",
        Desc = "Tiempo: 0d 0h 0m 0s"
    }),

    rebirths = RebirthFolder:Paragraph({
        Title = "Rebirths",
        Desc = "Rebirths: 0"
    }),

    ganados = RebirthFolder:Paragraph({
        Title = "Rebirths Ganados",
        Desc = "Rebirths Ganados: 0"
    }),

    estatus = RebirthFolder:Paragraph({
        Title = "Estatus",
        Desc = "Estatus: Inactivo"
    }),

    aproximados = RebirthFolder:Paragraph({
        Title = "Rebirths Aproximados",
        Desc = "Rebirths Aprox: 0 / Hora | 0 / Día | 0 / Semana | 0 / Mes"
    }),

    promedio = RebirthFolder:Paragraph({
        Title = "Promedio",
        Desc = "Promedio De Rebirths: 0 / Hora | 0 / Día | 0 / Semana | 0 / Mes"
    })
}

State.RebirthTrack = {
    startTime = 0,
    pausedTime = 0,
    tracking = false,

    initialRebirths = Refs.rebirthsStat.Value,

    lastUpdateTime = 0,
    lastUpdateRebirths = Refs.rebirthsStat.Value,

    averageStartedAt = 0,
    averageStartRebirths = Refs.rebirthsStat.Value
}

function updatePace()
    if not State.RebirthTrack.tracking then
        return
    end

    local now = tick()
    local current = Refs.rebirthsStat.Value

    local intervalTime =
        now - State.RebirthTrack.lastUpdateTime

    local intervalRebirths =
        current - State.RebirthTrack.lastUpdateRebirths

    if intervalTime > 0 and intervalRebirths > 0 then
        local hourly =
            intervalRebirths / intervalTime * 3600

        EtiquetasRebirth.aproximados:SetDesc(
            string.format(
                "Rebirths Aprox: %s / Hora | %s / Día | %s / Semana | %s / Mes",
                formatCommas(hourly),
                formatCommas(hourly * 24),
                formatCommas(hourly * 168),
                formatCommas(hourly * 720)
            )
        )
    elseif intervalTime > 0 then
        EtiquetasRebirth.aproximados:SetDesc(
            "Rebirths Aprox: 0 / Hora | 0 / Día | 0 / Semana | 0 / Mes"
        )
    end

    local averageTime =
        now - State.RebirthTrack.averageStartedAt

    local averageRebirths =
        current - State.RebirthTrack.averageStartRebirths

    if averageTime > 0 and averageRebirths > 0 then
        local averageHourly =
            averageRebirths / averageTime * 3600

        EtiquetasRebirth.promedio:SetDesc(
            string.format(
                "Promedio De Rebirths: %s / Hora | %s / Día | %s / Semana | %s / Mes",
                formatCommas(averageHourly),
                formatCommas(averageHourly * 24),
                formatCommas(averageHourly * 168),
                formatCommas(averageHourly * 720)
            )
        )
    elseif averageTime > 0 then
        EtiquetasRebirth.promedio:SetDesc(
            "Promedio De Rebirths: 0 / Hora | 0 / Día | 0 / Semana | 0 / Mes"
        )
    end

    State.RebirthTrack.lastUpdateTime = now
    State.RebirthTrack.lastUpdateRebirths = current
end

task.spawn(function()
    while true do
        local now = tick()
        local elapsed = State.RebirthTrack.pausedTime

        if State.RebirthTrack.tracking then
            elapsed += now - State.RebirthTrack.startTime
        end

        EtiquetasRebirth.tiempo:SetDesc(
            "Tiempo: " .. formatDuration(elapsed)
        )

        if State.RebirthTrack.tracking then
            local current = Refs.rebirthsStat.Value

            EtiquetasRebirth.rebirths:SetDesc(
                "Rebirths: " .. formatCommas(current)
            )

            EtiquetasRebirth.ganados:SetDesc(
                "Rebirths Ganados: " ..
                formatCommas(
                    current - State.RebirthTrack.initialRebirths
                )
            )
        end

        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        if State.RebirthTrack.tracking then
            updatePace()
        end

        task.wait(10)
    end
end)

RebirthFolder:Toggle({
    Title = "Fast Rebirths",
    Value = false,
    Callback = function(state)
        getgenv().AutoFarming = state

        if state then
            local now = tick()
            local current = Refs.rebirthsStat.Value

            State.RebirthTrack.startTime = now
            State.RebirthTrack.pausedTime = 0
            State.RebirthTrack.tracking = true

            State.RebirthTrack.initialRebirths = current

            State.RebirthTrack.lastUpdateTime = now
            State.RebirthTrack.lastUpdateRebirths = current

            State.RebirthTrack.averageStartedAt = now
            State.RebirthTrack.averageStartRebirths = current

            EtiquetasRebirth.tiempo:SetDesc(
                "Tiempo: 0d 0h 0m 0s"
            )

            EtiquetasRebirth.rebirths:SetDesc(
                "Rebirths: " .. formatCommas(current)
            )

            EtiquetasRebirth.ganados:SetDesc(
                "Rebirths Ganados: 0"
            )

            EtiquetasRebirth.estatus:SetDesc(
                "Estatus: Activo"
            )

            EtiquetasRebirth.aproximados:SetDesc(
                "Rebirths Aprox: 0 / Hora | 0 / Día | 0 / Semana | 0 / Mes"
            )

            EtiquetasRebirth.promedio:SetDesc(
                "Promedio De Rebirths: 0 / Hora | 0 / Día | 0 / Semana | 0 / Mes"
            )
        else
            if State.RebirthTrack.tracking then
                State.RebirthTrack.pausedTime +=
                    tick() - State.RebirthTrack.startTime

                State.RebirthTrack.tracking = false
            end

            EtiquetasRebirth.estatus:SetDesc(
                "Estatus: Inactivo"
            )

            return
        end

        task.spawn(function()
            while getgenv().AutoFarming do
                local requiredStrength =
                    getStrengthRequiredForRebirth()

                petsAction("unequipPet")

                equipPriorityPets(
                    "Omega Overlord",
                    "Swift Samurai",
                    "Mythic Boss Pet",
                    "Legendary Boss Pet",
                    "Rainbow Boss Pet",
                    "Epic Boss Pet",
                    "Rare Boss Pet",
                    "Common Boss Pet"
                )

                while Refs.leaderstats.Strength.Value <
                    requiredStrength
                    and getgenv().AutoFarming do

                    for _ = 1, 10 do
                        Refs.muscleEvent:FireServer("rep")
                    end

                    task.wait()
                end

                if getgenv().AutoFarming then
                    petsAction("unequipPet")

                    equipPriorityPets(
                        "Titanium Hydra",
                        "Tribal Overlord"
                    )

                    local oldRebirths =
                        Refs.leaderstats.Rebirths.Value

                    repeat
                        Refs.rebirthRemote:InvokeServer(
                            "rebirthRequest"
                        )

                        task.wait(0.1)
                    until Refs.leaderstats.Rebirths.Value >
                        oldRebirths
                        or not getgenv().AutoFarming
                end

                task.wait()
            end
        end)
    end
})

RebirthFolder:Button({
    Title = "Industrial Lift",
    Callback = function()
        teleportAndUseMachine(
            CFrame.new(-5491.4, 59, 4644.6),
            "Industrial Lift"
        )
    end
})

R.Miscellaneous = R.Window:Section({
    Title = "Miscellaneous",
    Icon = "settings",
    Opened = true
})

R.Extras = R.Miscellaneous:Tab({
    Title = "Extras",
    Icon = "settings-2",
    ShowTabTitle = true
})

R.OpThingsFarm = R.Extras:Section({
    Title = "More Option For Farm",
    Icon = "wrench",
    Opened = true
})

R.OpThingsFarm:Toggle({
    Title = "Anti Fling",
    Value = false,
    Callback = function(state)
        V.AntiFling = state

        if C.AntiFlingCharConn then
            C.AntiFlingCharConn:Disconnect()
            C.AntiFlingCharConn = nil
        end

        local function applyAntiFling(character)
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local existingBV = hrp:FindFirstChild("MHAntiFlingBV")

            if existingBV then
                existingBV:Destroy()
            end

            if V.AntiFling then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "MHAntiFlingBV"
                bv.MaxForce = Vector3.new(100000, 0, 100000)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.P = 1250
                bv.Parent = hrp
            end
        end

        if S.LP.Character then
            applyAntiFling(S.LP.Character)
        end

        if state then
            C.AntiFlingCharConn =
                S.LP.CharacterAdded:Connect(function(newCharacter)
                    if V.AntiFling then
                        task.wait(1)
                        applyAntiFling(newCharacter)
                    end
                end)
        end
    end
})

R.OpThingsFarm:Toggle({
    Title = "Lock Position",
    Value = false,
    Callback = function(state)
        V.LockPosition = state

        if St.lockPosConn then
            St.lockPosConn:Disconnect()
            St.lockPosConn = nil
        end

        if C.LockPosCharConn then
            C.LockPosCharConn:Disconnect()
            C.LockPosCharConn = nil
        end

        local function applyLock(character)
            local humanoid =
                character and
                character:FindFirstChildOfClass("Humanoid")

            local hrp =
                character and
                character:FindFirstChild("HumanoidRootPart")

            if not humanoid or not hrp then
                return
            end

            if St.lockPosConn then
                St.lockPosConn:Disconnect()
                St.lockPosConn = nil
            end

            if V.LockPosition then
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
                humanoid.AutoRotate = false
                humanoid:ChangeState(
                    Enum.HumanoidStateType.Physics
                )

                local savedCFrame = hrp.CFrame

                St.lockPosConn =
                    S.Run.Heartbeat:Connect(function()
                        local c = S.LP.Character

                        if not c or not V.LockPosition then
                            return
                        end

                        local h =
                            c:FindFirstChild("HumanoidRootPart")

                        if not h then
                            return
                        end

                        h.Velocity = Vector3.zero
                        h.RotVelocity = Vector3.zero
                        h.CFrame = savedCFrame
                    end)
            else
                humanoid.WalkSpeed = 250
                humanoid.JumpPower = 50
                humanoid.AutoRotate = true
                humanoid:ChangeState(
                    Enum.HumanoidStateType.GettingUp
                )
            end
        end

        if S.LP.Character then
            applyLock(S.LP.Character)
        end

        if state then
            C.LockPosCharConn =
                S.LP.CharacterAdded:Connect(function(newCharacter)
                    if V.LockPosition then
                        task.wait(1)
                        applyLock(newCharacter)
                    end
                end)
        end
    end
})

R.SettingsPlayer = R.Extras:Section({
    Title = "Settings Player",
    Icon = "user-cog",
    Opened = true
})

R.SettingsPlayer:Input({
    Title = "Size Value",
    Placeholder = tostring(V.SizeValue),
    Callback = function(text)
        local num = tonumber(text)

        if num and num > 0 then
            V.SizeValue = num
        end
    end
})

R.SettingsPlayer:Toggle({
    Title = "Auto Set Size",
    Value = false,
    Callback = function(state)
        V.AutoSetSize = state

        if state then
            task.spawn(function()
                while V.AutoSetSize do
                    if not V.AutoSetSize then
                        break
                    end

                    pcall(function()
                        S.RS.rEvents.changeSpeedSizeRemote:InvokeServer(
                            "changeSize",
                            V.SizeValue
                        )
                    end)

                    task.wait(0.1)
                end
            end)
        end
    end
})

R.SettingsPlayer:Input({
    Title = "Speed Value",
    Placeholder = tostring(V.SpeedValue),
    Callback = function(text)
        local num = tonumber(text)

        if num and num >= 0 then
            V.SpeedValue = num

            local char = S.LP.Character

            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = V.SpeedValue
            end
        end
    end
})

R.SettingsPlayer:Toggle({
    Title = "Auto Set Speed",
    Value = false,
    Callback = function(state)
        V.AutoSetSpeed = state

        if St.autoSpeedConn then
            St.autoSpeedConn:Disconnect()
            St.autoSpeedConn = nil
        end

        if state then
            local char = S.LP.Character

            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = V.SpeedValue
            end

            St.autoSpeedConn =
                S.LP.CharacterAdded:Connect(function(character)
                    if not V.AutoSetSpeed then
                        return
                    end

                    local humanoid =
                        character:WaitForChild("Humanoid")

                    if humanoid then
                        humanoid.WalkSpeed = V.SpeedValue
                    end
                end)
        end
    end
})

R.SettingsPlayer:Input({
    Title = "Jump Power Value",
    Placeholder = tostring(V.JumpValue),
    Callback = function(text)
        local num = tonumber(text)

        if num and num >= 0 then
            V.JumpValue = num

            local char = S.LP.Character

            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = V.JumpValue
            end
        end
    end
})

R.SettingsPlayer:Toggle({
    Title = "Super Jump",
    Value = false,
    Callback = function(state)
        V.SuperJump = state

        if St.superJumpConn then
            St.superJumpConn:Disconnect()
            St.superJumpConn = nil
        end

        if state then
            local char = S.LP.Character

            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = V.JumpValue
            end

            St.superJumpConn =
                S.LP.CharacterAdded:Connect(function(character)
                    if not V.SuperJump then
                        return
                    end

                    local humanoid =
                        character:WaitForChild("Humanoid")

                    if humanoid then
                        humanoid.JumpPower = V.JumpValue
                    end
                end)
        else
            local char = S.LP.Character

            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = 50
            end
        end
    end
})

R.SettingsPlayer:Input({
    Title = "Gravity Value",
    Placeholder = tostring(V.GravityValue),
    Callback = function(text)
        local num = tonumber(text)

        if num and num >= 0 then
            V.GravityValue = num
        end
    end
})

R.SettingsPlayer:Toggle({
    Title = "Custom Gravity",
    Value = false,
    Callback = function(state)
        V.CustomGravity = state

        if state then
            workspace.Gravity = V.GravityValue
        else
            workspace.Gravity = 196
        end
    end
})

R.Externals = R.Extras:Section({
    Title = "Universal Scripts",
    Icon = "globe",
    Opened = true
})

R.Externals:Button({
    Title = "Infinite Yield",
    Callback = function()
        loadstring(
            game:HttpGet(
                "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
            )
        )()
    end
})

R.Externals:Button({
    Title = "Permanent Shiftlock",
    Callback = function()
        loadstring(
            game:HttpGet(
                "https://pastebin.com/raw/CjNsnSDy"
            )
        )()
    end
})

R.Externals:Button({
    Title = "All Emotes",
    Callback = function()
        loadstring(
            game:HttpGet(
                "https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"
            )
        )()
    end
})

R.Misc = R.Extras:Section({
    Title = "Miscellaneous",
    Icon = "boxes",
    Opened = true
})

R.Misc:Toggle({
    Title = "Infinite Jump",
    Value = false,
    Callback = function(state)
        V.InfiniteJump = state

        if St.infiniteJumpConn then
            St.infiniteJumpConn:Disconnect()
            St.infiniteJumpConn = nil
        end

        if state then
            St.infiniteJumpConn =
                S.UIS.JumpRequest:Connect(function()
                    if V.InfiniteJump then
                        local char = S.LP.Character

                        if char then
                            local hum =
                                char:FindFirstChildOfClass("Humanoid")

                            if hum then
                                hum:ChangeState("Jumping")
                            end
                        end
                    end
                end)
        end
    end
})

D.WaterParts = D.WaterParts or {}

function H.ClearWaterParts()
    for _, part in ipairs(D.WaterParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end

    table.clear(D.WaterParts)
end

function H.CreateWaterParts()
    H.ClearWaterParts()

    local partSize = 2048
    local totalDistance = 50000
    local startPosition = Vector3.new(-2, -9.5, -2)
    local numberOfParts = math.ceil(totalDistance / partSize)
    local count = 0

    for x = 0, numberOfParts - 1 do
        if not V.WalkOnWater then
            break
        end

        for z = 0, numberOfParts - 1 do
            if not V.WalkOnWater then
                break
            end

            local offsets = {
                {x, z, "Part_Side_"},
                {-x, z, "Part_LeftRight_"},
                {-x, -z, "Part_UpLeft_"},
                {x, -z, "Part_UpRight_"},
            }

            for _, offset in ipairs(offsets) do
                if not V.WalkOnWater then
                    break
                end

                local key =
                    offset[1] .. "_" .. offset[2]

                if not D.WaterParts[key] then
                    local part = Instance.new("Part")

                    part.Size =
                        Vector3.new(
                            partSize,
                            1,
                            partSize
                        )

                    part.Position =
                        startPosition +
                        Vector3.new(
                            offset[1] * partSize,
                            0,
                            offset[2] * partSize
                        )

                    part.Anchored = true
                    part.CanCollide = true
                    part.Transparency = 1

                    part.Name =
                        offset[3] ..
                        x ..
                        "_" ..
                        z

                    part.Parent = workspace

                    D.WaterParts[key] = part

                    count += 1

                    if count % 20 == 0 then
                        task.wait()
                    end
                end
            end
        end
    end
end

R.Misc:Toggle({
    Title = "Walk On Water",
    Value = false,
    Callback = function(state)
        V.WalkOnWater = state

        if state then
            if C.WalkOnWaterTask then
                return
            end

            C.WalkOnWaterTask =
                task.spawn(function()
                    H.CreateWaterParts()
                    C.WalkOnWaterTask = nil
                end)
        else
            H.ClearWaterParts()
            C.WalkOnWaterTask = nil
        end
    end
})

R.Misc:Toggle({
    Title = "Noclip",
    Value = false,
    Callback = function(state)
        V.Noclip = state

        if St.noclipConn then
            St.noclipConn:Disconnect()
            St.noclipConn = nil
        end

        if state then
            St.noclipConn =
                S.Run.Stepped:Connect(function()
                    local char = S.LP.Character

                    if not char then
                        return
                    end

                    for _, part in pairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
        else
            local char = S.LP.Character

            if char then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

R.Misc:Button({
    Title = "Remove Portals",
    Callback = function()
        for _, portal in pairs(game:GetDescendants()) do
            if portal.Name == "RobloxForwardPortals" then
                portal:Destroy()
            end
        end

        if St.portalRemovalConn then
            St.portalRemovalConn:Disconnect()
        end

        St.portalRemovalConn =
            game.DescendantAdded:Connect(function(descendant)
                if descendant.Name == "RobloxForwardPortals" then
                    descendant:Destroy()
                end
            end)

        print("Portales de Roblox removidos")
    end
})

R.ServerSystem = R.Extras:Section({
    Title = "Server",
    Icon = "server",
    Opened = true
})

R.ServerSystem:Toggle({
    Title = "Auto Reconnect",
    Value = false,
    Callback = function(state)
        V.AutoReconnect = state

        if state then
            local jobId = S.JobId
            local placeId = S.PlaceId

            S.GuiService.ErrorMessageChanged:Connect(function()
                if V.AutoReconnect then
                    pcall(function()
                        S.TP:TeleportToPlaceInstance(
                            placeId,
                            jobId,
                            S.LP
                        )
                    end)
                end
            end)
        end
    end
})

R.ServerSystem:Toggle({
    Title = "Auto Reconnect (Automatic)",
    Value = false,
    Callback = function(state)
        V.AutoReconnectAuto = state

        if state then
            local jobId = S.JobId
            local placeId = S.PlaceId

            task.spawn(function()
                while V.AutoReconnectAuto do
                    task.wait(5)

                    pcall(function()
                        if not game:IsLoaded() then
                            S.TP:TeleportToPlaceInstance(
                                placeId,
                                jobId,
                                S.LP
                            )
                        end
                    end)
                end
            end)

            S.LP.AncestryChanged:Connect(function(_, parent)
                if not parent and V.AutoReconnectAuto then
                    pcall(function()
                        S.TP:TeleportToPlaceInstance(
                            placeId,
                            jobId,
                            S.LP
                        )
                    end)
                end
            end)
        end
    end
})

R.ServerSystem:Button({
    Title = "Server Hop Low",
    Callback = function()
        pcall(function()
            local servers = S.HTTP:JSONDecode(
                game:HttpGet(
                    "https://games.roblox.com/v1/games/" ..
                    S.PlaceId ..
                    "/servers/Public?sortOrder=Asc&limit=100"
                )
            )

            if servers and servers.data then
                local best = nil

                for _, server in pairs(servers.data) do
                    if server.id ~= S.JobId and server.playing then
                        if not best or
                            server.playing < best.playing then

                            best = server
                        end
                    end
                end

                if best then
                    S.TP:TeleportToPlaceInstance(
                        S.PlaceId,
                        best.id,
                        S.LP
                    )
                else
                    print("No se encontraron servidores disponibles")
                end
            end
        end)
    end
})

R.ServerSystem:Button({
    Title = "Server Hop Full",
    Callback = function()
        pcall(function()
            local servers = S.HTTP:JSONDecode(
                game:HttpGet(
                    "https://games.roblox.com/v1/games/" ..
                    S.PlaceId ..
                    "/servers/Public?sortOrder=Desc&limit=100"
                )
            )

            if servers and servers.data then
                local best = nil

                for _, server in pairs(servers.data) do
                    if server.id ~= S.JobId and server.playing then
                        if not best or
                            server.playing > best.playing then

                            best = server
                        end
                    end
                end

                if best then
                    S.TP:TeleportToPlaceInstance(
                        S.PlaceId,
                        best.id,
                        S.LP
                    )
                else
                    print("No se encontraron servidores disponibles")
                end
            end
        end)
    end
})

R.ServerSystem:Button({
    Title = "Reconnect Same Server",
    Callback = function()
        local jobId = S.JobId
        local placeId = S.PlaceId

        S.TP:TeleportToPlaceInstance(
            placeId,
            jobId,
            S.LP
        )
    end
})

R.Crystals = R.Window:Section({
    Title = "Crystals",
    Icon = "gem",
    Opened = true
})

R.Pets = R.Crystals:Tab({
    Title = "Crystals",
    Icon = "gem",
    ShowTabTitle = true
})

D.PetShop = D.PetShop or {
    PetList = {},
    AuraList = {}
}

D.Trade = D.Trade or {
    Players = {}
}

V.SelectedShopPet = V.SelectedShopPet or ""
V.SelectedShopAura = V.SelectedShopAura or ""
V.SelectedEvolvePet = V.SelectedEvolvePet or ""
V.SelectedTradePlayer = V.SelectedTradePlayer or ""
V.SelectedTradePet = V.SelectedTradePet or ""

D.PetShopFolder = D.PetShopFolder or S.RS:WaitForChild("shared"):WaitForChild("runtime"):WaitForChild("cPetShopFolder")
D.PetShopRemote = D.PetShopRemote or S.RS.rEvents:WaitForChild("cPetShopRemote")

table.clear(D.PetShop.PetList)
table.clear(D.PetShop.AuraList)

for _, item in ipairs(D.PetShopFolder:GetChildren()) do
    if item:GetAttribute("IsPowerUp") == true then
        table.insert(D.PetShop.AuraList, item.Name)
    else
        table.insert(D.PetShop.PetList, item.Name)
    end
end

R.Pets:Paragraph({
    Title = "Pet Shop",
    Desc = "Selecciona una pet para comprar"
})

R.PetShopDropdown = R.Pets:Dropdown({
    Title = "Selecciona La Pet",
    Values = D.PetShop.PetList,
    Value = V.SelectedShopPet ~= "" and V.SelectedShopPet or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(value)
        V.SelectedShopPet = value or ""
    end
})

R.Pets:Toggle({
    Title = "Comprar Pets",
    Value = false,
    Callback = function(bool)
        V.AutoBuyShopPet = bool

        if bool then
            task.spawn(function()
                while V.AutoBuyShopPet and myGen == MH.Gen do
                    if V.SelectedShopPet ~= "" then
                        local pet = D.PetShopFolder:FindFirstChild(V.SelectedShopPet)

                        if pet then
                            pcall(function()
                                D.PetShopRemote:InvokeServer(pet)
                            end)
                        end
                    end

                    task.wait(0.1)
                end
            end)
        end
    end
})

R.Pets:Paragraph({
    Title = "Auras",
    Desc = "Selecciona un aura para comprar"
})

R.AuraShopDropdown = R.Pets:Dropdown({
    Title = "Selecciona El Aura",
    Values = D.PetShop.AuraList,
    Value = V.SelectedShopAura ~= "" and V.SelectedShopAura or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(value)
        V.SelectedShopAura = value or ""
    end
})

R.Pets:Toggle({
    Title = "Comprar Aura",
    Value = false,
    Callback = function(bool)
        V.AutoBuyShopAura = bool

        if bool then
            task.spawn(function()
                while V.AutoBuyShopAura and myGen == MH.Gen do
                    if V.SelectedShopAura ~= "" then
                        local aura = D.PetShopFolder:FindFirstChild(V.SelectedShopAura)

                        if aura then
                            pcall(function()
                                D.PetShopRemote:InvokeServer(aura)
                            end)
                        end
                    end

                    task.wait(0.1)
                end
            end)
        end
    end
})

R.Pets:Paragraph({
    Title = "Evolucionar Pets",
    Desc = "Selecciona una pet para evolucionar"
})

R.EvolvePetDropdown = R.Pets:Dropdown({
    Title = "Selecciona La Pet",
    Values = D.PetShop.PetList,
    Value = V.SelectedEvolvePet ~= "" and V.SelectedEvolvePet or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(value)
        V.SelectedEvolvePet = value or ""
    end
})

R.Pets:Toggle({
    Title = "Evolucionar Las Pets",
    Value = false,
    Callback = function(bool)
        V.AutoEvolveShopPet = bool

        if bool then
            task.spawn(function()
                while V.AutoEvolveShopPet and myGen == MH.Gen do
                    if V.SelectedEvolvePet ~= "" then
                        pcall(function()
                            S.RS.rEvents.petEvolveEvent:FireServer(
                                "evolvePet",
                                V.SelectedEvolvePet
                            )
                        end)
                    end

                    task.wait(0.5)
                end
            end)
        end
    end
})

R.Pets:Paragraph({
    Title = "Auto Trade",
    Desc = "Selecciona el jugador y la pet"
})

R.TradePlayerDropdown = R.Pets:Dropdown({
    Title = "Selecciona El Jugador",
    Values = {},
    Value = V.SelectedTradePlayer ~= "" and V.SelectedTradePlayer or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(value)
        V.SelectedTradePlayer = value and (value:match("| (.+)") or "") or ""
    end
})

local tradePlayers = {}

for _, tradePlayer in ipairs(S.Players:GetPlayers()) do
    if tradePlayer ~= S.LP then
        table.insert(
            tradePlayers,
            tradePlayer.DisplayName .. " | " .. tradePlayer.Name
        )
    end
end

R.TradePlayerDropdown:Refresh(tradePlayers)

S.Players.PlayerAdded:Connect(function(tradePlayer)
    if tradePlayer ~= S.LP then
        R.TradePlayerDropdown:Insert(
            tradePlayer.DisplayName .. " | " .. tradePlayer.Name
        )
    end
end)

S.Players.PlayerRemoving:Connect(function(tradePlayer)
    if V.SelectedTradePlayer == tradePlayer.Name then
        V.SelectedTradePlayer = ""
    end
end)

R.TradePetDropdown = R.Pets:Dropdown({
    Title = "Selecciona La Pet",
    Values = D.PetShop.PetList,
    Value = V.SelectedTradePet ~= "" and V.SelectedTradePet or nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(value)
        V.SelectedTradePet = value or ""
    end
})

R.Pets:Toggle({
    Title = "Auto Trade",
    Value = false,
    Callback = function(bool)
        V.AutoTrade = bool

        if bool then
            task.spawn(function()
                while V.AutoTrade and myGen == MH.Gen do
                    if V.SelectedTradePlayer ~= "" and V.SelectedTradePet ~= "" then
                        local player = S.Players:FindFirstChild(V.SelectedTradePlayer)

                        if player then
                            pcall(function()
                                S.RS.rEvents.tradingEvent:FireServer(
                                    "sendTradeRequest",
                                    player
                                )
                            end)

                            task.wait(0.5)

                            if V.AutoTrade and myGen == MH.Gen then
                                local petsFolder = S.LP:FindFirstChild("petsFolder")

                                if petsFolder then
                                    local unique = petsFolder:FindFirstChild("Unique")

                                    if unique then
                                        local amount = 0

                                        for _, pet in ipairs(unique:GetChildren()) do
                                            if pet.Name == V.SelectedTradePet then
                                                pcall(function()
                                                    S.RS.rEvents.tradingEvent:FireServer(
                                                        "offerPet",
                                                        pet
                                                    )
                                                end)

                                                amount += 1

                                                if amount >= 6 then
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end

                                task.wait(0.5)

                                pcall(function()
                                    S.RS.rEvents.tradingEvent:FireServer(
                                        "acceptTrade"
                                    )
                                end)
                            end
                        end
                    end

                    task.wait(2)
                end
            end)
        end
    end
})


R.Snacks = R.Miscellaneous:Tab({
    Title = "Snacks",
    Icon = "utensils",
    ShowTabTitle = true
})

R.Snacks:Paragraph({
    Title = "Importante!",
    Desc = "No Se Puede Regalar Si Estas Farmeando\n\nCuando Selecciones La Cantidad Que Quieras Regalar Ya Sean Eggs O Shakes Haz Lo Siguiente\n\nPon La Cantidad Que Vas A Regalar\n\nDale Enter Ala Cantidad Como Si Fuera Un Mensaje\n\nAprieta El Boton Send Eggs/Shakes"
})

R.Snacks:Divider()

R.Snacks:Paragraph({
    Title = "Gift Eggs",
    Desc = "Protein Eggs"
})

St.eggCountPara = R.Snacks:Paragraph({
    Title = "Protein Eggs",
    Desc = "Count: 0 | Status: IDLE"
})

R.EggPlayerDropdown = R.Snacks:Dropdown({
    Title = "Select Player",
    Values = (function()
        local list = {}

        for _, eggPlayer in ipairs(S.Players:GetPlayers()) do
            table.insert(
                list,
                eggPlayer.DisplayName .. " - " .. eggPlayer.Name
            )
        end

        return list
    end)(),
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(val)
        if val then
            local name = val:match("%-%s*(.-)%s*$")
            name = name and name:match("^%s*(.-)%s*$") or ""
            V.SelectedEggPlayer = name ~= "" and S.Players:FindFirstChild(name) or nil
        else
            V.SelectedEggPlayer = nil
        end
    end
})

R.Snacks:Input({
    Title = "Egg Amount",
    Placeholder = "Cantidad",
    Callback = function(text)
        local n = tonumber(text)

        if n and n > 0 then
            V.EggGiftCount = n
        end
    end
})

R.Snacks:Button({
    Title = "Send Eggs",
    Callback = function()
        if not V.SelectedEggPlayer or V.EggGiftCount <= 0 then
            print("Elegi un jugador y una cantidad primero")
            return
        end

        if St.eggCountPara then
            St.eggCountPara:SetDesc(
                "Count: " .. V.EggGiftCount .. " | Status: GIFTING..."
            )
        end

        task.spawn(function()
            local folder = S.LP:FindFirstChild("consumablesFolder")

            if not folder then
                return
            end

            local sent = 0
            local target = V.EggGiftCount

            for _ = 1, target do
                local egg = folder:FindFirstChild("Protein Egg")

                if not egg then
                    break
                end

                pcall(function()
                    S.RS.rEvents.giftRemote:InvokeServer(
                        "giftRequest",
                        V.SelectedEggPlayer,
                        egg
                    )
                end)

                sent = sent + 1

                if sent % 5 == 0 then
                    if St.eggCountPara then
                        St.eggCountPara:SetDesc(
                            "Count: " .. sent .. "/" .. target ..
                            " | Status: GIFTING..."
                        )
                    end

                    task.wait(0.15)
                end
            end

            if St.eggCountPara then
                St.eggCountPara:SetDesc(
                    "Count: " .. sent .. "/" .. target ..
                    " | Status: DONE"
                )
            end
        end)
    end
})

R.Snacks:Divider()

R.Snacks:Paragraph({
    Title = "Gift Shakes",
    Desc = "Tropical Shakes"
})

St.shakeCountPara = R.Snacks:Paragraph({
    Title = "Tropical Shakes",
    Desc = "Count: 0 | Status: IDLE"
})

R.ShakePlayerDropdown = R.Snacks:Dropdown({
    Title = "Select Player",
    Values = (function()
        local list = {}

        for _, shakePlayer in ipairs(S.Players:GetPlayers()) do
            table.insert(
                list,
                shakePlayer.DisplayName .. " - " .. shakePlayer.Name
            )
        end

        return list
    end)(),
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(val)
        if val then
            local name = val:match("%-%s*(.-)%s*$")
            name = name and name:match("^%s*(.-)%s*$") or ""
            V.SelectedShakePlayer = name ~= "" and S.Players:FindFirstChild(name) or nil
        else
            V.SelectedShakePlayer = nil
        end
    end
})

R.Snacks:Input({
    Title = "Shake Amount",
    Placeholder = "Cantidad",
    Callback = function(text)
        local n = tonumber(text)

        if n and n > 0 then
            V.ShakeGiftCount = n
        end
    end
})

R.Snacks:Button({
    Title = "Send Shakes",
    Callback = function()
        if not V.SelectedShakePlayer or V.ShakeGiftCount <= 0 then
            print("Elegi un jugador y una cantidad primero")
            return
        end

        if St.shakeCountPara then
            St.shakeCountPara:SetDesc(
                "Count: " .. V.ShakeGiftCount .. " | Status: GIFTING..."
            )
        end

        task.spawn(function()
            pcall(function()
                local folder = S.LP:FindFirstChild("consumablesFolder")

                if not folder then
                    return
                end

                local sent = 0
                local target = V.ShakeGiftCount

                for _ = 1, target do
                    local shake = folder:FindFirstChild("Tropical Shake")

                    if not shake then
                        break
                    end

                    S.RS.rEvents.giftRemote:InvokeServer(
                        "giftRequest",
                        V.SelectedShakePlayer,
                        shake
                    )

                    sent = sent + 1

                    if sent % 10 == 0 then
                        if St.shakeCountPara then
                            St.shakeCountPara:SetDesc(
                                "Count: " .. sent .. "/" .. target ..
                                " | Status: GIFTING..."
                            )
                        end

                        task.wait(0)
                    end
                end

                if St.shakeCountPara then
                    St.shakeCountPara:SetDesc(
                        "Count: " .. sent .. "/" .. target ..
                        " | Status: DONE"
                    )
                end
            end)
        end)
    end
})

task.spawn(function()
    local lastEggs = -1
    local lastShakes = -1

    while task.wait(2) do
        if MH.Gen ~= myGen then
            break
        end

        pcall(function()
            local folder = S.LP:FindFirstChild("consumablesFolder")

            if not folder then
                return
            end

            local eggs = 0
            local shakes = 0

            for _, item in ipairs(folder:GetChildren()) do
                if item.Name == "Protein Egg" then
                    eggs = eggs + 1
                elseif item.Name == "Tropical Shake" then
                    shakes = shakes + 1
                end
            end

            if eggs ~= lastEggs then
                lastEggs = eggs

                if St.eggCountPara then
                    St.eggCountPara:SetDesc(
                        "Count: " .. eggs .. " | Status: IDLE"
                    )
                end
            end

            if shakes ~= lastShakes then
                lastShakes = shakes

                if St.shakeCountPara then
                    St.shakeCountPara:SetDesc(
                        "Count: " .. shakes .. " | Status: IDLE"
                    )
                end
            end
        end)
    end
end)

if C.SnacksPlayerAddedConn then
    C.SnacksPlayerAddedConn:Disconnect()
end

C.SnacksPlayerAddedConn = S.Players.PlayerAdded:Connect(function(newPlayer)
    if MH.Gen ~= myGen then
        return
    end

    task.wait(0.1)

    local option = newPlayer.DisplayName .. " - " .. newPlayer.Name

    if R.EggPlayerDropdown and R.EggPlayerDropdown.Refresh then
        local list = {}

        for _, eggPlayer in ipairs(S.Players:GetPlayers()) do
            table.insert(
                list,
                eggPlayer.DisplayName .. " - " .. eggPlayer.Name
            )
        end

        R.EggPlayerDropdown:Refresh(list)
    end

    if R.ShakePlayerDropdown and R.ShakePlayerDropdown.Refresh then
        local list = {}

        for _, shakePlayer in ipairs(S.Players:GetPlayers()) do
            table.insert(
                list,
                shakePlayer.DisplayName .. " - " .. shakePlayer.Name
            )
        end

        R.ShakePlayerDropdown:Refresh(list)
    end
end)

if C.SnacksPlayerRemovingConn then
    C.SnacksPlayerRemovingConn:Disconnect()
end

C.SnacksPlayerRemovingConn = S.Players.PlayerRemoving:Connect(function()
    if MH.Gen ~= myGen then
        return
    end

    task.wait(0.1)

    if R.EggPlayerDropdown and R.EggPlayerDropdown.Refresh then
        local list = {}

        for _, eggPlayer in ipairs(S.Players:GetPlayers()) do
            table.insert(
                list,
                eggPlayer.DisplayName .. " - " .. eggPlayer.Name
            )
        end

        R.EggPlayerDropdown:Refresh(list)
    end

    if R.ShakePlayerDropdown and R.ShakePlayerDropdown.Refresh then
        local list = {}

        for _, shakePlayer in ipairs(S.Players:GetPlayers()) do
            table.insert(
                list,
                shakePlayer.DisplayName .. " - " .. shakePlayer.Name
            )
        end

        R.ShakePlayerDropdown:Refresh(list)
    end
end)

D.Boost = D.Boost or {
    ItemList = {
        "Tropical Shake",
        "Energy Shake",
        "Protein Bar",
        "TOUGH Bar",
        "Protein Shake",
        "ULTRA Shake",
        "Energy Bar",
        "Protein Egg"
    }
}

V.EatBoosts = V.EatBoosts or false

task.spawn(function()
    while myGen == MH.Gen do
        if V.EatBoosts then
            for _, itemName in ipairs(D.Boost.ItemList) do
                local tool =
                    S.LP.Character and
                    S.LP.Character:FindFirstChild(itemName)
                    or S.LP.Backpack:FindFirstChild(itemName)

                if tool then
                    local parts = {}

                    for word in itemName:gmatch("%S+") do
                        table.insert(parts, word:lower())
                    end

                    for i = 2, #parts do
                        parts[i] =
                            parts[i]:sub(1, 1):upper() ..
                            parts[i]:sub(2)
                    end

                    for i = 1, 10 do
                        S.LP.muscleEvent:FireServer(
                            table.concat(parts),
                            tool
                        )
                    end
                end
            end
        end

        task.wait(0.1)
    end
end)

R.Snacks:Toggle({
    Title = "Eat Everything",
    Value = V.EatBoosts,
    Callback = function(state)
        V.EatBoosts = state
    end
})

D.SnackBoost = D.SnackBoost or {
    ItemList = {
        "Tropical Shake",
        "Energy Shake",
        "Protein Bar",
        "TOUGH Bar",
        "Protein Shake",
        "ULTRA Shake",
        "Energy Bar"
    }
}

V.SnackEating = V.SnackEating or false

task.spawn(function()
    while myGen == MH.Gen do
        if V.SnackEating then
            for _, snackName in ipairs(D.SnackBoost.ItemList) do
                local snackTool =
                    S.LP.Character and
                    S.LP.Character:FindFirstChild(snackName)
                    or S.LP.Backpack:FindFirstChild(snackName)

                if snackTool then
                    local snackParts = {}

                    for word in snackName:gmatch("%S+") do
                        table.insert(snackParts, word:lower())
                    end

                    for i = 2, #snackParts do
                        snackParts[i] =
                            snackParts[i]:sub(1, 1):upper() ..
                            snackParts[i]:sub(2)
                    end

                    for i = 1, 10 do
                        S.LP.muscleEvent:FireServer(
                            table.concat(snackParts),
                            snackTool
                        )
                    end
                end
            end
        end

        task.wait(0.1)
    end
end)

R.Snacks:Toggle({
    Title = "Eat Everything (No Egg)",
    Value = V.SnackEating,
    Callback = function(state)
        V.SnackEating = state
    end
})


R.Players = R.Window:Section({
    Title = "Players",
    Icon = "users",
    Opened = true
})

R.Killer = R.Players:Tab({
    Title = "Killer",
    Icon = "skull",
    ShowTabTitle = true
})

D.KillerTags = D.KillerTags or {"TRD", "TheRealDevil", "44", "EMPI", "SLH", "KTA"}
D.KillerWhitelist = D.KillerWhitelist or {}
D.KillerBlacklist = D.KillerBlacklist or {}
D.KillerBlacklistWords = D.KillerBlacklistWords or {}

V.KillerTagState = V.KillerTagState or {}

for _, tag in ipairs(D.KillerTags) do
    if V.KillerTagState[tag] == nil then
        V.KillerTagState[tag] = false
    end
end

St.KillerActive = St.KillerActive or {}
V.KillerFileName = "MysteryHubBlacklist_" .. S.LP.Name .. ".txt"

function H.KGetCharacter()
    local char = S.LP.Character

    if not char then
        return nil
    end

    if not char:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    return char
end

function H.KTpNear(target)
    local char = H.KGetCharacter()
    local targetChar = target and target.Character
    local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

    if not char or not targetRoot then
        return false
    end

    local minDist, maxDist = 4, 7
    local angle = math.random() * math.pi * 2
    local dist = minDist + math.random() * (maxDist - minDist)

    local offset = Vector3.new(
        math.cos(angle) * dist,
        0,
        math.sin(angle) * dist
    )

    char.HumanoidRootPart.CFrame =
        CFrame.new(targetRoot.Position + offset, targetRoot.Position)

    return true
end

V.KillerPunchLoop = false

function H.KPunchLoop(state)
    V.KillerPunchLoop = state

    if not state then
        return
    end

    if C.KillerPunchLoopConn then
        C.KillerPunchLoopConn:Disconnect()
        C.KillerPunchLoopConn = nil
    end

    task.spawn(function()
        while V.KillerPunchLoop do
            local char = S.LP.Character

            local punch = char and (
                char:FindFirstChild("Punch")
                or S.LP.Backpack:FindFirstChild("Punch")
            )

            if punch then
                if punch.Parent ~= char then
                    punch.Parent = char
                end

                local attackTime = punch:FindFirstChild("attackTime")

                if attackTime then
                    attackTime.Value = 0
                end

                punch:Activate()
            end

            task.wait()
        end
    end)
end

function H.KEquipAndPunch()
    local char = S.LP.Character

    if not char then
        return
    end

    local punch = char:FindFirstChild("Punch")
        or S.LP.Backpack:FindFirstChild("Punch")

    if punch then
        if punch.Parent ~= char then
            punch.Parent = char
        end

        local attackTime = punch:FindFirstChild("attackTime")

        if attackTime then
            attackTime.Value = 0
        end

        punch:Activate()
    end
end

function H.KKillPlayer(target)
    local character = H.KGetCharacter()

    if not character then
        return
    end

    if not target.Character
        or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    if not character:FindFirstChild("LeftHand") then
        return
    end

    pcall(function()
        firetouchinterest(
            target.Character.HumanoidRootPart,
            character.LeftHand,
            0
        )

        task.wait(0.01)

        firetouchinterest(
            target.Character.HumanoidRootPart,
            character.LeftHand,
            1
        )

        H.KEquipAndPunch()
    end)
end

function H.KTpAndKill(target, isActiveFn)
    local startTime = tick()
    local timeoutSeconds = 6

    while target
        and target.Character
        and target.Character:FindFirstChild("HumanoidRootPart")
        and target.Character:FindFirstChild("Humanoid")
        and target.Character.Humanoid.Health > 0
        and (not isActiveFn or isActiveFn()) do

        if tick() - startTime >= timeoutSeconds then
            break
        end

        if isActiveFn and not isActiveFn() then
            break
        end

        H.KTpNear(target)

        if isActiveFn and not isActiveFn() then
            break
        end

        H.KKillPlayer(target)

        task.wait(0.05)
    end
end

function H.KFindClosestPlayer(input)
    if not input or input == "" then
        return nil
    end

    input = input:lower()

    local bestMatch, bestScore = nil, 0

    for _, targetPlayer in pairs(S.Players:GetPlayers()) do
        if targetPlayer ~= S.LP then
            local username = targetPlayer.Name:lower()
            local displayName = targetPlayer.DisplayName:lower()
            local usernameScore, displayScore = 0, 0

            if username:find(input, 1, true) then
                usernameScore = (#input / #username) * 100

                if username:sub(1, #input) == input then
                    usernameScore = usernameScore + 50
                end
            end

            if displayName:find(input, 1, true) then
                displayScore = (#input / #displayName) * 100

                if displayName:sub(1, #input) == input then
                    displayScore = displayScore + 50
                end
            end

            local score = math.max(usernameScore, displayScore)

            if score > bestScore then
                bestScore = score
                bestMatch = targetPlayer
            end
        end
    end

    return bestScore > 20 and bestMatch or nil
end

function H.KBuildWhitelist()
    local t = {}

    for _, info in ipairs(D.KillerWhitelist) do
        local name = info:match("^(.-)%s*%(")

        if name then
            t[name:lower()] = true
        end

        local display = info:match("%((.-)%)")

        if display then
            t[display:lower()] = true
        end
    end

    return t
end

function H.KEquipPet(petName)
    local petsFolder = S.LP:FindFirstChild("petsFolder")

    if not petsFolder then
        return
    end

    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                pcall(function()
                    S.RS.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                end)
            end
        end
    end

    task.wait(0.2)

    local toEquip = {}
    local unique = petsFolder:FindFirstChild("Unique")

    if unique then
        for _, pet in pairs(unique:GetChildren()) do
            if pet.Name == petName then
                table.insert(toEquip, pet)
            end
        end
    end

    for i = 1, math.min(8, #toEquip) do
        pcall(function()
            S.RS.rEvents.equipPetEvent:FireServer("equipPet", toEquip[i])
        end)

        task.wait(0.1)
    end
end

R.Killer:Paragraph({
    Title = "Equip Pets",
    Desc = "Equipar mascotas para Killer"
})

R.Killer:Button({
    Title = "Equip Wild Wizard",
    Callback = function()
        H.KEquipPet("Wild Wizard")
    end
})

R.Killer:Button({
    Title = "Equip Mighty Monster",
    Callback = function()
        H.KEquipPet("Mighty Monster")
    end
})

R.Killer:Paragraph({
    Title = "Kill Clans",
    Desc = "Matar jugadores según tags"
})

function H.KHasActiveTag()
    for _, active in pairs(V.KillerTagState) do
        if active then
            return true
        end
    end

    return false
end

function H.KGetTagTargets()
    local targets = {}

    for _, targetPlayer in ipairs(S.Players:GetPlayers()) do
        if targetPlayer == S.LP then
            continue
        end

        local lowerName = string.lower(targetPlayer.Name)
        local lowerDisplay = string.lower(targetPlayer.DisplayName)

        for tag, active in pairs(V.KillerTagState) do
            if active then
                local keyword = string.lower(tag)

                if string.find(lowerName, keyword, 1, true)
                or string.find(lowerDisplay, keyword, 1, true) then
                    table.insert(targets, targetPlayer)
                    break
                end
            end
        end
    end

    return targets
end

V.KillerClanPunch = false

function H.KClanPunch()
    V.KillerClanPunch = H.KHasActiveTag()
    H.KPunchLoop(V.KillerClanPunch)
end

for _, tag in ipairs(D.KillerTags) do
    R.Killer:Toggle({
        Title = "Kill " .. tag,
        Value = V.KillerTagState[tag],
        Callback = function(state)
            V.KillerTagState[tag] = state
            H.KClanPunch()
        end
    })
end

task.spawn(function()
    while task.wait(0.1) do
        if MH.Gen ~= myGen then
            break
        end

        if not H.KHasActiveTag() then
            continue
        end

        pcall(function()
            for _, targetPlayer in ipairs(H.KGetTagTargets()) do
                if not H.KHasActiveTag() then
                    break
                end

                H.KTpAndKill(targetPlayer, H.KHasActiveTag)
            end
        end)
    end
end)

R.Killer:Paragraph({
    Title = "Misc",
    Desc = "Opciones adicionales"
})

function H.KGetEquipPetRemote()
    local rEvents = S.RS:FindFirstChild("rEvents")
    return rEvents and rEvents:FindFirstChild("equipPetEvent")
end

function H.KUnequipAllPets(remote, petsFolder)
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                remote:FireServer("unequipPet", pet)
            end
        end
    end
end

function H.KGetPetsByName(folder, name)
    local t = {}

    for _, pet in pairs(folder:GetChildren()) do
        if pet.Name == name then
            table.insert(t, pet)
        end
    end

    return t
end

V.PackSpam = false

R.Killer:Toggle({
    Title = "Pack Spam",
    Value = V.PackSpam,
    Callback = function(state)
        V.PackSpam = state

        if not state then
            return
        end

        if C.KillerPackSpamRunning then
            return
        end

        C.KillerPackSpamRunning = true

        task.spawn(function()
            local petsFolder = S.LP:FindFirstChild("petsFolder")

            if not petsFolder then
                V.PackSpam = false
                C.KillerPackSpamRunning = false
                return
            end

            local unique = petsFolder:FindFirstChild("Unique")

            if not unique then
                V.PackSpam = false
                C.KillerPackSpamRunning = false
                return
            end

            local remote = H.KGetEquipPetRemote()

            if not remote then
                V.PackSpam = false
                C.KillerPackSpamRunning = false
                return
            end

            while V.PackSpam do
                H.KUnequipAllPets(remote, petsFolder)
                task.wait()

                local mighty = H.KGetPetsByName(unique, "Mighty Monster")

                for i = 1, math.min(7, #mighty) do
                    if not V.PackSpam then
                        break
                    end

                    remote:FireServer("equipPet", mighty[i])
                    task.wait()
                end

                task.wait()
            end

            C.KillerPackSpamRunning = false
        end)
    end
})

function H.KRemoveBillboard(character)
    if not character then
        return
    end

    local old = character:FindFirstChild("HP_BILLBOARD")

    if old then
        old:Destroy()
    end
end

function H.KCreateBillboard(humanoid, character)
    local head = character:WaitForChild("Head", 5)

    if not head then
        return
    end

    H.KRemoveBillboard(character)

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HP_BILLBOARD"
    billboard.Size = UDim2.new(6, 0, 1.2, 0)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 200
    billboard.Parent = head

    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BorderSizePixel = 0
    frame.Parent = billboard

    local bar = Instance.new("Frame")
    bar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    bar.Size = UDim2.new(1, 0, 1, 0)
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.TextStrokeTransparency = 0.5
    label.Parent = frame

    if C.KillerHealthConnections then
        C.KillerHealthConnections[humanoid] = nil
    else
        C.KillerHealthConnections = {}
    end

    local function updateHP()
        if humanoid and humanoid.Parent then
            local hp = humanoid.Health
            local max = humanoid.MaxHealth

            if max <= 0 then
                max = 1
            end

            bar.Size = UDim2.new(
                math.clamp(hp / max, 0, 1),
                0,
                1,
                0
            )

            label.Text =
                H.FormatNumber(hp)
                .. " / "
                .. H.FormatNumber(max)
        end
    end

    local healthConn = humanoid.HealthChanged:Connect(updateHP)

    C.KillerHealthConnections[humanoid] = healthConn

    humanoid.Died:Once(function()
        if C.KillerHealthConnections then
            C.KillerHealthConnections[humanoid] = nil
        end

        if healthConn then
            healthConn:Disconnect()
        end
    end)

    updateHP()
end

function H.KOnCharacterAdded(character)
    if not V.KillerShowVidaTodos then
        return
    end

    local humanoid = character:WaitForChild("Humanoid", 5)

    if humanoid then
        H.KCreateBillboard(humanoid, character)
    end
end

R.Killer:Toggle({
    Title = "Ver Vida De Todos",
    Value = V.KillerShowVidaTodos,
    Callback = function(state)
        V.KillerShowVidaTodos = state

        if not state then
            for _, plr in ipairs(S.Players:GetPlayers()) do
                if plr.Character then
                    H.KRemoveBillboard(plr.Character)
                end
            end

            if C.KillerHealthConnections then
                for humanoid, connection in pairs(C.KillerHealthConnections) do
                    if connection then
                        connection:Disconnect()
                    end

                    C.KillerHealthConnections[humanoid] = nil
                end
            end

            return
        end

        for _, plr in ipairs(S.Players:GetPlayers()) do
            if plr ~= S.LP and plr.Character then
                H.KOnCharacterAdded(plr.Character)
            end
        end
    end
})

if C.KillerCharacterAddedConnections then
    for _, connection in pairs(C.KillerCharacterAddedConnections) do
        connection:Disconnect()
    end
end

C.KillerCharacterAddedConnections = {}

for _, plr in ipairs(S.Players:GetPlayers()) do
    if plr ~= S.LP then
        if plr.Character then
            H.KOnCharacterAdded(plr.Character)
        end

        table.insert(
            C.KillerCharacterAddedConnections,
            plr.CharacterAdded:Connect(H.KOnCharacterAdded)
        )
    end
end

if C.KillerPlayerAddedVidaConn then
    C.KillerPlayerAddedVidaConn:Disconnect()
end

C.KillerPlayerAddedVidaConn = S.Players.PlayerAdded:Connect(function(plr)
    if plr == S.LP then
        return
    end

    table.insert(
        C.KillerCharacterAddedConnections,
        plr.CharacterAdded:Connect(H.KOnCharacterAdded)
    )
end)

D.KillerTeleportsSmall = {
    CFrame.new(-64.8117752, 8.05423164, 1980.43774),
    CFrame.new(1.79557395, 8.05132198, 1997.70691),
    CFrame.new(-34.4953041, 8.05301666, 1958.7793),
}

D.KillerTeleportsSecret = {
    CFrame.new(1943, 3, 6215),
    CFrame.new(1916, 3, 6164),
    CFrame.new(1989, 3, 6178),
}

R.Killer:Toggle({
    Title = "Anti Hit (TP) Isla Pequeña",
    Value = V.KillerAntiHitPequena,
    Callback = function(state)
        V.KillerAntiHitPequena = state

        if not state then
            return
        end

        if C.KillerAntiHitPequenaRunning then
            return
        end

        C.KillerAntiHitPequenaRunning = true

        task.spawn(function()
            while V.KillerAntiHitPequena do
                local char = S.LP.Character

                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, cf in ipairs(D.KillerTeleportsSmall) do
                        if not V.KillerAntiHitPequena then
                            break
                        end

                        char.HumanoidRootPart.CFrame = cf
                        task.wait(0.001)
                    end
                end

                task.wait(0.001)
            end

            C.KillerAntiHitPequenaRunning = false
        end)
    end
})

R.Killer:Toggle({
    Title = "Anti Hit (TP) Isla Secreta",
    Value = V.KillerAntiHitSecreta,
    Callback = function(state)
        V.KillerAntiHitSecreta = state

        if not state then
            return
        end

        if C.KillerAntiHitSecretaRunning then
            return
        end

        C.KillerAntiHitSecretaRunning = true

        task.spawn(function()
            while V.KillerAntiHitSecreta do
                local char = S.LP.Character

                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, cf in ipairs(D.KillerTeleportsSecret) do
                        if not V.KillerAntiHitSecreta then
                            break
                        end

                        char.HumanoidRootPart.CFrame = cf
                        task.wait(0.001)
                    end
                end

                task.wait(0.001)
            end

            C.KillerAntiHitSecretaRunning = false
        end)
    end
})

R.Killer:Toggle({
    Title = "No Comer Eggs",
    Value = false,
    Callback = function(state)
        if state and not C.KillerNoEggsLoaded then
            C.KillerNoEggsLoaded = true

            task.spawn(function()
                pcall(function()
                    loadstring(game:HttpGet(
                        "https://raw.githubusercontent.com/SadOz8/Stuffs/refs/heads/main/Crack"
                    ))()
                end)
            end)
        end
    end
})

V.KillerAntiLagSettings = V.KillerAntiLagSettings or {
    RemoveParticles = true,
    RemoveTrails = true,
    RemoveBeams = true,
    RemoveExplosions = true,
    RemoveDecals = true,
    SmoothPlastic = true,
    LowGraphics = true,
    DisableShadows = true,
    ReduceRenderDistance = true,
    DisableSounds = false,
}

function H.KCleanLighting()
    if not V.KillerAntiLag
        or not V.KillerAntiLagSettings.LowGraphics then
        return
    end

    for _, effect in ipairs(S.Lighting:GetChildren()) do
        if effect:IsA("BloomEffect")
        or effect:IsA("SunRaysEffect")
        or effect:IsA("DepthOfFieldEffect")
        or effect:IsA("ColorCorrectionEffect")
        or effect:IsA("BlurEffect") then
            effect.Enabled = false
        end
    end

    S.Lighting.GlobalShadows =
        not V.KillerAntiLagSettings.DisableShadows

    if V.KillerAntiLagSettings.ReduceRenderDistance then
        S.Lighting.FogEnd = 500
    end

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

function H.KCleanInstance(obj)
    if not V.KillerAntiLag then
        return
    end

    local s = V.KillerAntiLagSettings

    if s.RemoveParticles and obj:IsA("ParticleEmitter") then
        obj.Enabled = false

    elseif s.RemoveTrails and obj:IsA("Trail") then
        obj.Enabled = false

    elseif s.RemoveBeams and obj:IsA("Beam") then
        obj.Enabled = false

    elseif s.RemoveExplosions and obj:IsA("Explosion") then
        obj.BlastPressure = 0
        obj.BlastRadius = 0

    elseif s.RemoveDecals and (obj:IsA("Decal") or obj:IsA("Texture")) then
        obj.Transparency = 1

    elseif s.SmoothPlastic and obj:IsA("BasePart") then
        if obj.Material ~= Enum.Material.Neon
        and obj.Material ~= Enum.Material.ForceField then
            obj.Material = Enum.Material.SmoothPlastic
        end

    elseif s.DisableSounds and obj:IsA("Sound") then
        obj.Volume = 0
    end
end

if C.KillerAntiLagConn then
    C.KillerAntiLagConn:Disconnect()
end

C.KillerAntiLagConn = workspace.DescendantAdded:Connect(function(obj)
    if V.KillerAntiLag then
        task.defer(H.KCleanInstance, obj)
    end
end)

R.Killer:Toggle({
    Title = "Anti Lag",
    Value = V.KillerAntiLag,
    Callback = function(state)
        V.KillerAntiLag = state

        if state then
            H.KCleanLighting()

            for _, obj in ipairs(workspace:GetDescendants()) do
                H.KCleanInstance(obj)
            end
        end
    end
})

V.KillerAnimBlock = false

function H.KillerShouldBlockAnimation(track)
    if not track or not track.Animation then
        return false
    end

    local blockedAnimations = {
        ["rbxassetid://3638729053"] = true,
        ["rbxassetid://3638767427"] = true,
    }

    local animId = track.Animation.AnimationId
    local animName = track.Name:lower()

    return blockedAnimations[animId]
        or animName:match("punch")
        or animName:match("attack")
        or animName:match("right")
end

function H.KillerSetupAnimationBlocking()
    if not V.KillerAnimBlock then
        return
    end

    if C.KillerAnimBlockConn then
        C.KillerAnimBlockConn:Disconnect()
        C.KillerAnimBlockConn = nil
    end

    local char = S.LP.Character

    if not char then
        return
    end

    local humanoid = char:FindFirstChild("Humanoid")

    if not humanoid then
        return
    end

    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if H.KillerShouldBlockAnimation(track) then
            track:Stop()
        end
    end

    C.KillerAnimBlockConn =
        humanoid.AnimationPlayed:Connect(function(track)
            if V.KillerAnimBlock
            and H.KillerShouldBlockAnimation(track) then
                track:Stop()
            end
        end)
end

R.Killer:Button({
    Title = "Quitar La Animacion Al Punch",
    Callback = function()
        V.KillerAnimBlock = true
        H.KillerSetupAnimationBlocking()

        if not C.KillerAnimMonitorConn then
            C.KillerAnimMonitorConn = S.Run.Heartbeat:Connect(function()
                if not V.KillerAnimBlock then
                    return
                end

                local char = S.LP.Character

                if not char then
                    return
                end

                local humanoid = char:FindFirstChild("Humanoid")

                if not humanoid then
                    return
                end

                for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                    if H.KillerShouldBlockAnimation(track) then
                        track:Stop()
                    end
                end
            end)
        end

        if not C.KillerCharAddedConn then
            C.KillerCharAddedConn =
                S.LP.CharacterAdded:Connect(function()
                    if V.KillerAnimBlock then
                        task.wait(1)
                        H.KillerSetupAnimationBlocking()
                    end
                end)
        end
    end
})

R.Killer:Button({
    Title = "Regresar La Animacion Al Punch",
    Callback = function()
        V.KillerAnimBlock = false

        if C.KillerAnimBlockConn then
            C.KillerAnimBlockConn:Disconnect()
            C.KillerAnimBlockConn = nil
        end

        if C.KillerAnimMonitorConn then
            C.KillerAnimMonitorConn:Disconnect()
            C.KillerAnimMonitorConn = nil
        end

        if C.KillerCharAddedConn then
            C.KillerCharAddedConn:Disconnect()
            C.KillerCharAddedConn = nil
        end
    end
})

R.KillerWhitelistLabel = R.Killer:Paragraph({
    Title = "Whitelist",
    Desc = "Whitelist: Ninguno"
})

function H.KUpdateWhitelistLabel()
    if #D.KillerWhitelist == 0 then
        if R.KillerWhitelistLabel then
            R.KillerWhitelistLabel:SetDesc("Whitelist: Ninguno")
        end
    else
        local names = {}

        for _, info in ipairs(D.KillerWhitelist) do
            table.insert(
                names,
                info:match("%((.-)%)") or info
            )
        end

        if R.KillerWhitelistLabel then
            R.KillerWhitelistLabel:SetDesc(
                "Whitelist: " .. table.concat(names, ", ")
            )
        end
    end
end

R.Killer:Input({
    Title = "Agregar Jugador a Whitelist",
    Placeholder = "Nombre o DisplayName",
    Callback = function(text)
        if not text or text == "" then
            return
        end

        local targetPlayer = H.KFindClosestPlayer(text)

        if not targetPlayer then
            return
        end

        local playerInfo =
            targetPlayer.Name .. " (" .. targetPlayer.DisplayName .. ")"

        local already = false

        for _, info in ipairs(D.KillerWhitelist) do
            if info:find(targetPlayer.Name, 1, true) then
                already = true
                break
            end
        end

        if not already then
            table.insert(D.KillerWhitelist, playerInfo)
            H.KUpdateWhitelistLabel()
        end
    end
})

R.Killer:Input({
    Title = "Quitar Jugador de Whitelist",
    Placeholder = "Nombre",
    Callback = function(text)
        if not text or text == "" then
            return
        end

        local textLower = text:lower()

        for i, info in ipairs(D.KillerWhitelist) do
            if info:lower():find(textLower, 1, true) then
                table.remove(D.KillerWhitelist, i)
                H.KUpdateWhitelistLabel()
                return
            end
        end
    end
})

R.Killer:Toggle({
    Title = "Agregar Amigos a WhiteList",
    Value = V.WhitelistFriends,
    Callback = function(state)
        V.WhitelistFriends = state

        if not state then
            return
        end

        pcall(function()
            for _, targetPlayer in pairs(S.Players:GetPlayers()) do
                if targetPlayer ~= S.LP
                and targetPlayer:IsFriendsWith(S.LP.UserId) then
                    local playerInfo =
                        targetPlayer.Name .. " (" .. targetPlayer.DisplayName .. ")"

                    if not table.find(D.KillerWhitelist, playerInfo) then
                        table.insert(D.KillerWhitelist, playerInfo)
                    end
                end
            end

            H.KUpdateWhitelistLabel()
        end)
    end
})

if C.KillerWhitelistFriendAddedConn then
    C.KillerWhitelistFriendAddedConn:Disconnect()
end

C.KillerWhitelistFriendAddedConn =
    S.Players.PlayerAdded:Connect(function(targetPlayer)
        if not V.WhitelistFriends then
            return
        end

        pcall(function()
            if targetPlayer:IsFriendsWith(S.LP.UserId) then
                local playerInfo =
                    targetPlayer.Name .. " (" .. targetPlayer.DisplayName .. ")"

                if not table.find(D.KillerWhitelist, playerInfo) then
                    table.insert(D.KillerWhitelist, playerInfo)
                    H.KUpdateWhitelistLabel()
                end
            end
        end)
    end)

R.Killer:Button({
    Title = "Limpiar Whitelist",
    Callback = function()
        D.KillerWhitelist = {}
        H.KUpdateWhitelistLabel()
    end
})

R.Killer:Paragraph({
    Title = "Killing",
    Desc = "Opciones de eliminación"
})

V.KillerAutoKillAll = false
V.KillerAutoKillAllPunch = false

function H.KPunchAutoKillAll()
    V.KillerAutoKillAllPunch = V.KillerAutoKillAll
    H.KPunchLoop(V.KillerAutoKillAllPunch)
end

R.Killer:Toggle({
    Title = "AutoKill All",
    Value = V.KillerAutoKillAll,
    Callback = function(state)
        V.KillerAutoKillAll = state
        H.KPunchAutoKillAll()

        if not state then
            return
        end

        if C.KillerAutoKillAllRunning then
            return
        end

        C.KillerAutoKillAllRunning = true

        task.spawn(function()
            while V.KillerAutoKillAll do
                local whitelist = H.KBuildWhitelist()
                local killedAny = false

                for _, plr in ipairs(S.Players:GetPlayers()) do
                    if not V.KillerAutoKillAll then
                        break
                    end

                    if plr == S.LP then
                        continue
                    end

                    if whitelist[plr.Name:lower()]
                    or whitelist[plr.DisplayName:lower()] then
                        continue
                    end

                    local char = plr.Character

                    if not char then
                        continue
                    end

                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local hrp = char:FindFirstChild("HumanoidRootPart")

                    if not hum or not hrp or hum.Health <= 0 then
                        continue
                    end

                    killedAny = true

                    H.KTpAndKill(plr, function()
                        return V.KillerAutoKillAll
                    end)
                end

                task.wait(killedAny and 0.05 or 0.5)
            end

            C.KillerAutoKillAllRunning = false
        end)
    end
})

V.KillerSpyTarget = V.KillerSpyTarget or ""

R.KillerSpyDropdown = R.Killer:Dropdown({
    Title = "Seleccionar Jugador Para Ver",
    Values = {},
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(val)
        if val and val ~= "" then
            local name = val:match("%-%s*(.-)%s*$")

            V.KillerSpyTarget =
                name and name:match("^%s*(.-)%s*$") or ""
        else
            V.KillerSpyTarget = ""
        end
    end
})

function H.KRefreshSpyDropdown()
    local values = {}

    for _, plr in ipairs(S.Players:GetPlayers()) do
        table.insert(
            values,
            plr.DisplayName .. " - " .. plr.Name
        )
    end

    if R.KillerSpyDropdown then
        R.KillerSpyDropdown:Refresh(values)
    end
end

H.KRefreshSpyDropdown()

if C.KillerSpyDropdownAddedConn then
    C.KillerSpyDropdownAddedConn:Disconnect()
end

if C.KillerSpyDropdownRemovingConn then
    C.KillerSpyDropdownRemovingConn:Disconnect()
end

C.KillerSpyDropdownAddedConn =
    S.Players.PlayerAdded:Connect(function()
        H.KRefreshSpyDropdown()
    end)

C.KillerSpyDropdownRemovingConn =
    S.Players.PlayerRemoving:Connect(function(plr)
        if plr.Name == V.KillerSpyTarget then
            V.KillerSpyTarget = ""
        end

        H.KRefreshSpyDropdown()
    end)

R.Killer:Toggle({
    Title = "Ver Jugador",
    Value = false,
    Callback = function(bool)
        V.KillerSpying = bool

        if not bool then
            local cam = workspace.CurrentCamera

            cam.CameraSubject =
                S.LP.Character
                and S.LP.Character:FindFirstChild("Humanoid")
                or S.LP

            return
        end

        if C.KillerSpyingRunning then
            return
        end

        C.KillerSpyingRunning = true

        task.spawn(function()
            while V.KillerSpying do
                local target =
                    V.KillerSpyTarget ~= ""
                    and S.Players:FindFirstChild(V.KillerSpyTarget)
                    or nil

                if target and target ~= S.LP then
                    local humanoid =
                        target.Character
                        and target.Character:FindFirstChild("Humanoid")

                    if humanoid then
                        workspace.CurrentCamera.CameraSubject = humanoid
                    end
                end

                task.wait(0.1)
            end

            C.KillerSpyingRunning = false
        end)
    end
})

R.KillerBlacklistLabel = R.Killer:Paragraph({
    Title = "Blacklist",
    Desc = "Blacklist: empty"
})

function H.KUpdateBlacklistLabel()
    if R.KillerBlacklistLabel then
        R.KillerBlacklistLabel:SetDesc(
            #D.KillerBlacklist == 0
            and "Blacklist: empty"
            or "Blacklist: " .. table.concat(D.KillerBlacklist, ", ")
        )
    end
end

R.KillerBlacklistDropdown = R.Killer:Dropdown({
    Title = "Agregar a BlackList",
    Values = {},
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(selectedItem)
        if not selectedItem or selectedItem == "" then
            return
        end

        local selectedUser =
            selectedItem:match("%-%s*(.-)%s*$")

        selectedUser =
            selectedUser
            and selectedUser:match("^%s*(.-)%s*$")

        if not selectedUser then
            return
        end

        for _, plr in ipairs(S.Players:GetPlayers()) do
            if plr.Name == selectedUser then
                local playerInfo =
                    plr.Name .. " (" .. plr.DisplayName .. ")"

                if not table.find(D.KillerBlacklist, playerInfo) then
                    table.insert(D.KillerBlacklist, playerInfo)
                    H.KUpdateBlacklistLabel()
                end
            end
        end
    end
})

function H.KRefreshBlacklistDropdown()
    local values = {}

    for _, plr in ipairs(S.Players:GetPlayers()) do
        table.insert(
            values,
            plr.DisplayName .. " - " .. plr.Name
        )
    end

    if R.KillerBlacklistDropdown then
        R.KillerBlacklistDropdown:Refresh(values)
    end
end

H.KRefreshBlacklistDropdown()

if C.KillerBlacklistDropdownAddedConn then
    C.KillerBlacklistDropdownAddedConn:Disconnect()
end

if C.KillerBlacklistDropdownRemovingConn then
    C.KillerBlacklistDropdownRemovingConn:Disconnect()
end

C.KillerBlacklistDropdownAddedConn =
    S.Players.PlayerAdded:Connect(function()
        H.KRefreshBlacklistDropdown()
    end)

C.KillerBlacklistDropdownRemovingConn =
    S.Players.PlayerRemoving:Connect(function()
        H.KRefreshBlacklistDropdown()
    end)

R.Killer:Toggle({
    Title = "Matar BlackList",
    Value = false,
    Callback = function(state)
        V.KillerMatarBlacklist = state

        if not state then
            return
        end

        if C.KillerMatarBlacklistRunning then
            return
        end

        C.KillerMatarBlacklistRunning = true

        task.spawn(function()
            while V.KillerMatarBlacklist do
                pcall(function()
                    for _, info in ipairs(D.KillerBlacklist) do
                        if not V.KillerMatarBlacklist then
                            break
                        end

                        local targetName = info:match("^(%S+)")
                        local targetPlayer =
                            S.Players:FindFirstChild(targetName)

                        if targetPlayer
                            and targetPlayer.Character
                            and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                            and targetPlayer.Character:FindFirstChild("Humanoid")
                            and targetPlayer.Character.Humanoid.Health > 0 then

                            H.KTpAndKill(
                                targetPlayer,
                                function()
                                    return V.KillerMatarBlacklist
                                end
                            )
                        end
                    end
                end)

                task.wait(0.2)
            end

            C.KillerMatarBlacklistRunning = false
        end)
    end
})

V.KillerFastPunch = false

function H.KFastPunch()
    H.KPunchLoop(V.KillerFastPunch)
end

R.Killer:Toggle({
    Title = "Fast Punch",
    Value = V.KillerFastPunch,
    Callback = function(state)
        V.KillerFastPunch = state
        H.KFastPunch()
    end
})

R.Killer:Button({
    Title = "Quitar Ultimo de BlackList",
    Callback = function()
        if #D.KillerBlacklist > 0 then
            table.remove(D.KillerBlacklist)
            H.KUpdateBlacklistLabel()
        end
    end
})

R.Killer:Button({
    Title = "Limpiar BlackList",
    Callback = function()
        D.KillerBlacklist = {}
        H.KUpdateBlacklistLabel()
    end
})

R.Killer:Paragraph({
    Title = "Kill Aura",
    Desc = "Death Ring"
})

V.KillerRingPart = nil
V.KillerRingColor = Color3.fromRGB(255, 255, 255)
V.KillerRingTransparency = 0.5

function H.KUpdateRingSize()
    if not V.KillerRingPart then
        return
    end

    local diameter = (V.DeathRingRange or 20) * 2

    V.KillerRingPart.Size = Vector3.new(
        0.2,
        diameter,
        diameter
    )
end

R.Killer:Input({
    Title = "Rango 1-140",
    Placeholder = "20",
    Callback = function(text)
        local range = tonumber(text)

        if range then
            V.DeathRingRange = math.clamp(range, 1, 140)
            H.KUpdateRingSize()
        end
    end
})

function H.KToggleRingVisual()
    if V.ShowDeathRing then
        if V.KillerRingPart then
            V.KillerRingPart:Destroy()
            V.KillerRingPart = nil
        end

        local ring = Instance.new("Part")

        ring.Shape = Enum.PartType.Cylinder
        ring.Material = Enum.Material.Neon
        ring.Color = V.KillerRingColor
        ring.Transparency = V.KillerRingTransparency
        ring.Anchored = true
        ring.CanCollide = false
        ring.CastShadow = false

        V.KillerRingPart = ring

        H.KUpdateRingSize()

        ring.Parent = workspace

    elseif V.KillerRingPart then
        V.KillerRingPart:Destroy()
        V.KillerRingPart = nil
    end
end

function H.KUpdateRingPosition()
    if not V.KillerRingPart then
        return
    end

    local character = H.KGetCharacter()

    local rootPart =
        character
        and character:FindFirstChild("HumanoidRootPart")

    if rootPart then
        V.KillerRingPart.CFrame =
            rootPart.CFrame
            * CFrame.Angles(0, 0, math.rad(90))
    end
end

V.DeathRingEnabled = false
V.KillerDeathRingPunch = false

function H.KPunchDeathRing()
    V.KillerDeathRingPunch = V.DeathRingEnabled
    H.KPunchLoop(V.KillerDeathRingPunch)
end

R.KillerDeathRingToggle =
    R.Killer:Toggle({
        Title = "Death Ring",
        Value = V.DeathRingEnabled,
        Callback = function(bool)
            V.DeathRingEnabled = bool
            H.KPunchDeathRing()

            if bool then
                if not C.KillerDeathRingConn then
                    V.KillerDeathRingBusyFor =
                        V.KillerDeathRingBusyFor or {}

                    C.KillerDeathRingConn =
                        S.Run.Heartbeat:Connect(function()
                            H.KUpdateRingPosition()

                            local character = H.KGetCharacter()

                            local myPosition =
                                character
                                and character:FindFirstChild("HumanoidRootPart")
                                and character.HumanoidRootPart.Position

                            if not myPosition then
                                return
                            end

                            local whitelist = H.KBuildWhitelist()

                            for _, target in ipairs(S.Players:GetPlayers()) do
                                if target == S.LP then
                                    continue
                                end

                                if whitelist[target.Name:lower()]
                                or whitelist[target.DisplayName:lower()] then
                                    continue
                                end

                                if V.KillerDeathRingBusyFor[target] then
                                    continue
                                end

                                local targetChar = target.Character

                                local targetRoot =
                                    targetChar
                                    and targetChar:FindFirstChild("HumanoidRootPart")

                                local targetHumanoid =
                                    targetChar
                                    and targetChar:FindFirstChild("Humanoid")

                                if not (
                                    targetRoot
                                    and targetHumanoid
                                    and targetHumanoid.Health > 0
                                ) then
                                    continue
                                end

                                local distance =
                                    (myPosition - targetRoot.Position).Magnitude

                                if distance <= (V.DeathRingRange or 20) then
                                    V.KillerDeathRingBusyFor[target] = true

                                    task.spawn(function()
                                        H.KKillPlayer(target)
                                        V.KillerDeathRingBusyFor[target] = nil
                                    end)
                                end
                            end
                        end)
                end
            elseif C.KillerDeathRingConn then
                C.KillerDeathRingConn:Disconnect()
                C.KillerDeathRingConn = nil
            end
        end
    })

R.KillerShowRingToggle =
    R.Killer:Toggle({
        Title = "Show Ring",
        Value = V.ShowDeathRing,
        Callback = function(bool)
            V.ShowDeathRing = bool
            H.KToggleRingVisual()
        end
    })

R.Killer:Paragraph({
    Title = "Sizes",
    Desc = "Cambiar tamaño del personaje"
})

R.Killer:Button({
    Title = "Size 2",
    Callback = function()
        pcall(function()
            S.RS.rEvents.changeSpeedSizeRemote:InvokeServer(
                "changeSize",
                2
            )
        end)
    end
})

R.Killer:Button({
    Title = "Size 30",
    Callback = function()
        pcall(function()
            S.RS.rEvents.changeSpeedSizeRemote:InvokeServer(
                "changeSize",
                30
            )
        end)
    end
})

R.Killer:Button({
    Title = "Size 70",
    Callback = function()
        pcall(function()
            S.RS.rEvents.changeSpeedSizeRemote:InvokeServer(
                "changeSize",
                70
            )
        end)
    end
})

function H.KTrim(s)
    return s:match("^%s*(.-)%s*$")
end

function H.KParseBlacklist(text)
    D.KillerBlacklistWords = {}

    if not text or text == "" then
        return
    end

    for w in string.gmatch(text, "[^,]+") do
        local t = H.KTrim(w):lower()

        if t ~= "" then
            table.insert(D.KillerBlacklistWords, t)
        end
    end
end

pcall(function()
    if isfile and isfile(V.KillerFileName) then
        H.KParseBlacklist(readfile(V.KillerFileName))
    elseif writefile then
        writefile(V.KillerFileName, "")
    end
end)

function H.KSaveBlacklist()
    pcall(function()
        if writefile then
            writefile(
                V.KillerFileName,
                table.concat(D.KillerBlacklistWords, ",")
            )
        end
    end)
end

function H.KNameMatchesAny(targetPlayer)
    if not targetPlayer then
        return false
    end

    local username = (targetPlayer.Name or ""):lower()
    local displayName = (targetPlayer.DisplayName or ""):lower()

    for _, w in ipairs(D.KillerBlacklistWords) do
        if w ~= "" then
            if string.find(displayName, w, 1, true)
            or string.find(username, w, 1, true) then
                return true
            end
        end
    end

    return false
end

function H.KRefreshActive()
    for k in pairs(St.KillerActive) do
        St.KillerActive[k] = nil
    end

    for _, plr in ipairs(S.Players:GetPlayers()) do
        if plr ~= S.LP and H.KNameMatchesAny(plr) then
            St.KillerActive[plr] = true
        end
    end
end

function H.KIsAnyActive()
    for _ in pairs(St.KillerActive) do
        return true
    end

    return false
end

R.KillerWordBlacklistLabel =
    R.Killer:Paragraph({
        Title = "Blacklist",
        Desc = "Blacklist: (empty)"
    })

function H.KUpdateWordBlacklistLabel()
    if R.KillerWordBlacklistLabel then
        R.KillerWordBlacklistLabel:SetDesc(
            "Blacklist: "
            .. (
                #D.KillerBlacklistWords == 0
                and "(empty)"
                or table.concat(D.KillerBlacklistWords, ", ")
            )
        )
    end
end

H.KUpdateWordBlacklistLabel()

R.Killer:Input({
    Title = "Add to Blacklist",
    Placeholder = "Palabras separadas por coma",
    Callback = function(txt)
        if not txt or txt == "" then
            return
        end

        H.KParseBlacklist(
            table.concat(D.KillerBlacklistWords, ",")
            .. ","
            .. txt
        )

        H.KSaveBlacklist()
        H.KUpdateWordBlacklistLabel()
        H.KRefreshActive()
    end
})

R.Killer:Input({
    Title = "Remove from Blacklist",
    Placeholder = "Palabras separadas por coma",
    Callback = function(txt)
        if not txt or txt == "" then
            return
        end

        local toRemove = {}

        for w in string.gmatch(txt, "[^,]+") do
            local t = H.KTrim(w):lower()

            if t ~= "" then
                table.insert(toRemove, t)
            end
        end

        for _, word in ipairs(toRemove) do
            for i = #D.KillerBlacklistWords, 1, -1 do
                if D.KillerBlacklistWords[i] == word then
                    table.remove(D.KillerBlacklistWords, i)
                end
            end
        end

        H.KSaveBlacklist()
        H.KUpdateWordBlacklistLabel()
        H.KRefreshActive()
    end
})

if C.KillerBlacklistRefreshRemovingConn then
    C.KillerBlacklistRefreshRemovingConn:Disconnect()
end

C.KillerBlacklistRefreshRemovingConn =
    S.Players.PlayerRemoving:Connect(function()
        H.KRefreshActive()
    end)

if C.KillerBlacklistRefreshAddedConn then
    C.KillerBlacklistRefreshAddedConn:Disconnect()
end

C.KillerBlacklistRefreshAddedConn =
    S.Players.PlayerAdded:Connect(function(plr)
        plr:GetPropertyChangedSignal("DisplayName"):Connect(function()
            H.KRefreshActive()
        end)

        H.KRefreshActive()
    end)

if C.KillerBlacklistDisplayConnections then
    for _, connection in pairs(C.KillerBlacklistDisplayConnections) do
        connection:Disconnect()
    end
end

C.KillerBlacklistDisplayConnections = {}

for _, plr in ipairs(S.Players:GetPlayers()) do
    if plr ~= S.LP then
        table.insert(
            C.KillerBlacklistDisplayConnections,
            plr:GetPropertyChangedSignal("DisplayName"):Connect(
                H.KRefreshActive
            )
        )
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)

        if MH.Gen ~= myGen then
            break
        end

        if not H.KIsAnyActive() then
            continue
        end

        local char = S.LP.Character

        if not char then
            continue
        end

        for plr in pairs(St.KillerActive) do
            if not H.KIsAnyActive() then
                break
            end

            if not plr or not plr.Parent then
                St.KillerActive[plr] = nil
                continue
            end

            if plr.Character then
                local hum =
                    plr.Character:FindFirstChild("Humanoid")

                local hrp =
                    plr.Character:FindFirstChild("HumanoidRootPart")

                if hum and hrp and hum.Health > 0 then
                    H.KTpAndKill(
                        plr,
                        H.KIsAnyActive
                    )
                end
            end
        end
    end
end)

H.KRefreshActive()

R.Stats = R.Players:Tab({
    Title = "Stats",
    Icon = "chart-no-axes-column",
    ShowTabTitle = true
})

St.SpyState = St.SpyState or {
    selectedName = ""
}

function H.BuildStatsPlayerList()
    local list = {}

    for _, plr in pairs(S.Players:GetPlayers()) do
        table.insert(
            list,
            plr.Name .. " - " .. plr.DisplayName
        )
    end

    return list
end

R.StatsPlayerDropdown = R.Stats:Dropdown({
    Title = "Select Player",
    Values = H.BuildStatsPlayerList(),
    Value = nil,
    SearchBarEnabled = true,
    AllowNone = true,
    Callback = function(value)
        if value and value ~= "" then
            local name = value:match("^(.-)%s*%-")

            St.SpyState.selectedName =
                name
                and name:match("^%s*(.-)%s*$")
                or ""
        else
            St.SpyState.selectedName = ""
        end
    end
})

if C.StatsDropdownAddedConn then
    C.StatsDropdownAddedConn:Disconnect()
end

if C.StatsDropdownRemovingConn then
    C.StatsDropdownRemovingConn:Disconnect()
end

C.StatsDropdownAddedConn =
    S.Players.PlayerAdded:Connect(function()
        if R.StatsPlayerDropdown then
            R.StatsPlayerDropdown:Refresh(
                H.BuildStatsPlayerList()
            )
        end
    end)

C.StatsDropdownRemovingConn =
    S.Players.PlayerRemoving:Connect(function(plr)
        if plr.Name == St.SpyState.selectedName then
            St.SpyState.selectedName = ""
        end

        if R.StatsPlayerDropdown then
            R.StatsPlayerDropdown:Refresh(
                H.BuildStatsPlayerList()
            )
        end
    end)

function H.FormatSpyDisplay(value)
    return "[ "
        .. formatCommas(value)
        .. " | "
        .. formatShort(value)
        .. " ]"
end

local SpyLabels = {}
local advancedLabels = {}

local spyFields = {
    {"Gems", "gems", "Gems: "},
    {"agility", "agility", "Agility: "},
    {"Durability", "durability", "Durability: "},
    {"muscleKingTime", "muscleKingTime", "Muscle King Time: "},
    {"evilKarma", "evilKarma", "Evil Karma: "},
    {"goodKarma", "goodKarma", "Good Karma: "},
    {"Strength", "strength", "Strength: ", true},
    {"Rebirths", "rebirths", "Rebirths: ", true},
    {"Kills", "kills", "Kills: ", true}
}

function H.EnsureSpyLabelsCreated()
    if St.SpyLabelsCreated then
        return
    end

    St.SpyLabelsCreated = true

    R.Stats:Paragraph({
        Title = "Player Stats",
        Desc = ""
    })

    SpyLabels.strength =
        R.Stats:Paragraph({
            Title = "Strength",
            Desc = "Strength: 0"
        })

    SpyLabels.gems =
        R.Stats:Paragraph({
            Title = "Gems",
            Desc = "Gems: 0"
        })

    SpyLabels.rebirths =
        R.Stats:Paragraph({
            Title = "Rebirths",
            Desc = "Rebirths: 0"
        })

    SpyLabels.agility =
        R.Stats:Paragraph({
            Title = "Agility",
            Desc = "Agility: 0"
        })

    SpyLabels.durability =
        R.Stats:Paragraph({
            Title = "Durability",
            Desc = "Durability: 0"
        })

    SpyLabels.kills =
        R.Stats:Paragraph({
            Title = "Kills",
            Desc = "Kills: 0"
        })

    SpyLabels.muscleKingTime =
        R.Stats:Paragraph({
            Title = "Muscle King Time",
            Desc = "Muscle King Time: 0"
        })

    SpyLabels.currentMap =
        R.Stats:Paragraph({
            Title = "Current Map",
            Desc = "Current Map: N/A"
        })

    SpyLabels.evilKarma =
        R.Stats:Paragraph({
            Title = "Evil Karma",
            Desc = "Evil Karma: 0"
        })

    SpyLabels.goodKarma =
        R.Stats:Paragraph({
            Title = "Good Karma",
            Desc = "Good Karma: 0"
        })

    R.Stats:Divider()

    R.Stats:Paragraph({
        Title = "Advanced Stats",
        Desc = ""
    })

    advancedLabels.enemyHealth =
        R.Stats:Paragraph({
            Title = "Enemy Health",
            Desc = "Enemy Health: N/A"
        })

    advancedLabels.yourDamage =
        R.Stats:Paragraph({
            Title = "Your Damage",
            Desc = "Your Damage: N/A"
        })

    advancedLabels.hitsToKill =
        R.Stats:Paragraph({
            Title = "Hits to Kill",
            Desc = "Hits to Kill: N/A"
        })
end

H.EnsureSpyLabelsCreated()

function H.CountPetsEquipped(entity, keyword1, keyword2)
    local equippedPets =
        entity
        and entity:FindFirstChild("equippedPets")

    if not equippedPets then
        return 0
    end

    local count = 0

    for _, pet in ipairs(equippedPets:GetChildren()) do
        local ref = pet:FindFirstChild("petReference")

        local petName =
            ref
            and string.lower(tostring(ref.Value))

        if petName
            and petName:match(keyword1)
            and petName:match(keyword2) then

            count += 1
        end
    end

    return count
end

function H.CalculatePlayerHealth(entity)
    local character =
        entity
        and entity.Character

    local humanoid =
        character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        return humanoid.MaxHealth
    end

    return 0
end

function H.CalculatePlayerDamage(entity)
    if not entity then
        return 0
    end

    local leaderstats =
        entity:FindFirstChild("leaderstats")

    local strengthStat =
        leaderstats
        and leaderstats:FindFirstChild("Strength")

    if not strengthStat then
        return 0
    end

    local wildWizardCount =
        H.CountPetsEquipped(
            entity,
            "wild",
            "wizard"
        )

    local baseDamage =
        strengthStat.Value * 0.1

    return baseDamage
        * (1 + wildWizardCount / 3)
end

function H.CalculateHitsToKill(health, damage)
    if damage <= 0 then
        return "∞"
    end

    local hits =
        math.ceil(health / damage)

    if hits > 50 then
        return "∞"
    end

    return math.max(hits, 1)
end

if C.StatsUpdateLoop then
    C.StatsUpdateLoop = false
end

C.StatsUpdateLoop = true

task.spawn(function()
    while C.StatsUpdateLoop do
        pcall(function()
            local selected =
                St.SpyState.selectedName

            if selected == "" then
                SpyLabels.strength:SetDesc("Strength: 0")
                SpyLabels.gems:SetDesc("Gems: 0")
                SpyLabels.rebirths:SetDesc("Rebirths: 0")
                SpyLabels.agility:SetDesc("Agility: 0")
                SpyLabels.durability:SetDesc("Durability: 0")
                SpyLabels.kills:SetDesc("Kills: 0")
                SpyLabels.muscleKingTime:SetDesc("Muscle King Time: 0")
                SpyLabels.currentMap:SetDesc("Current Map: N/A")
                SpyLabels.evilKarma:SetDesc("Evil Karma: 0")
                SpyLabels.goodKarma:SetDesc("Good Karma: 0")

                advancedLabels.enemyHealth:SetDesc("Enemy Health: N/A")
                advancedLabels.yourDamage:SetDesc("Your Damage: N/A")
                advancedLabels.hitsToKill:SetDesc("Hits to Kill: N/A")

                return
            end

            local plr =
                S.Players:FindFirstChild(selected)

            if not plr then
                SpyLabels.strength:SetDesc(
                    "Strength: Jugador no encontrado"
                )

                return
            end

            local ls =
                plr:FindFirstChild("leaderstats")

            for _, field in ipairs(spyFields) do
                local source =
                    field[4]
                    and ls
                    or plr

                local obj =
                    source
                    and source:FindFirstChild(field[1])

                if obj then
                    SpyLabels[field[2]]:SetDesc(
                        field[3]
                        .. H.FormatSpyDisplay(
                            obj.Value
                        )
                    )
                end
            end

            local map =
                plr:FindFirstChild("currentMap")

            SpyLabels.currentMap:SetDesc(
                map
                and (
                    "Current Map: "
                    .. tostring(map.Value)
                )
                or "Current Map: No Hay Datos"
            )

            local enemyHealth =
                H.CalculatePlayerHealth(plr)

            local myDamage =
                H.CalculatePlayerDamage(S.LP)

            advancedLabels.enemyHealth:SetDesc(
                "Enemy Health: "
                .. H.FormatSpyDisplay(enemyHealth)
            )

            advancedLabels.yourDamage:SetDesc(
                "Your Damage: "
                .. H.FormatSpyDisplay(myDamage)
            )

            advancedLabels.hitsToKill:SetDesc(
                "Hits to Kill: "
                .. tostring(
                    H.CalculateHitsToKill(
                        enemyHealth,
                        myDamage
                    )
                )
            )
        end)

        task.wait(0.1)
    end
end)

local leaderstats = player:WaitForChild("leaderstats", 5)

State.originalStats = State.originalStats or {}
State.visualStats = State.visualStats or {}
State.visualStatRecords = State.visualStatRecords or setmetatable({}, {__mode = "k"})
State.visualOriginalLabels = State.visualOriginalLabels or setmetatable({}, {__mode = "k"})
State.visualStatInputs = State.visualStatInputs or {}
State.visualApplying = false
State.visualPresentationRunning = false

if leaderstats then
    for _, stat in ipairs(leaderstats:GetChildren()) do
        if stat:IsA("IntValue") or stat:IsA("NumberValue") then
            State.originalStats[stat.Name] = stat.Value
        end
    end
end

for _, stat in ipairs(player:GetChildren()) do
    if stat:IsA("IntValue") or stat:IsA("NumberValue") then
        State.originalStats[stat.Name] = stat.Value
    end
end

D.VisualStatDefinitions = {
    {
        key = "Strength",
        names = {"Strength", "Fuerza"}
    },
    {
        key = "Gems",
        names = {"Gems", "Gemas"}
    },
    {
        key = "Rebirths",
        names = {"Rebirths", "Rebirth"}
    },
    {
        key = "Fights",
        names = {"Brawls", "Fights", "Fight"}
    },
    {
        key = "Kills",
        names = {"Kills"}
    }
}

function H.GetVisualStat(names)
    local stat

    if leaderstats then
        for _, name in ipairs(names) do
            stat = leaderstats:FindFirstChild(name)

            if stat
                and (stat:IsA("IntValue") or stat:IsA("NumberValue")) then
                return stat
            end
        end
    end

    for _, name in ipairs(names) do
        stat = player:FindFirstChild(name)

        if stat
            and (stat:IsA("IntValue") or stat:IsA("NumberValue")) then
            return stat
        end
    end

    return nil
end

function H.ParseVisualNumber(text)
    local multipliers = {
        K = 1e3,
        M = 1e6,
        B = 1e9,
        T = 1e12,
        QA = 1e15,
        QI = 1e18,
        SX = 1e21,
        SP = 1e24,
        OC = 1e27,
        NO = 1e30,
        DC = 1e33
    }

    text = string.upper(tostring(text or ""))
    text = text:gsub("%s+", "")

    local number, suffix =
        string.match(text, "^([%d%.]+)(%a*)$")

    if not number then
        return nil
    end

    number = tonumber(number)

    if not number then
        return nil
    end

    if suffix ~= "" then
        local multiplier = multipliers[suffix]

        if not multiplier then
            return nil
        end

        number *= multiplier
    end

    if number < 0 or number ~= number then
        return nil
    end

    return math.floor(number + 0.5)
end

function H.FormatVisualNumber(value)
    value = tonumber(value) or 0

    local units = {
        {1e33, "DC"},
        {1e30, "NO"},
        {1e27, "OC"},
        {1e24, "SP"},
        {1e21, "SX"},
        {1e18, "QI"},
        {1e15, "QA"},
        {1e12, "T"},
        {1e9, "B"},
        {1e6, "M"},
        {1e3, "K"}
    }

    for _, unit in ipairs(units) do
        if value >= unit[1] then
            local result = value / unit[1]

            if result >= 100 then
                return string.format("%.0f%s", result, unit[2])
            elseif result >= 10 then
                return string.format("%.1f%s", result, unit[2])
            else
                return string.format("%.2f%s", result, unit[2])
            end
        end
    end

    return string.format("%.0f", value)
end

function H.SetVisualLabel(label, text, remember)
    if not label or not label:IsA("TextLabel") then
        return
    end

    if remember and not State.visualOriginalLabels[label] then
        State.visualOriginalLabels[label] = {
            Text = label.Text,
            TextTransparency = label.TextTransparency,
            TextStrokeTransparency = label.TextStrokeTransparency
        }
    end

    label.Text = text
end

function H.CaptureVisualLabels(key)
    local gui = player:FindFirstChild("PlayerGui")

    if not gui then
        return
    end

    local gameGui = gui:FindFirstChild("gameGui")

    if not gameGui then
        return
    end

    local currencyFrameGui =
        gameGui:FindFirstChild("currencyFrameGui")

    local statsMenu =
        gameGui:FindFirstChild("statsMenu")

    local currencyFrame =
        currencyFrameGui
        and currencyFrameGui:FindFirstChild("currencyFrame")

    local statsList =
        statsMenu
        and statsMenu:FindFirstChild("statsList")

    local bottomStatList =
        statsMenu
        and statsMenu:FindFirstChild("bottomStatList")

    local hudNewMenu =
        gameGui:FindFirstChild("hudNewMenu")

    local infoSlots =
        hudNewMenu
        and hudNewMenu:FindFirstChild("Top")

    infoSlots =
        infoSlots
        and infoSlots:FindFirstChild("InfoSlots")

    local labels = {}

    if key == "Strength" then
        local frame =
            statsList
            and statsList:FindFirstChild("strengthFrame")

        if frame then
            local label = frame:FindFirstChild("amountLabel")

            if label then
                table.insert(labels, label)
            end
        end

        frame =
            currencyFrame
            and currencyFrame:FindFirstChild("strengthFrame")

        if frame then
            local label = frame:FindFirstChild("amountLabel")

            if label then
                table.insert(labels, label)
            end
        end

        local slot =
            infoSlots
            and infoSlots:FindFirstChild("StrengthSlot")

        if slot then
            local label = slot:FindFirstChild("Amnt")

            if label then
                table.insert(labels, label)
            end
        end

    elseif key == "Gems" then
        local frame =
            currencyFrame
            and currencyFrame:FindFirstChild("gemsFrame")

        if frame then
            local label = frame:FindFirstChild("amountLabel")

            if label then
                table.insert(labels, label)
            end
        end

        local slot =
            infoSlots
            and infoSlots:FindFirstChild("GemSlot")

        if slot then
            local label = slot:FindFirstChild("Amnt")

            if label then
                table.insert(labels, label)
            end
        end

    elseif key == "Rebirths"
        or key == "Fights"
        or key == "Kills" then

        local frameNames = {
            Rebirths = "rebirthsFrame",
            Fights = "brawlsFrame",
            Kills = "killsFrame"
        }

        local frame =
            bottomStatList
            and bottomStatList:FindFirstChild(frameNames[key])

        if frame then
            local label = frame:FindFirstChild("statLabel")

            if label then
                table.insert(labels, label)
            end
        end
    end

    State.visualStatRecords[key] =
        State.visualStatRecords[key] or {}

    State.visualStatRecords[key].labels =
        State.visualStatRecords[key].labels or {}

    for _, label in ipairs(labels) do
        if not State.visualOriginalLabels[label] then
            State.visualOriginalLabels[label] = {
                Text = label.Text,
                TextTransparency = label.TextTransparency,
                TextStrokeTransparency = label.TextStrokeTransparency
            }
        end

        if not table.find(
            State.visualStatRecords[key].labels,
            label
        ) then
            table.insert(
                State.visualStatRecords[key].labels,
                label
            )
        end
    end
end

function H.ApplyVisualLabels()
    for key, record in pairs(State.visualStatRecords) do
        if record and record.labels then
            local text =
                H.FormatVisualNumber(record.value)

            for _, label in ipairs(record.labels) do
                if label and label.Parent then
                    local finalText = text

                    if key == "Fights" then
                        finalText = "Brawls - " .. text
                    elseif key == "Kills" then
                        finalText = "KOs - " .. text
                    elseif key == "Rebirths" then
                        finalText = "Rebirths - " .. text
                    end

                    H.SetVisualLabel(
                        label,
                        finalText,
                        false
                    )
                end
            end
        end
    end
end

function H.StartVisualPresentation()
    if State.visualPresentationRunning then
        return
    end

    State.visualPresentationRunning = true

    task.spawn(function()
        while State.running
            and next(State.visualStats) do

            if not State.visualApplying then
                H.ApplyVisualLabels()
            end

            task.wait(0.5)
        end

        State.visualPresentationRunning = false
    end)
end

function H.RestoreVisualLabels()
    for label, original in pairs(
        State.visualOriginalLabels
    ) do
        if label
            and label.Parent
            and original then

            label.Text = original.Text

            if original.TextTransparency ~= nil then
                label.TextTransparency =
                    original.TextTransparency
            end

            if original.TextStrokeTransparency ~= nil then
                label.TextStrokeTransparency =
                    original.TextStrokeTransparency
            end
        end
    end

    State.visualOriginalLabels =
        setmetatable({}, {__mode = "k"})
end

function H.ClearVisualStat(key)
    local record =
        State.visualStatRecords[key]

    if record then
        if record.connection then
            record.connection:Disconnect()
            record.connection = nil
        end

        if record.object
            and record.object.Parent then

            pcall(function()
                record.object.Value =
                    record.realValue
            end)
        end
    end

    State.visualStats[key] = nil
    State.visualStatRecords[key] = nil

    H.RestoreVisualLabels()
end

function H.ChangeVisualStat(definition, text)
    if text == nil
        or tostring(text):match("^%s*$") then

        H.ClearVisualStat(definition.key)
        return
    end

    local value =
        H.ParseVisualNumber(text)

    if not value then
        return
    end

    local stat =
        H.GetVisualStat(definition.names)

    if not stat then
        return
    end

    H.ClearVisualStat(definition.key)

    local record = {
        object = stat,
        realValue = stat.Value,
        value = value,
        labels = {}
    }

    State.visualApplying = true

    State.visualStats[definition.key] = value
    State.visualStatRecords[definition.key] = record

    H.CaptureVisualLabels(definition.key)

    record.connection =
        stat:GetPropertyChangedSignal("Value"):Connect(
            function()
                if State.visualApplying
                    or not State.running
                    or not State.visualStats[definition.key] then
                    return
                end

                if stat.Value ~= value then
                    record.realValue = stat.Value

                    State.visualApplying = true

                    pcall(function()
                        stat.Value = value
                    end)

                    State.visualApplying = false
                end
            end
        )

    pcall(function()
        stat.Value = value
    end)

    State.visualApplying = false

    H.ApplyVisualLabels()
    H.StartVisualPresentation()
end

function H.RestoreVisualStats()
    State.visualApplying = true

    for _, record in pairs(
        State.visualStatRecords
    ) do
        if record then
            if record.connection then
                record.connection:Disconnect()
                record.connection = nil
            end

            if record.object
                and record.object.Parent then

                pcall(function()
                    record.object.Value =
                        record.realValue
                end)
            end
        end
    end

    State.visualStats = {}
    State.visualStatRecords = {}
    State.visualApplying = false

    H.RestoreVisualLabels()
end

State.applyVisualStat = H.ChangeVisualStat
State.restoreVisualStats = H.RestoreVisualStats

R.FakeStats =
    R.Stats:Section({
        Title = "Fake Stats (Solo Visuales)",
        Icon = "eye"
    })

R.FakeStats:Paragraph({
    Title = "Fake Stats",
    Desc = "Modifica visualmente las estadísticas seleccionadas"
})

local fakeStatFields = {
    {"Strength", "Strength"},
    {"Rebirths", "Rebirths"},
    {"Kills", "Kills"},
    {"Brawls", "Fights"},
    {"Durabilidad", "Durability"},
    {"Gemas", "Gems"}
}

for _, data in ipairs(fakeStatFields) do
    local definition

    for _, current in ipairs(D.VisualStatDefinitions) do
        if current.key == data[2] then
            definition = current
            break
        end
    end

    if definition then
        State.visualStatInputs[definition.key] =
            R.FakeStats:Input({
                Title = data[1],
                Placeholder = "",
                Callback = function(text)
                    H.ChangeVisualStat(
                        definition,
                        text
                    )
                end
            })
    else
        R.FakeStats:Input({
            Title = data[1],
            Placeholder = "",
            Callback = function(text)
                local value =
                    H.ParseVisualNumber(text)

                if not value then
                    return
                end

                local stat =
                    H.GetVisualStat({data[2]})

                if stat then
                    stat.Value = math.floor(value)
                end
            end
        })
    end
end

R.FakeStats:Button({
    Title = "Restore Fake Stats",
    Callback = function()
        H.RestoreVisualStats()
    end
})

R.Teleport = R.Players:Tab({
    Title = "Teleport",
    Icon = "map-pin",
    ShowTabTitle = true
})

D.workoutTypesList = D.workoutTypesList or {
    "Bench Press",
    "Squat",
    "Deadlift",
    "Pull Up",
    "Boulder"
}

D.locationsList = D.locationsList or {
    "Starter Island",
    "Legend Beach",
    "Frost Gym",
    "Mythical Gym",
    "Eternal Gym",
    "Legend Gym",
    "Muscle King Gym",
    "Jungle Gym"
}

D.workoutPositions = D.workoutPositions or {
    ["Bench Press"] = {
        ["Starter Island"] = CFrame.new(-17.0609932, 3.31417918, -2.48164988),
        ["Legend Beach"] = CFrame.new(470.334656, 3.31417966, -321.053925),
        ["Frost Gym"] = CFrame.new(-3013.24194, 39.2158546, -335.036926),
        ["Mythical Gym"] = CFrame.new(2371.7356, 39.2158546, 1246.31555),
        ["Legend Gym"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
        ["Muscle King Gym"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717),
        ["Jungle Gym"] = CFrame.new(-8173, 64, 1898),
    },

    ["Squat"] = {
        ["Starter Island"] = CFrame.new(-48.8711243, 3.31417918, -11.8831778),
        ["Legend Beach"] = CFrame.new(470.334656, 3.31417966, -321.053925),
        ["Frost Gym"] = CFrame.new(-2933.47998, 29.6399612, -579.946045),
        ["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
        ["Jungle Gym"] = CFrame.new(-8352, 34, 2878),
    },

    ["Deadlift"] = {
        ["Starter Island"] = CFrame.new(-48.8711243, 3.31417918, -11.8831778),
        ["Legend Beach"] = CFrame.new(470.334656, 3.31417966, -321.053925),
        ["Frost Gym"] = CFrame.new(-2933.47998, 29.6399612, -579.946045),
        ["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
    },

    ["Pull Up"] = {
        ["Starter Island"] = CFrame.new(-33.3047485, 3.31417918, -11.8831778),
        ["Legend Beach"] = CFrame.new(470.334656, 3.31417966, -321.053925),
        ["Frost Gym"] = CFrame.new(-2933.47998, 29.6399612, -579.946045),
        ["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
        ["Jungle Gym"] = CFrame.new(-8666, 34, 2070),
    },

    ["Boulder"] = {
        ["Starter Island"] = CFrame.new(-33.3047485, 3.31417918, -11.8831778),
        ["Legend Beach"] = CFrame.new(470.334656, 3.31417966, -321.053925),
        ["Frost Gym"] = CFrame.new(-2933.47998, 29.6399612, -579.946045),
        ["Mythical Gym"] = CFrame.new(2489.21484, 3.67686629, 849.051025),
        ["Eternal Gym"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
        ["Jungle Gym"] = CFrame.new(-8621, 34, 2684),
    },
}

D.treadmillPositions = D.treadmillPositions or {
    ["Tiny Island"] = CFrame.new(
        -31.8626194,
        6.0588026,
        2087.88672,
        -0.999396682,
        -9.72631931e-09,
        0.034730725,
        -6.63278898e-09,
        1,
        8.91870684e-08,
        -0.034730725,
        8.8902901e-08,
        -0.999396682
    ),

    ["Starter Island"] = CFrame.new(
        226.252472,
        8.1526947,
        219.366516,
        -0.00880406145,
        3.58277887e-08,
        -0.999961257,
        -4.41204939e-08,
        1,
        3.62176351e-08,
        0.999961257,
        4.44376482e-08,
        -0.00880406145
    ),

    ["Legend Beach"] = CFrame.new(
        -365.798309,
        44.5082932,
        -501.618591,
        0.00878552441,
        -6.19950713e-09,
        0.999961436,
        -4.37451603e-10,
        1,
        6.20358964e-09,
        -0.999961436,
        -4.91936492e-10,
        0.00878552441
    ),

    ["Frost Gym"] = CFrame.new(
        -2933.47998,
        29.6399612,
        -579.946045,
        0.0345239155,
        -1.03010173e-07,
        0.999403894,
        1.03015294e-08,
        1,
        1.02715752e-07,
        -0.999403894,
        6.74923806e-09,
        0.0345239155
    ),

    ["Mythical Gym"] = CFrame.new(
        2659.50635,
        21.6095238,
        934.690613,
        0.999999881,
        4.98906161e-08,
        0.000502891606,
        -4.98585742e-08,
        1,
        -6.37288338e-08,
        -0.000502891606,
        6.37037516e-08,
        0.999999881
    ),

    ["Eternal Gym"] = CFrame.new(
        -7176.19141,
        45.394104,
        -1106.31421,
        0.971191287,
        -2.38377185e-09,
        0.238301158,
        1.41694778e-09,
        1,
        4.22844915e-09,
        -0.238301158,
        -3.76897269e-09,
        0.971191287
    ),

    ["Legend Gym"] = CFrame.new(
        4446.91699,
        1004.46698,
        -3983.76074,
        -0.999961317,
        -1.97616366e-08,
        0.00879266672,
        -1.93830077e-08,
        1,
        4.31365149e-08,
        -0.00879266672,
        4.29661292e-08,
        -0.999961317
    ),

    ["Jungle Gym"] = CFrame.new(
        -8137,
        28,
        2820
    ),
}

D.islandList = D.islandList or {
    {name = "Spawn", cf = CFrame.new(2, 8, 115)},
    {name = "Secret Area", cf = CFrame.new(1947, 2, 6191)},
    {name = "Tiny Island", cf = CFrame.new(-34, 7, 1903)},
    {
        name = "Frozen Island",
        cf = CFrame.new(
            -2600.00244,
            3.67686558,
            -403.884369,
            0.0873617008,
            1.0482899e-09,
            0.99617666,
            3.07204253e-08,
            1,
            -3.7464023e-09,
            -0.99617666,
            3.09302628e-08,
            0.0873617008
        )
    },
    {name = "Mythical Island", cf = CFrame.new(2255, 7, 1071)},
    {name = "Hell Island", cf = CFrame.new(-6768, 7, -1287)},
    {name = "Legend Island", cf = CFrame.new(4604, 991, -3887)},
    {name = "Muscle King Island", cf = CFrame.new(-8646, 17, -5738)},
    {name = "Jungle Island", cf = CFrame.new(-8659, 6, 2384)},
    {name = "Industrial Gym", cf = CFrame.new(-5563.2, 58.31, 4942.44)},
}

D.brawlIslandList = D.brawlIslandList or {
    {name = "Brawl Lava", cf = CFrame.new(4471, 119, -8836)},
    {name = "Brawl Desert", cf = CFrame.new(960, 17, -7398)},
    {name = "Brawl Regular", cf = CFrame.new(-1849, 20, -6335)},
}

D.islandNames = D.islandNames or {}

if #D.islandNames == 0 then
    for _, island in pairs(D.islandList) do
        table.insert(D.islandNames, island.name)
    end
end

D.brawlIslandNames = D.brawlIslandNames or {}

if #D.brawlIslandNames == 0 then
    for _, island in pairs(D.brawlIslandList) do
        table.insert(D.brawlIslandNames, island.name)
    end
end

function H.TeleportToPosition(cf)
    local char = S.LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if hrp then
        hrp.CFrame = cf
    end
end

function H.GetWorkoutLocationsList()
    local workout =
        V.SelectedWorkoutType
        or D.workoutTypesList[1]

    local positions =
        D.workoutPositions[workout]

    if not positions then
        return D.locationsList
    end

    local list = {}

    for loc, _ in pairs(positions) do
        table.insert(list, loc)
    end

    return list
end

function H.GetTreadmillLocationsList()
    local list = {}

    for loc, _ in pairs(D.treadmillPositions) do
        table.insert(list, loc)
    end

    return list
end

V.SelectedWorkoutType =
    V.SelectedWorkoutType
    or D.workoutTypesList[1]

V.SelectedWorkoutLocation =
    V.SelectedWorkoutLocation
    or D.locationsList[1]

V.SelectedTreadmillLocation =
    V.SelectedTreadmillLocation
    or H.GetTreadmillLocationsList()[1]

V.SelectedIsland =
    V.SelectedIsland
    or D.islandNames[1]

V.SelectedBrawlIsland =
    V.SelectedBrawlIsland
    or D.brawlIslandNames[1]

R.Teleport:Paragraph({
    Title = "Work Locations",
    Desc = ""
})

R.TeleportWorkoutDropdown =
    R.Teleport:Dropdown({
        Title = "Select Workout",
        Values = D.workoutTypesList,
        Value = V.SelectedWorkoutType,
        SearchBarEnabled = false,
        AllowNone = false,
        Callback = function(val)
            V.SelectedWorkoutType = val

            local locations =
                H.GetWorkoutLocationsList()

            if R.TeleportLocationDropdown then
                R.TeleportLocationDropdown:Refresh(locations)

                if table.find(
                    locations,
                    V.SelectedWorkoutLocation
                ) then
                    R.TeleportLocationDropdown:Select(
                        V.SelectedWorkoutLocation
                    )
                else
                    V.SelectedWorkoutLocation =
                        locations[1] or ""

                    if V.SelectedWorkoutLocation ~= "" then
                        R.TeleportLocationDropdown:Select(
                            V.SelectedWorkoutLocation
                        )
                    end
                end
            end
        end
    })

R.TeleportLocationDropdown =
    R.Teleport:Dropdown({
        Title = "Select Location",
        Values = H.GetWorkoutLocationsList(),
        Value = V.SelectedWorkoutLocation,
        SearchBarEnabled = true,
        AllowNone = false,
        Callback = function(val)
            V.SelectedWorkoutLocation = val
        end
    })

R.Teleport:Button({
    Title = "Teleport to Workout",
    Callback = function()
        if V.SelectedWorkoutType == ""
            or V.SelectedWorkoutLocation == "" then

            print("Elegi tipo de ejercicio y ubicacion")
            return
        end

        pcall(function()
            local position =
                D.workoutPositions[
                    V.SelectedWorkoutType
                ][
                    V.SelectedWorkoutLocation
                ]

            if position then
                H.TeleportToPosition(position)
            else
                print(
                    "Esa ubicacion no esta disponible para este ejercicio"
                )
            end
        end)
    end
})

R.Teleport:Paragraph({
    Title = "Treadmill Locations",
    Desc = ""
})

R.TeleportTreadmillDropdown =
    R.Teleport:Dropdown({
        Title = "Select Treadmill",
        Values = H.GetTreadmillLocationsList(),
        Value = V.SelectedTreadmillLocation,
        SearchBarEnabled = true,
        AllowNone = false,
        Callback = function(val)
            V.SelectedTreadmillLocation = val
        end
    })

R.Teleport:Button({
    Title = "Teleport to Treadmill",
    Callback = function()
        if not V.SelectedTreadmillLocation
            or V.SelectedTreadmillLocation == "" then

            print("Elegi una ubicacion de cinta")
            return
        end

        pcall(function()
            local position =
                D.treadmillPositions[
                    V.SelectedTreadmillLocation
                ]

            if position then
                H.TeleportToPosition(position)
            end
        end)
    end
})

R.Teleport:Paragraph({
    Title = "Islands",
    Desc = ""
})

R.IslandDropdown =
    R.Teleport:Dropdown({
        Title = "Select Island",
        Values = D.islandNames,
        Value = V.SelectedIsland,
        SearchBarEnabled = true,
        AllowNone = false,
        Callback = function(val)
            V.SelectedIsland = val
        end
    })

R.Teleport:Button({
    Title = "Teleport to Island",
    Callback = function()
        for _, island in pairs(D.islandList) do
            if island.name == V.SelectedIsland then
                H.TeleportToPosition(island.cf)
                break
            end
        end
    end
})

R.Teleport:Paragraph({
    Title = "Brawl Islands",
    Desc = ""
})

R.BrawlIslandDropdown =
    R.Teleport:Dropdown({
        Title = "Select Brawl Island",
        Values = D.brawlIslandNames,
        Value = V.SelectedBrawlIsland,
        SearchBarEnabled = true,
        AllowNone = false,
        Callback = function(val)
            V.SelectedBrawlIsland = val
        end
    })

R.Teleport:Button({
    Title = "Teleport to Brawl Island",
    Callback = function()
        for _, island in pairs(D.brawlIslandList) do
            if island.name == V.SelectedBrawlIsland then
                H.TeleportToPosition(island.cf)
                break
            end
        end
    end
})

function H.RefreshAllPlayerDropdowns()
    task.wait(0.5)

    local list = H.BuildPlayerList()

    if R.EggPlayerDropdown
        and R.EggPlayerDropdown.Refresh then

        R.EggPlayerDropdown:Refresh(list)
    end

    if R.ShakePlayerDropdown
        and R.ShakePlayerDropdown.Refresh then

        R.ShakePlayerDropdown:Refresh(list)
    end

    if R.KillerViewDropdown
        and R.KillerViewDropdown.Refresh then

        R.KillerViewDropdown:Refresh(list)
    end

    if R.KillerFollowDropdown
        and R.KillerFollowDropdown.Refresh then

        R.KillerFollowDropdown:Refresh(list)
    end
end

if C.PlayerAddedConn then
    C.PlayerAddedConn:Disconnect()
end

C.PlayerAddedConn =
    S.Players.PlayerAdded:Connect(function()
        task.spawn(H.RefreshAllPlayerDropdowns)
    end)

if C.PlayerRemovingConn then
    C.PlayerRemovingConn:Disconnect()
end

C.PlayerRemovingConn =
    S.Players.PlayerRemoving:Connect(function(player)
        if V.Spectating
            and V.SelectedSpectatePlayer ~= "" then

            local specName =
                V.SelectedSpectatePlayer:match(
                    "%-%s*(.-)%s*$"
                )

            specName =
                specName
                and specName:match("^%s*(.-)%s*$")
                or ""

            if specName == player.Name then
                V.Spectating = false
                V.SelectedSpectatePlayer = ""

                if R.KillerSpectateToggle
                    and R.KillerSpectateToggle.Set then

                    R.KillerSpectateToggle:Set(false)
                end

                if C.SpectateTargetConn then
                    C.SpectateTargetConn:Disconnect()
                    C.SpectateTargetConn = nil
                end

                H.ResetSpectateCamera()
            end
        end

        task.spawn(H.RefreshAllPlayerDropdowns)
    end)

R.UI = R.Window:Section({
    Title = "UI",
    Icon = "layout",
    Opened = true
})

R.AI = WindUI:AttachAI(R.Window, {
    Name = "Mystery Assistant",
    Title = "Mystery Assistant",
    System = "You are a short and friendly assistant inside a script hub",
    Icon = "sparkles",
    Order = 990,
    Accent = Color3.fromRGB(48, 255, 106),
    MaxHistory = 20,
    Ask = function(prompt, history)
        return "You said: " .. prompt .. " (" .. #history .. " messages in history)"
    end,
})

R.AITab = R.UI:Tab({
    Title = "AI Assistant",
    Icon = "sparkles",
    ShowTabTitle = true
})

R.AITab:Paragraph({
    Title = "AI Assistant",
    Desc = "Asistente integrado de Mystery Hub",
    Image = "sparkles",
})

R.AITab:Button({
    Title = "Toggle AI",
    Desc = "Muestra u oculta el panel de IA",
    Icon = "message-circle",
    Callback = function()
        R.AI:Toggle()
    end,
})

R.AITab:Button({
    Title = "Open AI",
    Icon = "eye",
    Callback = function()
        R.AI:Open()
    end,
})

R.AITab:Button({
    Title = "Hide AI",
    Icon = "eye-off",
    Callback = function()
        R.AI:Hide()
    end,
})

R.AITab:Button({
    Title = "Ask AI",
    Desc = "Envía un mensaje al asistente",
    Icon = "send",
    Callback = function()
        R.AI:Open()
        R.AI:Ask("Hello from Mystery Hub")
    end,
})

R.AITab:Button({
    Title = "Clear Chat",
    Desc = "Limpia la conversación",
    Icon = "eraser",
    Callback = function()
        R.AI:Clear()
    end,
})

R.AITab:Button({
    Title = "Rename AI",
    Icon = "type",
    Callback = function()
        R.AI:SetName("Mystery Assistant")
    end,
})

R.AITab:Button({
    Title = "Reset System",
    Icon = "settings",
    Callback = function()
        R.AI:SetSystem("You are a short and friendly assistant inside a script hub")
    end,
})

R.SettingsTab = WindUI:CreateSettingsTab(R.Window, {
    Section = R.UI,
    Title = "Settings",
    Icon = "settings",
    ShowTheme = true,
    ShowAcrylic = true,
    ShowUIScale = true,
    ShowKeybind = false,
    ShowConfig = false,
})

R.Library = R.Window

R.Home:Select()
