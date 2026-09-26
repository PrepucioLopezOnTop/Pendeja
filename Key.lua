local MH = getgenv().MH or {}
getgenv().MH = MH

MH.S = MH.S or {}
MH.V = MH.V or {}
MH.D = MH.D or {}
MH.C = MH.C or {}
MH.H = MH.H or {}
MH.St = MH.St or {}
MH.R = MH.R or {}

local S = MH.S
local V = MH.V
local D = MH.D
local C = MH.C
local H = MH.H
local St = MH.St
local R = MH.R

S.Players = game:GetService("Players")
S.TweenService = game:GetService("TweenService")
S.Lighting = game:GetService("Lighting")
S.RunService = game:GetService("RunService")
S.UserInputService = game:GetService("UserInputService")
S.HttpService = game:GetService("HttpService")
S.LocalPlayer = S.Players.LocalPlayer
S.Camera = workspace.CurrentCamera

V.AccentIndex = V.AccentIndex or 1
V.BlurEnabled = V.BlurEnabled or false
V.ParticlesEnabled = V.ParticlesEnabled or true
V.CompactMode = V.CompactMode or false
V.ReducedMotion = V.ReducedMotion or false
V.ScriptVersion = V.ScriptVersion or "v1.1.0"

St.ParticleGen = St.ParticleGen or 0

D.Accents = D.Accents or {
	{Name = "Violet", Accent = Color3.fromRGB(155, 79, 224), Accent2 = Color3.fromRGB(199, 116, 240)},
	{Name = "Orchid", Accent = Color3.fromRGB(166, 58, 201), Accent2 = Color3.fromRGB(226, 111, 224)},
	{Name = "Indigo", Accent = Color3.fromRGB(108, 92, 231), Accent2 = Color3.fromRGB(157, 140, 245)},
	{Name = "Grape", Accent = Color3.fromRGB(126, 34, 206), Accent2 = Color3.fromRGB(176, 109, 224)},
	{Name = "Amethyst", Accent = Color3.fromRGB(139, 63, 168), Accent2 = Color3.fromRGB(214, 143, 232)}
}

D.Palette = D.Palette or {
	BgDeep = Color3.fromRGB(10, 5, 18),
	Panel = Color3.fromRGB(23, 12, 34),
	PanelAlt = Color3.fromRGB(29, 16, 41),
	PanelRaised = Color3.fromRGB(36, 21, 51),
	Border = Color3.fromRGB(58, 33, 80),
	BorderSoft = Color3.fromRGB(42, 23, 64),
	Text = Color3.fromRGB(239, 231, 247),
	TextDim = Color3.fromRGB(168, 148, 194),
	TextFaint = Color3.fromRGB(111, 92, 138),
	Ok = Color3.fromRGB(57, 201, 138)
}

D.DiscordInvite = "https://discord.gg/yBfnjRHKnd"
D.ValidKey = "MHONTOP"
D.GamesUrl = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Games.lua"
D.BlacklistUrl = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Blacklist.json"
D.WhitelistUrl = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Whitelist.json"
D.WebhookUrl = "https://discord.com/api/webhooks/1553345545337053314/rJkta54BR1WjeGiuFus--foCi_Cj02IJJP59Wll6Jjg3vQN4DF8IVwljZBClF2KDguyo"

function H.New(className, props, children)
	local inst = Instance.new(className)
	for key, value in pairs(props or {}) do
		inst[key] = value
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	return inst
end

function H.Corner(parent, radius)
	return H.New("UICorner", {CornerRadius = UDim.new(0, radius), Parent = parent})
end

function H.Stroke(parent, color, thickness)
	return H.New("UIStroke", {Color = color, Thickness = thickness or 1, Parent = parent})
end

function H.Gradient(parent, colorA, colorB, rotation)
	return H.New("UIGradient", {
		Color = ColorSequence.new(colorA, colorB),
		Rotation = rotation or 45,
		Parent = parent
	})
end

function H.Tween(instance, props, duration, style, direction)
	local info = TweenInfo.new(duration or 0.18, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
	local tween = S.TweenService:Create(instance, info, props)
	tween:Play()
	return tween
end

function H.SetClipboard(text)
	local ok = pcall(function()
		setclipboard(text)
	end)
	if ok then
		return true
	end
	local fallbackOk = pcall(function()
		toclipboard(text)
	end)
	return fallbackOk
end

function H.GetExecutorInfo()
	local ok, name, version = pcall(function()
		return identifyexecutor()
	end)
	if ok and name then
		return name, version or "?"
	end
	if syn then
		return "Synapse X", "?"
	end
	if KRNL_LOADED then
		return "KRNL", "?"
	end
	if rconsoleprint then
		return "Script-Ware", "?"
	end
	return "Unknown", "?"
end

function H.GetPlatform()
	if S.UserInputService.TouchEnabled and not S.UserInputService.KeyboardEnabled then
		return "Mobile"
	end
	if S.UserInputService.GamepadEnabled then
		return "Console"
	end
	return "PC"
end

function H.FormatAccountAge(days)
	local years = math.floor(days / 365)
	local remainder = days - (years * 365)
	if years > 0 then
		return years .. "y " .. remainder .. "d"
	end
	return days .. "d"
end

function H.GetGui()
	local ok, hidden = pcall(function()
		return gethui()
	end)
	if ok and hidden then
		return hidden
	end
	local coreOk, core = pcall(function()
		return game:GetService("CoreGui")
	end)
	if coreOk and core then
		return core
	end
	return S.LocalPlayer:WaitForChild("PlayerGui")
end

function H.FetchJSON(url)
	local ok, raw = pcall(function()
		return game:HttpGet(url)
	end)
	if not ok or raw == "" then
		return nil
	end
	local decodeOk, data = pcall(function()
		return S.HttpService:JSONDecode(raw)
	end)
	if not decodeOk then
		return nil
	end
	return data
end

function H.LoadGamesTable()
	local ok, result = pcall(function()
		return loadstring(game:HttpGet(D.GamesUrl))()
	end)
	if ok and type(result) == "table" then
		return result
	end
	return nil
end

function H.CheckBlacklisted()
	local list = H.FetchJSON(D.BlacklistUrl)
	if type(list) ~= "table" then
		return false
	end
	local myId = S.LocalPlayer.UserId
	for _, entry in ipairs(list) do
		if tonumber(entry) == myId then
			return true
		end
	end
	return false
end

function H.CheckWhitelisted()
	local list = H.FetchJSON(D.WhitelistUrl)
	if type(list) ~= "table" then
		return false
	end
	local myName = string.lower(S.LocalPlayer.Name)
	for _, entry in ipairs(list) do
		if type(entry) == "string" and entry ~= "" and string.lower(entry) == myName then
			return true
		end
	end
	return false
end

function H.SendLog(status)
	local execName, execVersion = H.GetExecutorInfo()
	local userId = tostring(S.LocalPlayer.UserId)
	local payload = {
		username = "Mystery Hub",
		embeds = {
			{
				title = "Mystery Hub - " .. status,
				color = 10181046,
				fields = {
					{name = "Player", value = S.LocalPlayer.Name .. " (" .. userId .. ")", inline = false},
					{name = "Display Name", value = S.LocalPlayer.DisplayName, inline = true},
					{name = "Platform", value = H.GetPlatform(), inline = true},
					{name = "Executor", value = execName .. " " .. execVersion, inline = true},
					{name = "Place ID", value = tostring(game.PlaceId), inline = true},
					{name = "Game ID", value = tostring(game.GameId), inline = true},
					{name = "Job ID", value = tostring(game.JobId), inline = false}
				},
				timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
			}
		}
	}
	pcall(function()
		local body = S.HttpService:JSONEncode(payload)
		local req = syn and syn.request or http_request or request
		if req then
			req({
				Url = D.WebhookUrl,
				Method = "POST",
				Headers = {["Content-Type"] = "application/json"},
				Body = body
			})
		else
			S.HttpService:PostAsync(D.WebhookUrl, body, Enum.HttpContentType.ApplicationJson)
		end
	end)
end

function H.RunGameScript(notify)
	local games = H.LoadGamesTable()
	if not games then
		notify("Could not reach the Mystery Hub registry")
		return false
	end
	local url = games[game.GameId] or games[game.PlaceId]
	if not url then
		notify("This game isn't supported yet")
		return false
	end
	local runOk = pcall(function()
		loadstring(game:HttpGet(url))()
	end)
	if not runOk then
		notify("Failed to load the script for this game")
		return false
	end
	return true
end

function H.Notify(message, duration)
	duration = duration or 2.5
	local gui = H.New("ScreenGui", {
		Name = "MysteryHubNotify",
		ResetOnSpawn = false,
		DisplayOrder = 60,
		Parent = H.GetGui()
	})
	local label = H.New("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 440, 0, 50),
		BackgroundTransparency = 1,
		Text = message,
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = D.Accents[1].Accent2,
		TextStrokeTransparency = 0.4,
		TextTransparency = 1,
		TextWrapped = true,
		Parent = gui
	})
	H.Tween(label, {TextTransparency = 0}, 0.3)
	task.delay(duration, function()
		H.Tween(label, {TextTransparency = 1}, 0.3)
		task.delay(0.35, function()
			gui:Destroy()
		end)
	end)
end

if H.CheckBlacklisted() then
	H.Notify("You have been blacklisted from Mystery Hub.", 4)
	pcall(function()
		S.LocalPlayer:Kick("You have been blacklisted from Mystery Hub.")
	end)
	return
end

if getgenv()._MYSTERYHUB_KEY_OK or H.CheckWhitelisted() then
	local wasAlreadyUnlocked = getgenv()._MYSTERYHUB_KEY_OK
	getgenv()._MYSTERYHUB_KEY_OK = true
	H.SendLog(wasAlreadyUnlocked and "Auto-Run" or "Whitelisted Auto-Run")
	H.RunGameScript(function(message)
		H.Notify(message, 3)
	end)
	return
end

local Palette = D.Palette

R.ScreenGui = H.New("ScreenGui", {
	Name = "MysteryHubKeyUI",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 50,
	Parent = H.GetGui()
})

R.Layout = H.New("Frame", {
	Name = "Layout",
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(0, 0, 0, 0),
	AutomaticSize = Enum.AutomaticSize.XY,
	Parent = R.ScreenGui
})

R.LayoutScale = H.New("UIScale", {Scale = 1, Parent = R.Layout})

R.LayoutList = H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	VerticalAlignment = Enum.VerticalAlignment.Top,
	Padding = UDim.new(0, 20),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.Layout
})

R.ParticleLayer = H.New("Frame", {
	Name = "ParticleLayer",
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 1),
	Position = UDim2.new(0.5, 0, 1, 0),
	Size = UDim2.new(1, 0, 1, 0),
	ZIndex = 0,
	Parent = R.ScreenGui
})

local function buildPanel(name, layoutOrder, width, height)
	local panel = H.New("Frame", {
		Name = name,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(0, width, 0, height),
		BackgroundColor3 = Palette.Panel,
		Visible = false,
		Parent = R.Layout
	})
	H.Corner(panel, 18)
	H.Stroke(panel, Palette.Border, 1)
	return panel
end

R.SettingsPanel = buildPanel("SettingsPanel", 1, 280, 330)
R.KeyWidget = buildPanel("KeyWidget", 2, 320, 470)
R.KeyWidget.Visible = true
R.UserPanel = buildPanel("UserPanel", 3, 280, 400)

local function buildHeader(parent, title)
	local head = H.New("Frame", {
		Name = "Header",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 46),
		Parent = parent
	})
	H.New("TextLabel", {
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = Palette.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 0),
		Size = UDim2.new(1, -60, 1, 0),
		Parent = head
	})
	local closeBtn = H.New("TextButton", {
		Name = "CloseButton",
		Text = "\u{2715}",
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextColor3 = Palette.TextDim,
		BackgroundColor3 = Palette.PanelRaised,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.new(0, 28, 0, 28),
		Parent = head
	})
	H.Corner(closeBtn, 9)
	H.Stroke(closeBtn, Palette.BorderSoft, 1)
	return head, closeBtn
end

local settingsHeader, closeSettingsBtn = buildHeader(R.SettingsPanel, "Appearance")

R.SwatchRow = H.New("Frame", {
	Name = "SwatchRow",
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 16, 0, 54),
	Size = UDim2.new(1, -32, 0, 30),
	Parent = R.SettingsPanel
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 10),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.SwatchRow
})

R.Swatches = {}

for index, accent in ipairs(D.Accents) do
	local swatch = H.New("TextButton", {
		Name = "Swatch" .. index,
		Text = "",
		BackgroundColor3 = accent.Accent,
		Size = UDim2.new(0, 28, 0, 28),
		LayoutOrder = index,
		Parent = R.SwatchRow
	})
	H.Corner(swatch, 14)
	H.Gradient(swatch, accent.Accent2, accent.Accent, 120)
	local ring = H.Stroke(swatch, Color3.fromRGB(255, 255, 255), 2)
	ring.Transparency = index == 1 and 0 or 1
	R.Swatches[index] = {Button = swatch, Ring = ring}
end

local function buildToggleRow(parent, order, label, subLabel)
	local row = H.New("Frame", {
		BackgroundTransparency = 1,
		LayoutOrder = order,
		Size = UDim2.new(1, -32, 0, 46),
		Parent = parent
	})
	local textHolder = H.New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -50, 1, 0),
		Parent = row
	})
	H.New("TextLabel", {
		Text = label,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = Palette.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 18),
		Parent = textHolder
	})
	H.New("TextLabel", {
		Text = subLabel,
		Font = Enum.Font.Gotham,
		TextSize = 11,
		TextColor3 = Palette.TextFaint,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 18),
		Size = UDim2.new(1, 0, 0, 14),
		Parent = textHolder
	})
	local toggle = H.New("TextButton", {
		Name = "Toggle",
		Text = "",
		BackgroundColor3 = Palette.BorderSoft,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 40, 0, 22),
		Parent = row
	})
	H.Corner(toggle, 11)
	local knob = H.New("Frame", {
		Name = "Knob",
		BackgroundColor3 = Color3.fromRGB(203, 185, 230),
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(0, 18, 0, 18),
		Parent = toggle
	})
	H.Corner(knob, 9)
	return row, toggle, knob
end

R.SettingsList = H.New("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 16, 0, 96),
	Size = UDim2.new(1, -32, 1, -110),
	Parent = R.SettingsPanel
})

H.New("UIListLayout", {
	Padding = UDim.new(0, 4),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.SettingsList
})

local _, blurToggle, blurKnob = buildToggleRow(R.SettingsList, 1, "Enable blur", "Softens the background")
local _, particlesToggle, particlesKnob = buildToggleRow(R.SettingsList, 2, "Show particles", "Floating ambient motes")
local _, compactToggle, compactKnob = buildToggleRow(R.SettingsList, 3, "Compact mode", "Tighter spacing")
local _, motionToggle, motionKnob = buildToggleRow(R.SettingsList, 4, "Reduced motion", "Turns off animations")

local widgetTopBar = H.New("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 12),
	Size = UDim2.new(1, 0, 0, 30),
	Parent = R.KeyWidget
})

local settingsBtn = H.New("TextButton", {
	Text = "\u{2699}",
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, -50, 0.5, 0),
	Size = UDim2.new(0, 30, 0, 30),
	Parent = widgetTopBar
})
H.Corner(settingsBtn, 10)
H.Stroke(settingsBtn, Palette.BorderSoft, 1)

local mainCloseBtn = H.New("TextButton", {
	Text = "\u{2715}",
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, -14, 0.5, 0),
	Size = UDim2.new(0, 30, 0, 30),
	Parent = widgetTopBar
})
H.Corner(mainCloseBtn, 10)
H.Stroke(mainCloseBtn, Palette.BorderSoft, 1)

R.Avatar = H.New("Frame", {
	Name = "Avatar",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 52),
	Size = UDim2.new(0, 64, 0, 64),
	Parent = R.KeyWidget
})
H.Corner(R.Avatar, 32)
H.Gradient(R.Avatar, D.Accents[1].Accent2, D.Accents[1].Accent, 135)
H.Stroke(R.Avatar, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.85

H.New("TextLabel", {
	Text = "MH",
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Parent = R.Avatar
})

R.Title = H.New("TextLabel", {
	Text = "Mystery Hub",
	Font = Enum.Font.GothamBold,
	TextSize = 21,
	TextColor3 = Palette.Text,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 0, 0, 124),
	Size = UDim2.new(1, 0, 0, 26),
	Parent = R.KeyWidget
})

R.StatusDot = H.New("Frame", {
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, -66, 0, 160),
	Size = UDim2.new(0, 8, 0, 8),
	BackgroundColor3 = D.Accents[1].Accent2,
	Parent = R.KeyWidget
})
H.Corner(R.StatusDot, 4)

R.StatusLabel = H.New("TextLabel", {
	Text = "Enter your key to continue",
	Font = Enum.Font.Gotham,
	TextSize = 13,
	TextColor3 = D.Accents[1].Accent2,
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 6, 0, 154),
	Size = UDim2.new(0, 220, 0, 20),
	Parent = R.KeyWidget
})

R.KeyInputHolder = H.New("Frame", {
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 186),
	Size = UDim2.new(1, -48, 0, 44),
	BackgroundColor3 = Palette.BgDeep,
	Parent = R.KeyWidget
})
H.Corner(R.KeyInputHolder, 12)
R.KeyInputStroke = H.Stroke(R.KeyInputHolder, D.Accents[1].Accent, 1)

R.KeyInput = H.New("TextBox", {
	Text = "",
	PlaceholderText = "Enter your key...",
	Font = Enum.Font.Gotham,
	TextSize = 14,
	TextColor3 = Palette.Text,
	PlaceholderColor3 = Palette.TextFaint,
	ClearTextOnFocus = false,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 14, 0, 0),
	Size = UDim2.new(1, -28, 1, 0),
	Parent = R.KeyInputHolder
})

R.ProgressRow = H.New("Frame", {
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 240),
	Size = UDim2.new(0, 100, 0, 8),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	Padding = UDim.new(0, 6),
	Parent = R.ProgressRow
})

for index = 1, 5 do
	local dot = H.New("Frame", {
		BackgroundColor3 = index == 2 and D.Accents[1].Accent2 or Palette.Border,
		Size = index == 2 and UDim2.new(0, 16, 0, 5) or UDim2.new(0, 5, 0, 5),
		Parent = R.ProgressRow
	})
	H.Corner(dot, 3)
end

R.ActionRow = H.New("Frame", {
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 268),
	Size = UDim2.new(1, -48, 0, 42),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 10),
	Parent = R.ActionRow
})

local getKeyBtn = H.New("TextButton", {
	Text = "Get Key",
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextColor3 = D.Accents[1].Accent2,
	BackgroundColor3 = Palette.PanelRaised,
	Size = UDim2.new(0.5, -5, 1, 0),
	Parent = R.ActionRow
})
H.Corner(getKeyBtn, 12)
R.GetKeyStroke = H.Stroke(getKeyBtn, Palette.Border, 1)

local redeemBtn = H.New("TextButton", {
	Text = "Redeem Key",
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundColor3 = D.Accents[1].Accent,
	Size = UDim2.new(0.5, -5, 1, 0),
	Parent = R.ActionRow
})
H.Corner(redeemBtn, 12)
R.RedeemGradient = H.Gradient(redeemBtn, D.Accents[1].Accent2, D.Accents[1].Accent, 90)

R.MiniIconRow = H.New("Frame", {
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 322),
	Size = UDim2.new(0, 90, 0, 38),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	Padding = UDim.new(0, 10),
	Parent = R.MiniIconRow
})

local userBtn = H.New("TextButton", {
	Text = "\u{1F464}",
	Font = Enum.Font.GothamBold,
	TextSize = 15,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	Size = UDim2.new(0, 38, 0, 38),
	Parent = R.MiniIconRow
})
H.Corner(userBtn, 19)
H.Stroke(userBtn, Palette.BorderSoft, 1)

local chatBtn = H.New("TextButton", {
	Text = "\u{1F4AC}",
	Font = Enum.Font.GothamBold,
	TextSize = 15,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	Size = UDim2.new(0, 38, 0, 38),
	Parent = R.MiniIconRow
})
H.Corner(chatBtn, 19)
H.Stroke(chatBtn, Palette.BorderSoft, 1)

H.New("TextLabel", {
	Text = "unlock the mystery within \u{2726}",
	Font = Enum.Font.Gotham,
	TextSize = 11,
	TextColor3 = Palette.TextFaint,
	BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 372),
	Size = UDim2.new(1, -20, 0, 16),
	Parent = R.KeyWidget
})

local userHeader, closeUserBtn = buildHeader(R.UserPanel, "Player Info")

R.UserMiniHead = H.New("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 16, 0, 48),
	Size = UDim2.new(1, -32, 0, 46),
	Parent = R.UserPanel
})

R.UserAvatar = H.New("Frame", {
	BackgroundColor3 = D.Accents[1].Accent,
	Size = UDim2.new(0, 42, 0, 42),
	Parent = R.UserMiniHead
})
H.Corner(R.UserAvatar, 11)
H.Gradient(R.UserAvatar, D.Accents[1].Accent2, D.Accents[1].Accent, 135)

H.New("TextLabel", {
	Text = "\u{1F464}",
	Font = Enum.Font.GothamBold,
	TextSize = 16,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, 0),
	Parent = R.UserAvatar
})

R.UserDisplayName = H.New("TextLabel", {
	Text = S.LocalPlayer.DisplayName,
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	TextColor3 = Palette.Text,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 52, 0, 0),
	Size = UDim2.new(1, -52, 0, 18),
	Parent = R.UserMiniHead
})

R.UserUsername = H.New("TextLabel", {
	Text = "@" .. S.LocalPlayer.Name,
	Font = Enum.Font.Gotham,
	TextSize = 11,
	TextColor3 = Palette.TextFaint,
	TextXAlignment = Enum.TextXAlignment.Left,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 52, 0, 18),
	Size = UDim2.new(1, -52, 0, 16),
	Parent = R.UserMiniHead
})

R.InfoList = H.New("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 16, 0, 104),
	Size = UDim2.new(1, -32, 1, -114),
	Parent = R.UserPanel
})

H.New("UIListLayout", {
	Padding = UDim.new(0, 2),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.InfoList
})

local function addSectionTitle(order, text)
	H.New("TextLabel", {
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextColor3 = Palette.TextFaint,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 22),
		LayoutOrder = order,
		Parent = R.InfoList
	})
end

local function addInfoRow(order, label, value)
	local row = H.New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 22),
		LayoutOrder = order,
		Parent = R.InfoList
	})
	H.New("TextLabel", {
		Text = label,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = Palette.TextDim,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.5, 0, 1, 0),
		Parent = row
	})
	local valueLabel = H.New("TextLabel", {
		Text = value,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextColor3 = Palette.Text,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextTruncate = Enum.TextTruncate.AtEnd,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0, 0),
		Size = UDim2.new(0.5, 0, 1, 0),
		Parent = row
	})
	return valueLabel
end

addSectionTitle(1, "Account")
addInfoRow(2, "User ID", tostring(S.LocalPlayer.UserId))
addInfoRow(3, "Account age", H.FormatAccountAge(S.LocalPlayer.AccountAge))

addSectionTitle(4, "Game")
addInfoRow(5, "Place ID", tostring(game.PlaceId))
addInfoRow(6, "Job ID", game.JobId ~= "" and game.JobId or "Studio")
addInfoRow(7, "Players", #S.Players:GetPlayers() .. " / " .. S.Players.MaxPlayers)

addSectionTitle(8, "Script")
addInfoRow(9, "Script", "Mystery Hub")
addInfoRow(10, "Version", V.ScriptVersion)
local execNameForPanel, execVersionForPanel = H.GetExecutorInfo()
addInfoRow(11, "Executor", execNameForPanel .. " " .. execVersionForPanel)

R.Toast = H.New("Frame", {
	Name = "Toast",
	AnchorPoint = Vector2.new(0.5, 1),
	Position = UDim2.new(0.5, 0, 1, -26),
	Size = UDim2.new(0, 280, 0, 44),
	BackgroundColor3 = Palette.PanelRaised,
	BackgroundTransparency = 1,
	Parent = R.ScreenGui
})
H.Corner(R.Toast, 12)
R.ToastStroke = H.Stroke(R.Toast, D.Accents[1].Accent, 1)
R.ToastStroke.Transparency = 1

R.ToastLabel = H.New("TextLabel", {
	Text = "",
	Font = Enum.Font.Gotham,
	TextSize = 12,
	TextColor3 = Palette.Text,
	TextTransparency = 1,
	TextWrapped = true,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 12, 0, 0),
	Size = UDim2.new(1, -24, 1, 0),
	Parent = R.Toast
})

function H.ShowToast(message)
	St.ToastGen = (St.ToastGen or 0) + 1
	local myGen = St.ToastGen
	R.ToastLabel.Text = message
	H.Tween(R.Toast, {BackgroundTransparency = 0}, 0.18)
	H.Tween(R.ToastStroke, {Transparency = 0}, 0.18)
	H.Tween(R.ToastLabel, {TextTransparency = 0}, 0.18)
	task.delay(2.2, function()
		if St.ToastGen ~= myGen then
			return
		end
		H.Tween(R.Toast, {BackgroundTransparency = 1}, 0.25)
		H.Tween(R.ToastStroke, {Transparency = 1}, 0.25)
		H.Tween(R.ToastLabel, {TextTransparency = 1}, 0.25)
	end)
end

function H.ApplyAccent(index)
	V.AccentIndex = index
	local accent = D.Accents[index]
	for swatchIndex, entry in ipairs(R.Swatches) do
		entry.Ring.Transparency = swatchIndex == index and 0 or 1
	end
	R.StatusDot.BackgroundColor3 = accent.Accent2
	R.StatusLabel.TextColor3 = accent.Accent2
	R.KeyInputStroke.Color = accent.Accent
	R.GetKeyStroke.Color = accent.Accent
	getKeyBtn.TextColor3 = accent.Accent2
	R.RedeemGradient.Color = ColorSequence.new(accent.Accent2, accent.Accent)
	R.ToastStroke.Color = accent.Accent
	R.Avatar:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(accent.Accent2, accent.Accent)
	R.UserAvatar:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(accent.Accent2, accent.Accent)
	for _, dot in ipairs(R.ProgressRow:GetChildren()) do
		if dot:IsA("Frame") and dot.Size.X.Offset == 16 then
			dot.BackgroundColor3 = accent.Accent2
		end
	end
end

function H.SetToggleState(toggle, knob, state, accentColor)
	if state then
		H.Tween(toggle, {BackgroundColor3 = accentColor}, 0.16)
		H.Tween(knob, {Position = UDim2.new(0, 20, 0, 2), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}, 0.16)
	else
		H.Tween(toggle, {BackgroundColor3 = Palette.BorderSoft}, 0.16)
		H.Tween(knob, {Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color3.fromRGB(203, 185, 230)}, 0.16)
	end
end

local function togglePanel(panel)
	panel.Visible = not panel.Visible
end

settingsBtn.MouseButton1Click:Connect(function()
	togglePanel(R.SettingsPanel)
end)

closeSettingsBtn.MouseButton1Click:Connect(function()
	R.SettingsPanel.Visible = false
end)

userBtn.MouseButton1Click:Connect(function()
	togglePanel(R.UserPanel)
end)

closeUserBtn.MouseButton1Click:Connect(function()
	R.UserPanel.Visible = false
end)

mainCloseBtn.MouseButton1Click:Connect(function()
	H.Tween(R.KeyWidget, {BackgroundTransparency = 1}, 0.2)
	task.delay(0.22, function()
		R.ScreenGui:Destroy()
	end)
end)

for index, entry in ipairs(R.Swatches) do
	entry.Button.MouseButton1Click:Connect(function()
		H.ApplyAccent(index)
	end)
end

function H.SpawnParticleLoop()
	St.ParticleGen = St.ParticleGen + 1
	local myGen = St.ParticleGen
	task.spawn(function()
		while V.ParticlesEnabled and St.ParticleGen == myGen do
			if not V.ReducedMotion then
				local particle = H.New("Frame", {
					BackgroundColor3 = D.Accents[V.AccentIndex].Accent2,
					Position = UDim2.new(math.random(), 0, 1, 0),
					Size = UDim2.new(0, 4, 0, 4),
					BackgroundTransparency = 0.3,
					Parent = R.ParticleLayer
				})
				H.Corner(particle, 2)
				local drift = math.random(-40, 40)
				H.Tween(particle, {
					Position = UDim2.new(particle.Position.X.Scale, drift, -0.3, 0),
					BackgroundTransparency = 1
				}, math.random(5, 9), Enum.EasingStyle.Linear)
				task.delay(9, function()
					particle:Destroy()
				end)
			end
			task.wait(0.4)
		end
	end)
end

blurToggle.MouseButton1Click:Connect(function()
	V.BlurEnabled = not V.BlurEnabled
	H.SetToggleState(blurToggle, blurKnob, V.BlurEnabled, D.Accents[V.AccentIndex].Accent)
	if V.BlurEnabled then
		if not St.BlurEffect then
			St.BlurEffect = H.New("BlurEffect", {Size = 12, Parent = S.Lighting})
		end
	else
		if St.BlurEffect then
			St.BlurEffect:Destroy()
			St.BlurEffect = nil
		end
	end
end)

particlesToggle.MouseButton1Click:Connect(function()
	V.ParticlesEnabled = not V.ParticlesEnabled
	H.SetToggleState(particlesToggle, particlesKnob, V.ParticlesEnabled, D.Accents[V.AccentIndex].Accent)
	if V.ParticlesEnabled then
		H.SpawnParticleLoop()
	else
		St.ParticleGen = St.ParticleGen + 1
	end
end)

compactToggle.MouseButton1Click:Connect(function()
	V.CompactMode = not V.CompactMode
	H.SetToggleState(compactToggle, compactKnob, V.CompactMode, D.Accents[V.AccentIndex].Accent)
	if V.CompactMode then
		R.KeyWidget.Size = UDim2.new(0, 320, 0, 420)
	else
		R.KeyWidget.Size = UDim2.new(0, 320, 0, 470)
	end
end)

motionToggle.MouseButton1Click:Connect(function()
	V.ReducedMotion = not V.ReducedMotion
	H.SetToggleState(motionToggle, motionKnob, V.ReducedMotion, D.Accents[V.AccentIndex].Accent)
end)

getKeyBtn.MouseButton1Click:Connect(function()
	local copied = H.SetClipboard(D.DiscordInvite)
	if copied then
		H.ShowToast("Discord invite copied - join to get your key")
	else
		H.ShowToast("Copy failed - invite link: " .. D.DiscordInvite)
	end
end)

local function attemptRedeem()
	local now = tick()
	if St.LastInvalidAt and (now - St.LastInvalidAt) < 1 then
		return
	end
	local raw = R.KeyInput.Text
	local trimmed = raw:gsub("^%s+", ""):gsub("%s+$", "")
	if trimmed == "" then
		H.ShowToast("Enter a key first")
		return
	end
	if string.upper(trimmed) ~= D.ValidKey then
		St.LastInvalidAt = now
		H.ShowToast("Invalid key")
		return
	end
	getgenv()._MYSTERYHUB_KEY_OK = true
	H.ShowToast("Key accepted - loading...")
	H.SendLog("Key Redeemed")
	local success = H.RunGameScript(function(message)
		H.ShowToast(message)
	end)
	if success then
		H.Tween(R.KeyWidget, {BackgroundTransparency = 1}, 0.25)
		task.delay(0.3, function()
			R.ScreenGui:Destroy()
		end)
	end
end

redeemBtn.MouseButton1Click:Connect(attemptRedeem)

R.KeyInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		attemptRedeem()
	end
end)

chatBtn.MouseButton1Click:Connect(function()
	H.ShowToast("Support chat coming soon")
end)

function H.UpdateResponsive()
	local viewport = S.Camera and S.Camera.ViewportSize or Vector2.new(1280, 720)
	local scale = viewport.X / 1280
	scale = math.clamp(scale, 0.55, 1)
	R.LayoutScale.Scale = scale
	if viewport.X < 700 then
		R.LayoutList.FillDirection = Enum.FillDirection.Vertical
		R.LayoutList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	else
		R.LayoutList.FillDirection = Enum.FillDirection.Horizontal
	end
end

local function bindCamera(camera)
	if not camera then
		return
	end
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(H.UpdateResponsive)
end

bindCamera(S.Camera)

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	S.Camera = workspace.CurrentCamera
	bindCamera(S.Camera)
	H.UpdateResponsive()
end)

H.SetToggleState(particlesToggle, particlesKnob, true, D.Accents[V.AccentIndex].Accent)
H.SpawnParticleLoop()
H.UpdateResponsive()
