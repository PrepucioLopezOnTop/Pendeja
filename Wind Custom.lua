-- Sherya On Top

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/4479cantcode/Library/refs/heads/main/WindUI/Source.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Avatar = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"

local function note(title, content, icon)
    return WindUI:Notify({
        Title = title,
        Content = content,
        Icon = icon or "info",
        Duration = 3,
    })
end

local function join(list)
    local out = {}
    for _, v in ipairs(list) do
        table.insert(out, tostring(v))
    end
    return table.concat(out, ", ")
end

local function count(tbl)
    local n = 0
    for _ in pairs(tbl) do
        n = n + 1
    end
    return n
end

WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "en",
    Translations = {
        en = {
            HUB_TITLE = "WindUI Full Example",
            HUB_AUTHOR = "Every element and every method",
            LANG_TITLE = "Translated paragraph",
            LANG_DESC = "This text uses the loc: prefix and changes when you switch the language",
            LANG_BUTTON = "Translated button",
            LANG_BUTTON_DESC = "Buttons, toggles, sliders and every other element can be translated too",
        },
        es = {
            HUB_TITLE = "Ejemplo completo de WindUI",
            HUB_AUTHOR = "Todos los elementos y todos los metodos",
            LANG_TITLE = "Parrafo traducido",
            LANG_DESC = "Este texto usa el prefijo loc: y cambia cuando cambias el idioma",
            LANG_BUTTON = "Boton traducido",
            LANG_BUTTON_DESC = "Botones, toggles, sliders y cualquier otro elemento tambien se pueden traducir",
        },
    },
})

WindUI:LoadThemes()

WindUI:AddTheme({
    Name = "Custom Blue",
    Accent = Color3.fromHex("#0b1d3a"),
    Dialog = Color3.fromHex("#0a1730"),
    Outline = Color3.fromHex("#ffffff"),
    Text = Color3.fromHex("#e6f0ff"),
    Placeholder = Color3.fromHex("#6b85a8"),
    Background = Color3.fromHex("#060f20"),
    Button = Color3.fromHex("#1c4ed8"),
    Icon = Color3.fromHex("#60a5fa"),
    Toggle = Color3.fromHex("#22c55e"),
    Slider = Color3.fromHex("#3b82f6"),
    Checkbox = Color3.fromHex("#3b82f6"),
    ElementBackground = Color3.fromHex("#13294b"),
    ElementBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Aurora",
    Accent = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#0f2027"), Transparency = 0 },
        ["50"] = { Color = Color3.fromHex("#203a43"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#2c5364"), Transparency = 0 },
    }, { Rotation = 45 }),
    Dialog = Color3.fromHex("#0d1f26"),
    Outline = Color3.fromHex("#ffffff"),
    Text = Color3.fromHex("#e8fbff"),
    Placeholder = Color3.fromHex("#6ba0b0"),
    Background = WindUI:Gradient({
        ["0"] = { Color = Color3.fromHex("#050b0e"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#102a33"), Transparency = 0 },
    }, { Rotation = 90 }),
    Button = Color3.fromHex("#1fd6c9"),
    Icon = Color3.fromHex("#4dd0e1"),
    Toggle = Color3.fromHex("#1fd6c9"),
    Slider = Color3.fromHex("#4dd0e1"),
    Checkbox = Color3.fromHex("#4dd0e1"),
    ElementBackground = Color3.fromHex("#16323b"),
    ElementBackgroundTransparency = 0,
})

WindUI:OnThemeChange(function(name)
    note("Theme changed", tostring(name), "palette")
end)

local Destroyed = false
local WindowWidth = 700
local WindowHeight = 520

local Window = WindUI:CreateWindow({
    Title = "loc:HUB_TITLE",
    Author = "loc:HUB_AUTHOR",
    Folder = "WindUIFullExample",
    Icon = "layout-dashboard",
    IconSize = 22,
    IconThemed = true,
    IconRadius = 0,
    Size = UDim2.fromOffset(WindowWidth, WindowHeight),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Theme = "Dark",
    Transparent = true,
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
    TopBarButtonIconSize = 16,
    Topbar = {
        Height = 52,
        ButtonsType = "Default",
    },
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            note("User card", LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")", "user")
        end,
    },
    OpenButton = {
        Title = "Open Example",
        Icon = "layout-dashboard",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        OnlyIcon = false,
        Scale = 1,
        Color = ColorSequence.new(Color3.fromHex("#30FF6A"), Color3.fromHex("#e7ff2f")),
    },
})

Window:OnOpen(function()
    note("Window", "Window opened", "eye")
end)

Window:OnClose(function()
    note("Window", "Window closed", "eye-off")
end)

Window:OnDestroy(function()
    Destroyed = true
end)

local VersionTag = Window:Tag({
    Title = "v1.0.0",
    Icon = "tag",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 13,
    Border = false,
})

local SecondTag = Window:Tag({
    Title = "Second tag",
    Icon = "sparkles",
    Color = Color3.fromHex("#ff0080"),
    Radius = 13,
})

Window:CreateTopbarButton("Demo", "bell", function()
    note("Topbar button", "Custom button created with CreateTopbarButton", "bell")
end, 980)

local ElementsSection = Window:Section({
    Title = "Elements",
    Icon = "layers",
    IconThemed = true,
    Opened = true,
})

local ParagraphTab = ElementsSection:Tab({ Title = "Paragraph", Icon = "align-left", ShowTabTitle = true })
local ButtonTab = ElementsSection:Tab({ Title = "Button", Icon = "mouse-pointer-click" })
local ToggleTab = ElementsSection:Tab({ Title = "Toggle", Icon = "toggle-right" })
local SliderTab = ElementsSection:Tab({ Title = "Slider", Icon = "sliders-horizontal" })
local InputTab = ElementsSection:Tab({ Title = "Input", Icon = "text-cursor-input" })
local KeybindTab = ElementsSection:Tab({ Title = "Keybind", Icon = "keyboard" })
local ColorTab = ElementsSection:Tab({ Title = "Colorpicker", Icon = "palette", IconColor = Color3.fromHex("#ff7a5c") })
local DropdownTab = ElementsSection:Tab({ Title = "Dropdown", Icon = "chevrons-up-down" })
local LayoutTab = ElementsSection:Tab({ Title = "Layout", Icon = "layout-panel-left" })
local TabMethodsTab = ElementsSection:Tab({ Title = "Tab Methods", Icon = "list-checks" })

Window:Divider()

local SystemSection = Window:Section({
    Title = "System",
    Icon = "cpu",
    Opened = true,
})

local WindowTab = SystemSection:Tab({ Title = "Window", Icon = "app-window" })
local PopupTab = SystemSection:Tab({ Title = "Popups", Icon = "message-square" })
local ThemeTab = SystemSection:Tab({ Title = "Themes", Icon = "brush" })
local ConfigTab = SystemSection:Tab({ Title = "Config", Icon = "save" })
local LockedTab = SystemSection:Tab({ Title = "Locked Tab", Icon = "lock", Locked = true })

local ExtrasFolder = WindUI:CreateFolder(Window, {
    Title = "Extras",
    Icon = "folder",
    Opened = true,
})

local AITab = ExtrasFolder:Tab({ Title = "AI Assistant", Icon = "sparkles" })

ParagraphTab:Paragraph({
    Title = "Basic paragraph",
    Desc = "A paragraph is a read only block with a title and a description",
})

ParagraphTab:Paragraph({
    Title = "Icon and named color",
    Desc = "Image accepts an icon name and Color accepts Red, Orange, Green, Blue, White or Grey",
    Image = "info",
    ImageSize = 30,
    Color = "Blue",
})

ParagraphTab:Paragraph({
    Title = "Icon and Color3",
    Desc = "Color also accepts any Color3 value",
    Image = "heart",
    Color = Color3.fromHex("#ff4d6d"),
})

ParagraphTab:Paragraph({
    Title = "Thumbnail",
    Desc = "Thumbnail draws an image above the text and ThumbnailSize sets its height",
    Thumbnail = Avatar,
    ThumbnailSize = 140,
})

ParagraphTab:Paragraph({
    Title = "Centered paragraph",
    Desc = "Justify can be Between, Center, Left or Right",
    Justify = "Center",
})

ParagraphTab:Paragraph({
    Title = "Paragraph with buttons",
    Desc = "Buttons adds a row of buttons under the text",
    Image = "star",
    Buttons = {
        {
            Title = "Notify",
            Icon = "bell",
            Callback = function()
                note("Paragraph button", "First button pressed", "bell")
            end,
        },
        {
            Title = "Favorite",
            Icon = "heart",
            Callback = function()
                note("Paragraph button", "Second button pressed", "heart")
            end,
        },
    },
})

local TargetParagraph = ParagraphTab:Paragraph({
    Title = "Target paragraph",
    Desc = "Use the buttons below to call methods on this paragraph",
    Image = "target",
})

ParagraphTab:Button({
    Title = "SetTitle",
    Desc = "Changes the title of the target paragraph",
    Icon = "type",
    Callback = function()
        TargetParagraph:SetTitle("New title " .. math.random(1, 99))
    end,
})

ParagraphTab:Button({
    Title = "SetDesc",
    Desc = "Changes the description of the target paragraph",
    Icon = "type",
    Callback = function()
        TargetParagraph:SetDesc("New description created at " .. os.date("%X"))
    end,
})

ParagraphTab:Button({
    Title = "Highlight",
    Desc = "Plays a highlight animation and scrolls attention to the target paragraph",
    Icon = "sparkles",
    Callback = function()
        TargetParagraph:Highlight()
    end,
})

ParagraphTab:Button({
    Title = "Destroy",
    Desc = "Removes the target paragraph from the tab",
    Icon = "trash",
    Color = "Red",
    Callback = function()
        TargetParagraph:Destroy()
    end,
})

ButtonTab:Button({
    Title = "Default button",
    Desc = "Callback runs every time the button is clicked",
    Icon = "mouse-pointer-click",
    Callback = function()
        note("Button", "Default button clicked", "mouse-pointer-click")
    end,
})

ButtonTab:Button({
    Title = "Icon aligned to the left",
    Desc = "IconAlign can be Left or Right",
    Icon = "download",
    IconAlign = "Left",
    Callback = function()
        note("Button", "IconAlign Left", "download")
    end,
})

ButtonTab:Button({
    Title = "Justify Center",
    Desc = "Justify can be Between, Center, Left or Right",
    Icon = "zap",
    Justify = "Center",
    Callback = function()
        note("Button", "Justify Center", "zap")
    end,
})

ButtonTab:Button({
    Title = "Justify Left",
    Icon = "arrow-left",
    Justify = "Left",
    Callback = function()
        note("Button", "Justify Left", "arrow-left")
    end,
})

ButtonTab:Button({
    Title = "Justify Right",
    Icon = "arrow-right",
    Justify = "Right",
    Callback = function()
        note("Button", "Justify Right", "arrow-right")
    end,
})

ButtonTab:Button({
    Title = "Red button",
    Desc = "Color accepts a named color",
    Color = "Red",
    Icon = "flame",
    Callback = function()
        note("Button", "Red", "flame")
    end,
})

ButtonTab:Button({
    Title = "Green button",
    Color = "Green",
    Icon = "check",
    Callback = function()
        note("Button", "Green", "check")
    end,
})

ButtonTab:Button({
    Title = "Blue button",
    Color = "Blue",
    Icon = "droplet",
    Callback = function()
        note("Button", "Blue", "droplet")
    end,
})

ButtonTab:Button({
    Title = "Orange button",
    Color = "Orange",
    Icon = "sun",
    Callback = function()
        note("Button", "Orange", "sun")
    end,
})

ButtonTab:Button({
    Title = "Custom Color3 button",
    Desc = "Color also accepts any Color3 value",
    Color = Color3.fromHex("#a96bff"),
    Icon = "wand",
    Callback = function()
        note("Button", "Custom Color3", "wand")
    end,
})

ButtonTab:Button({
    Title = "Small button",
    Desc = "Size can be Small, Default or Large",
    Size = "Small",
    Icon = "minimize",
    Callback = function()
        note("Button", "Small", "minimize")
    end,
})

ButtonTab:Button({
    Title = "Large button",
    Desc = "Size Large adds more padding",
    Size = "Large",
    Icon = "maximize",
    Callback = function()
        note("Button", "Large", "maximize")
    end,
})

ButtonTab:Button({
    Title = "Locked button",
    Desc = "Locked starts the button disabled and LockedTitle sets the overlay text",
    Icon = "lock",
    Locked = true,
    LockedTitle = "Not available yet",
    Callback = function()
        note("Button", "You should not see this", "lock")
    end,
})

local ButtonGroup = ButtonTab:Group({})

ButtonGroup:Button({
    Title = "Group A",
    Justify = "Center",
    Icon = "a-large-small",
    Callback = function()
        note("Group", "Button A", "info")
    end,
})

ButtonGroup:Button({
    Title = "Group B",
    Justify = "Center",
    Icon = "bold",
    Callback = function()
        note("Group", "Button B", "info")
    end,
})

ButtonGroup:Button({
    Title = "Group C",
    Justify = "Center",
    Icon = "copy",
    Callback = function()
        note("Group", "Button C", "info")
    end,
})

local TargetButton = ButtonTab:Button({
    Title = "Target button",
    Desc = "Use the buttons below to call methods on this button",
    Icon = "target",
    Callback = function()
        note("Target button", "The target button was clicked", "target")
    end,
})

ButtonTab:Button({
    Title = "Lock",
    Desc = "Disables the target button and shows an overlay",
    Icon = "lock",
    Callback = function()
        TargetButton:Lock()
    end,
})

ButtonTab:Button({
    Title = "Unlock",
    Desc = "Enables the target button again",
    Icon = "lock-open",
    Callback = function()
        TargetButton:Unlock()
    end,
})

ButtonTab:Button({
    Title = "SetTitle",
    Icon = "type",
    Callback = function()
        TargetButton:SetTitle("Renamed " .. math.random(1, 99))
    end,
})

ButtonTab:Button({
    Title = "SetDesc",
    Icon = "type",
    Callback = function()
        TargetButton:SetDesc("Updated at " .. os.date("%X"))
    end,
})

ButtonTab:Button({
    Title = "Highlight",
    Icon = "sparkles",
    Callback = function()
        TargetButton:Highlight()
    end,
})

ButtonTab:Button({
    Title = "Destroy",
    Icon = "trash",
    Color = "Red",
    Callback = function()
        TargetButton:Destroy()
    end,
})

local ChildToggleA = ToggleTab:Toggle({
    Title = "Child toggle A",
    Desc = "Set(value) changes this toggle and fires its callback",
    Value = false,
    Callback = function(state)
        note("Child A", tostring(state), "toggle-right")
    end,
})

local ChildToggleB = ToggleTab:Toggle({
    Title = "Child toggle B",
    Desc = "Set(value, false) changes this toggle without firing its callback",
    Value = false,
    Callback = function(state)
        note("Child B", tostring(state), "toggle-right")
    end,
})

ToggleTab:Toggle({
    Title = "Master toggle",
    Desc = "Controls A with a callback and B silently",
    Value = false,
    Callback = function(state)
        ChildToggleA:Set(state)
        ChildToggleB:Set(state, false)
    end,
})

ToggleTab:Toggle({
    Title = "Toggle with Icon",
    Desc = "Icon draws a symbol inside the knob when the toggle is on",
    Icon = "check",
    IconSize = 23,
    Value = true,
    Callback = function(state)
        note("Toggle with Icon", tostring(state), "check")
    end,
})

ToggleTab:Toggle({
    Title = "Checkbox type",
    Desc = "Type Checkbox draws a checkbox instead of a switch",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        note("Checkbox", tostring(state), "square-check")
    end,
})

ToggleTab:Toggle({
    Title = "Checkbox with Icon",
    Desc = "Checkboxes also accept an Icon",
    Type = "Checkbox",
    Icon = "zap",
    Value = true,
    Callback = function(state)
        note("Checkbox Icon", tostring(state), "zap")
    end,
})

ToggleTab:Toggle({
    Title = "Locked toggle",
    Desc = "Locked with LockedTitle starts disabled",
    Locked = true,
    LockedTitle = "Requires premium",
    Value = true,
    Callback = function(state)
        note("Locked toggle", tostring(state), "lock")
    end,
})

local ToggleGroup = ToggleTab:Group({})

ToggleGroup:Toggle({
    Title = "Group 1",
    Callback = function(state)
        note("Group toggle 1", tostring(state), "toggle-right")
    end,
})

ToggleGroup:Toggle({
    Title = "Group 2",
    Callback = function(state)
        note("Group toggle 2", tostring(state), "toggle-right")
    end,
})

local TargetToggle = ToggleTab:Toggle({
    Title = "Target toggle",
    Desc = "Use the buttons below to call methods on this toggle",
    Value = false,
    Callback = function(state)
        note("Target toggle", tostring(state), "target")
    end,
})

ToggleTab:Button({
    Title = "Set(true)",
    Desc = "Turns it on and fires the callback",
    Callback = function()
        TargetToggle:Set(true)
    end,
})

ToggleTab:Button({
    Title = "Set(false)",
    Desc = "Turns it off and fires the callback",
    Callback = function()
        TargetToggle:Set(false)
    end,
})

ToggleTab:Button({
    Title = "Set(true, false)",
    Desc = "Turns it on silently without the callback",
    Callback = function()
        TargetToggle:Set(true, false)
    end,
})

ToggleTab:Button({
    Title = "Set(false, false, true)",
    Desc = "Turns it off silently and instantly without animation",
    Callback = function()
        TargetToggle:Set(false, false, true)
    end,
})

ToggleTab:Button({
    Title = "Flip using Value",
    Desc = "Reads the Value property and sets the opposite",
    Callback = function()
        TargetToggle:Set(not TargetToggle.Value)
    end,
})

ToggleTab:Button({
    Title = "Read Value",
    Desc = "Shows the current Value property",
    Callback = function()
        note("Target toggle Value", tostring(TargetToggle.Value), "info")
    end,
})

ToggleTab:Button({
    Title = "Lock",
    Callback = function()
        TargetToggle:Lock()
    end,
})

ToggleTab:Button({
    Title = "Unlock",
    Callback = function()
        TargetToggle:Unlock()
    end,
})

ToggleTab:Button({
    Title = "SetTitle",
    Callback = function()
        TargetToggle:SetTitle("Renamed toggle " .. math.random(1, 99))
    end,
})

ToggleTab:Button({
    Title = "SetDesc",
    Callback = function()
        TargetToggle:SetDesc("Updated at " .. os.date("%X"))
    end,
})

ToggleTab:Button({
    Title = "Highlight",
    Callback = function()
        TargetToggle:Highlight()
    end,
})

ToggleTab:Button({
    Title = "Destroy",
    Color = "Red",
    Callback = function()
        TargetToggle:Destroy()
    end,
})

local SliderStatus = SliderTab:Paragraph({
    Title = "Live values",
    Desc = "Move any slider and its value appears here",
    Image = "activity",
})

local BasicSlider = SliderTab:Slider({
    Title = "Basic slider",
    Desc = "Whole numbers from 0 to 100",
    Step = 1,
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(value)
        SliderStatus:SetDesc("Basic slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Title = "Decimal slider",
    Desc = "Step 0.05 gives decimal values",
    Step = 0.05,
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Callback = function(value)
        SliderStatus:SetDesc("Decimal slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Title = "Big step slider",
    Desc = "Step 10 from 0 to 1000",
    Step = 10,
    Value = { Min = 0, Max = 1000, Default = 500 },
    Callback = function(value)
        SliderStatus:SetDesc("Big step slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Title = "Tooltip slider",
    Desc = "IsTooltip shows the value above the thumb while dragging",
    Step = 1,
    IsTooltip = true,
    Value = { Min = 0, Max = 200, Default = 100 },
    Callback = function(value)
        SliderStatus:SetDesc("Tooltip slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Title = "No textbox slider",
    Desc = "IsTextbox false hides the number box",
    Step = 1,
    IsTextbox = false,
    Value = { Min = 0, Max = 50, Default = 25 },
    Callback = function(value)
        SliderStatus:SetDesc("No textbox slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Title = "Wide slider",
    Desc = "Width sets the size of the bar in pixels",
    Step = 1,
    Width = 220,
    Value = { Min = 0, Max = 100, Default = 75 },
    Callback = function(value)
        SliderStatus:SetDesc("Wide slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Desc = "Sliders without a title can use Icons on both sides",
    Step = 1,
    Icons = {
        From = "sfsymbols:sunMinFill",
        To = "sfsymbols:sunMaxFill",
    },
    Value = { Min = 0, Max = 100, Default = 60 },
    Callback = function(value)
        SliderStatus:SetDesc("Brightness slider: " .. tostring(value))
    end,
})

SliderTab:Slider({
    Title = "Locked slider",
    Desc = "Locked with LockedTitle starts disabled",
    Locked = true,
    LockedTitle = "Locked value",
    Step = 1,
    Value = { Min = 0, Max = 100, Default = 30 },
    Callback = function(value)
        SliderStatus:SetDesc("Locked slider: " .. tostring(value))
    end,
})

local TargetSlider = SliderTab:Slider({
    Title = "Target slider",
    Desc = "Use the buttons below to call methods on this slider",
    Step = 1,
    Value = { Min = 0, Max = 100, Default = 40 },
    Callback = function(value)
        SliderStatus:SetDesc("Target slider: " .. tostring(value))
    end,
})

SliderTab:Button({
    Title = "Set(75)",
    Desc = "Moves the slider to 75 and fires the callback",
    Callback = function()
        TargetSlider:Set(75)
    end,
})

SliderTab:Button({
    Title = "Set(random)",
    Desc = "Moves the slider to a random value",
    Callback = function()
        TargetSlider:Set(math.random(0, 100))
    end,
})

SliderTab:Button({
    Title = "SetMin(20)",
    Desc = "Raises the minimum to 20",
    Callback = function()
        TargetSlider:SetMin(20)
    end,
})

SliderTab:Button({
    Title = "SetMax(200)",
    Desc = "Raises the maximum to 200",
    Callback = function()
        TargetSlider:SetMax(200)
    end,
})

SliderTab:Button({
    Title = "Read Value.Default",
    Callback = function()
        note("Target slider", tostring(TargetSlider.Value.Default), "info")
    end,
})

SliderTab:Button({
    Title = "Lock",
    Callback = function()
        TargetSlider:Lock()
    end,
})

SliderTab:Button({
    Title = "Unlock",
    Callback = function()
        TargetSlider:Unlock()
    end,
})

SliderTab:Button({
    Title = "SetTitle",
    Callback = function()
        TargetSlider:SetTitle("Renamed slider " .. math.random(1, 99))
    end,
})

SliderTab:Button({
    Title = "SetDesc",
    Callback = function()
        TargetSlider:SetDesc("Updated at " .. os.date("%X"))
    end,
})

SliderTab:Button({
    Title = "Highlight",
    Callback = function()
        TargetSlider:Highlight()
    end,
})

SliderTab:Button({
    Title = "Destroy",
    Color = "Red",
    Callback = function()
        TargetSlider:Destroy()
    end,
})

local InputStatus = InputTab:Paragraph({
    Title = "Last text",
    Desc = "Type in any input and press Enter",
    Image = "text-cursor-input",
})

InputTab:Input({
    Title = "Basic input",
    Desc = "Callback runs when you press Enter or click away",
    Placeholder = "Type here",
    Value = "",
    Callback = function(text)
        InputStatus:SetDesc("Basic input: " .. text)
    end,
})

InputTab:Input({
    Title = "Input with icon",
    Desc = "InputIcon draws an icon inside the box",
    InputIcon = "search",
    Placeholder = "Search",
    Callback = function(text)
        InputStatus:SetDesc("Search input: " .. text)
    end,
})

InputTab:Input({
    Title = "Clear text on focus",
    Desc = "ClearTextOnFocus empties the box every time you click it",
    ClearTextOnFocus = true,
    Value = "Click me",
    Callback = function(text)
        InputStatus:SetDesc("Clear on focus input: " .. text)
    end,
})

InputTab:Input({
    Title = "Preset value",
    Desc = "Value sets the starting text",
    Value = "Starting text",
    Placeholder = "Preset",
    Callback = function(text)
        InputStatus:SetDesc("Preset input: " .. text)
    end,
})

InputTab:Input({
    Title = "Locked input",
    Desc = "Locked with LockedTitle starts disabled",
    Locked = true,
    LockedTitle = "Read only",
    Value = "Cannot edit",
    Callback = function(text)
        InputStatus:SetDesc("Locked input: " .. text)
    end,
})

InputTab:Input({
    Title = "Textarea",
    Desc = "Type Textarea gives a multiline box",
    Type = "Textarea",
    Placeholder = "Write several lines",
    Value = "Line one\nLine two",
    Callback = function(text)
        InputStatus:SetDesc("Textarea length: " .. #text)
    end,
})

local TargetInput = InputTab:Input({
    Title = "Target input",
    Desc = "Use the buttons below to call methods on this input",
    Placeholder = "Target",
    Callback = function(text)
        InputStatus:SetDesc("Target input: " .. text)
    end,
})

InputTab:Button({
    Title = "Set(text)",
    Desc = "Writes text into the input and fires the callback",
    Callback = function()
        TargetInput:Set("Written from code " .. math.random(1, 99))
    end,
})

InputTab:Button({
    Title = "SetPlaceholder",
    Desc = "Changes the placeholder text",
    Callback = function()
        TargetInput:SetPlaceholder("Placeholder " .. math.random(1, 99))
    end,
})

InputTab:Button({
    Title = "Read Value",
    Callback = function()
        note("Target input", tostring(TargetInput.Value), "info")
    end,
})

InputTab:Button({
    Title = "Lock",
    Callback = function()
        TargetInput:Lock()
    end,
})

InputTab:Button({
    Title = "Unlock",
    Callback = function()
        TargetInput:Unlock()
    end,
})

InputTab:Button({
    Title = "SetTitle",
    Callback = function()
        TargetInput:SetTitle("Renamed input " .. math.random(1, 99))
    end,
})

InputTab:Button({
    Title = "SetDesc",
    Callback = function()
        TargetInput:SetDesc("Updated at " .. os.date("%X"))
    end,
})

InputTab:Button({
    Title = "Highlight",
    Callback = function()
        TargetInput:Highlight()
    end,
})

InputTab:Button({
    Title = "Destroy",
    Color = "Red",
    Callback = function()
        TargetInput:Destroy()
    end,
})

local KeybindStatus = KeybindTab:Paragraph({
    Title = "Last key pressed",
    Desc = "Press one of the bound keys",
    Image = "keyboard",
})

local BasicKeybind = KeybindTab:Keybind({
    Title = "Basic keybind",
    Desc = "Click it, then press any key to rebind it",
    Value = "F",
    CanChange = true,
    Callback = function(key)
        KeybindStatus:SetDesc("Basic keybind fired with " .. key)
        note("Keybind", key .. " pressed", "keyboard")
    end,
})

KeybindTab:Keybind({
    Title = "Second keybind",
    Desc = "Every keybind fires its own callback",
    Value = "G",
    Callback = function(key)
        KeybindStatus:SetDesc("Second keybind fired with " .. key)
    end,
})

KeybindTab:Keybind({
    Title = "Locked keybind",
    Desc = "Locked with LockedTitle starts disabled",
    Value = "H",
    Locked = true,
    LockedTitle = "Cannot rebind",
    Callback = function(key)
        KeybindStatus:SetDesc("Locked keybind fired with " .. key)
    end,
})

KeybindTab:Button({
    Title = "Set(\"J\")",
    Desc = "Rebinds the basic keybind to J from code",
    Callback = function()
        BasicKeybind:Set("J")
    end,
})

KeybindTab:Button({
    Title = "Set(\"F\")",
    Desc = "Rebinds the basic keybind back to F",
    Callback = function()
        BasicKeybind:Set("F")
    end,
})

KeybindTab:Button({
    Title = "Read Value",
    Callback = function()
        note("Basic keybind", tostring(BasicKeybind.Value), "info")
    end,
})

KeybindTab:Button({
    Title = "Lock",
    Callback = function()
        BasicKeybind:Lock()
    end,
})

KeybindTab:Button({
    Title = "Unlock",
    Callback = function()
        BasicKeybind:Unlock()
    end,
})

KeybindTab:Button({
    Title = "SetTitle",
    Callback = function()
        BasicKeybind:SetTitle("Renamed keybind " .. math.random(1, 99))
    end,
})

KeybindTab:Button({
    Title = "SetDesc",
    Callback = function()
        BasicKeybind:SetDesc("Updated at " .. os.date("%X"))
    end,
})

KeybindTab:Button({
    Title = "Highlight",
    Callback = function()
        BasicKeybind:Highlight()
    end,
})

KeybindTab:Button({
    Title = "Destroy",
    Color = "Red",
    Callback = function()
        BasicKeybind:Destroy()
    end,
})

local ColorStatus = ColorTab:Paragraph({
    Title = "Picked color",
    Desc = "Pick a color and its hex value appears here",
    Image = "palette",
})

local BasicColor = ColorTab:Colorpicker({
    Title = "Basic colorpicker",
    Desc = "Default sets the starting color",
    Default = Color3.fromHex("#30ff6a"),
    Callback = function(color)
        ColorStatus:SetDesc("Basic colorpicker: #" .. color:ToHex())
    end,
})

ColorTab:Colorpicker({
    Title = "Colorpicker with transparency",
    Desc = "Transparency adds an alpha slider and the callback receives it as the second value",
    Default = Color3.fromHex("#0091ff"),
    Transparency = 0,
    Callback = function(color, transparency)
        ColorStatus:SetDesc("Transparency colorpicker: #" .. color:ToHex() .. " alpha " .. tostring(transparency))
    end,
})

ColorTab:Colorpicker({
    Title = "Version tag color",
    Desc = "This colorpicker calls Tag:SetColor on the tag next to the window title",
    Default = Color3.fromHex("#30ff6a"),
    Callback = function(color)
        VersionTag:SetColor(color)
    end,
})

ColorTab:Colorpicker({
    Title = "Locked colorpicker",
    Desc = "Locked with LockedTitle starts disabled",
    Locked = true,
    LockedTitle = "Color locked",
    Default = Color3.fromHex("#ff4d6d"),
    Callback = function(color)
        ColorStatus:SetDesc("Locked colorpicker: #" .. color:ToHex())
    end,
})

ColorTab:Button({
    Title = "Update(red)",
    Desc = "Changes the basic colorpicker color from code",
    Callback = function()
        BasicColor:Update(Color3.fromHex("#ff3b3b"))
    end,
})

ColorTab:Button({
    Title = "Update(random, 0.5)",
    Desc = "Changes color and transparency from code",
    Callback = function()
        BasicColor:Update(Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)), 0.5)
    end,
})

ColorTab:Button({
    Title = "Set(blue)",
    Desc = "Set is an alias of Update",
    Callback = function()
        BasicColor:Set(Color3.fromHex("#3b82f6"))
    end,
})

ColorTab:Button({
    Title = "Read Default",
    Callback = function()
        note("Basic colorpicker", "#" .. BasicColor.Default:ToHex(), "info")
    end,
})

ColorTab:Button({
    Title = "Lock",
    Callback = function()
        BasicColor:Lock()
    end,
})

ColorTab:Button({
    Title = "Unlock",
    Callback = function()
        BasicColor:Unlock()
    end,
})

ColorTab:Button({
    Title = "SetTitle",
    Callback = function()
        BasicColor:SetTitle("Renamed colorpicker " .. math.random(1, 99))
    end,
})

ColorTab:Button({
    Title = "SetDesc",
    Callback = function()
        BasicColor:SetDesc("Updated at " .. os.date("%X"))
    end,
})

ColorTab:Button({
    Title = "Highlight",
    Callback = function()
        BasicColor:Highlight()
    end,
})

ColorTab:Button({
    Title = "Destroy",
    Color = "Red",
    Callback = function()
        BasicColor:Destroy()
    end,
})

local DropdownStatus = DropdownTab:Paragraph({
    Title = "Selection",
    Desc = "Choose an option in any dropdown",
    Image = "list",
})

local BasicDropdown = DropdownTab:Dropdown({
    Title = "Single select",
    Desc = "Values is the list and Value is the starting option",
    Values = { "Apple", "Banana", "Cherry", "Grape" },
    Value = "Banana",
    Callback = function(option)
        DropdownStatus:SetDesc("Single select: " .. tostring(option))
    end,
})

local MultiDropdown = DropdownTab:Dropdown({
    Title = "Multi select",
    Desc = "Multi lets you choose several options and the callback receives a table",
    Values = { "Red", "Green", "Blue", "Yellow", "Purple" },
    Value = { "Red", "Blue" },
    Multi = true,
    Callback = function(options)
        DropdownStatus:SetDesc("Multi select: " .. join(options))
    end,
})

DropdownTab:Dropdown({
    Title = "Search bar",
    Desc = "SearchBarEnabled adds a filter box and MenuWidth widens the menu",
    Values = {
        "Argentina", "Brazil", "Canada", "Denmark", "Egypt", "France", "Germany",
        "Hungary", "India", "Japan", "Kenya", "Mexico", "Norway", "Peru", "Spain",
    },
    Value = "Mexico",
    SearchBarEnabled = true,
    MenuWidth = 260,
    Callback = function(option)
        DropdownStatus:SetDesc("Search bar: " .. tostring(option))
    end,
})

DropdownTab:Dropdown({
    Title = "Allow none",
    Desc = "AllowNone lets you deselect the current option",
    Values = { "One", "Two", "Three" },
    AllowNone = true,
    Callback = function(option)
        DropdownStatus:SetDesc("Allow none: " .. tostring(option))
    end,
})

DropdownTab:Dropdown({
    Title = "Multi with search and none",
    Desc = "Multi, SearchBarEnabled and AllowNone together",
    Values = { "Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot" },
    Multi = true,
    AllowNone = true,
    SearchBarEnabled = true,
    Value = { "Alpha" },
    Callback = function(options)
        DropdownStatus:SetDesc("Multi search none: " .. join(options))
    end,
})

DropdownTab:Dropdown({
    Title = "Rich values",
    Desc = "Values can be tables with Title, Icon, Locked and Type Divider",
    Values = {
        { Title = "Home", Icon = "house" },
        { Title = "Settings", Icon = "settings" },
        { Type = "Divider" },
        { Title = "Premium only", Icon = "crown", Locked = true },
        { Title = "Logout", Icon = "log-out" },
    },
    Value = "Home",
    Callback = function(option)
        DropdownStatus:SetDesc("Rich values: " .. tostring(option))
    end,
})

DropdownTab:Dropdown({
    Title = "Menu style",
    Desc = "Without a main Callback the dropdown acts like a menu and each item has its own Callback",
    Values = {
        {
            Title = "Say hello",
            Icon = "hand",
            Callback = function()
                note("Menu", "Hello from the menu", "hand")
            end,
        },
        {
            Title = "Show time",
            Icon = "clock",
            Callback = function()
                note("Menu", os.date("%X"), "clock")
            end,
        },
        { Type = "Divider" },
        {
            Title = "Show player name",
            Icon = "user",
            Callback = function()
                note("Menu", LocalPlayer.Name, "user")
            end,
        },
    },
})

DropdownTab:Dropdown({
    Title = "Locked dropdown",
    Desc = "Locked with LockedTitle starts disabled",
    Locked = true,
    LockedTitle = "Unavailable",
    Values = { "A", "B" },
    Value = "A",
    Callback = function(option)
        DropdownStatus:SetDesc("Locked dropdown: " .. tostring(option))
    end,
})

DropdownTab:Button({
    Title = "Select(\"Cherry\")",
    Desc = "Selects an option of the single dropdown from code",
    Callback = function()
        BasicDropdown:Select("Cherry")
    end,
})

DropdownTab:Button({
    Title = "Select(table) on multi",
    Desc = "Selects several options of the multi dropdown from code",
    Callback = function()
        MultiDropdown:Select({ "Green", "Yellow", "Purple" })
    end,
})

DropdownTab:Button({
    Title = "Select() clears",
    Desc = "Calling Select without value clears the selection",
    Callback = function()
        BasicDropdown:Select()
    end,
})

DropdownTab:Button({
    Title = "Refresh(new values)",
    Desc = "Replaces the list of options of the single dropdown",
    Callback = function()
        BasicDropdown:Refresh({ "Mango", "Papaya", "Pineapple", "Kiwi" })
    end,
})

DropdownTab:Button({
    Title = "Open",
    Desc = "Opens the single dropdown menu from code",
    Callback = function()
        BasicDropdown:Open()
    end,
})

DropdownTab:Button({
    Title = "Close",
    Desc = "Closes the single dropdown menu from code",
    Callback = function()
        BasicDropdown:Close()
    end,
})

DropdownTab:Button({
    Title = "Read Value",
    Callback = function()
        note("Single select", tostring(BasicDropdown.Value), "info")
    end,
})

DropdownTab:Button({
    Title = "Lock",
    Callback = function()
        BasicDropdown:Lock()
    end,
})

DropdownTab:Button({
    Title = "Unlock",
    Callback = function()
        BasicDropdown:Unlock()
    end,
})

DropdownTab:Button({
    Title = "SetTitle",
    Callback = function()
        BasicDropdown:SetTitle("Renamed dropdown " .. math.random(1, 99))
    end,
})

DropdownTab:Button({
    Title = "SetDesc",
    Callback = function()
        BasicDropdown:SetDesc("Updated at " .. os.date("%X"))
    end,
})

DropdownTab:Button({
    Title = "Highlight",
    Callback = function()
        BasicDropdown:Highlight()
    end,
})

DropdownTab:Button({
    Title = "Destroy",
    Color = "Red",
    Callback = function()
        BasicDropdown:Destroy()
    end,
})

LayoutTab:Section({
    Title = "Plain section",
    Desc = "A section without children works as a heading",
})

local BoxSection = LayoutTab:Section({
    Title = "Box section",
    Desc = "Box draws a background, BoxBorder draws an outline and Opened expands it",
    Icon = "box",
    Box = true,
    BoxBorder = true,
    Opened = true,
    TextXAlignment = "Left",
    TextSize = 19,
    DescTextSize = 16,
    FontWeight = Enum.FontWeight.SemiBold,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

BoxSection:Toggle({
    Title = "Toggle inside a section",
    Callback = function(state)
        note("Section toggle", tostring(state), "toggle-right")
    end,
})

BoxSection:Slider({
    Title = "Slider inside a section",
    Step = 1,
    Value = { Min = 0, Max = 10, Default = 5 },
    Callback = function(value)
        note("Section slider", tostring(value), "sliders-horizontal")
    end,
})

BoxSection:Button({
    Title = "Button inside a section",
    Callback = function()
        note("Section button", "Clicked", "mouse-pointer-click")
    end,
})

LayoutTab:Section({
    Title = "Centered section",
    Desc = "TextXAlignment Center",
    TextXAlignment = "Center",
    Icon = "align-center",
})

LayoutTab:Section({
    Title = "Right aligned bold section",
    Desc = "TextXAlignment Right with FontWeight Bold and bigger TextSize",
    TextXAlignment = "Right",
    TextSize = 22,
    FontWeight = Enum.FontWeight.Bold,
    Icon = "align-right",
})

LayoutTab:Button({
    Title = "Section:Open()",
    Desc = "Expands the box section",
    Callback = function()
        BoxSection:Open()
    end,
})

LayoutTab:Button({
    Title = "Section:Close()",
    Desc = "Collapses the box section",
    Callback = function()
        BoxSection:Close()
    end,
})

LayoutTab:Button({
    Title = "Section:SetTitle()",
    Callback = function()
        BoxSection:SetTitle("Section renamed " .. math.random(1, 99))
    end,
})

LayoutTab:Button({
    Title = "Section:SetIcon()",
    Callback = function()
        BoxSection:SetIcon("star")
    end,
})

LayoutTab:Divider()

LayoutTab:Paragraph({
    Title = "Divider and Space",
    Desc = "The line above is a Divider and the gap below is a Space with Columns 3",
})

LayoutTab:Space({ Columns = 3 })

local LayoutGroup = LayoutTab:Group({})

LayoutGroup:Button({
    Title = "Left",
    Justify = "Center",
    Callback = function()
        note("Group", "Left", "arrow-left")
    end,
})

LayoutGroup:Divider()

LayoutGroup:Button({
    Title = "Middle",
    Justify = "Center",
    Callback = function()
        note("Group", "Middle", "circle")
    end,
})

LayoutGroup:Space({})

LayoutGroup:Button({
    Title = "Right",
    Justify = "Center",
    Callback = function()
        note("Group", "Right", "arrow-right")
    end,
})

LayoutTab:Image({
    Image = Avatar,
    AspectRatio = "16:9",
    Radius = 12,
})

LayoutTab:Image({
    Image = Avatar,
    AspectRatio = "4:1",
    Radius = 24,
})

local CodeBlock = LayoutTab:Code({
    Title = "speed.lua",
    Code = "local player = game.Players.LocalPlayer\nlocal humanoid = player.Character.Humanoid\nhumanoid.WalkSpeed = 50\nhumanoid.JumpPower = 80",
    OnCopy = function()
        note("Code", "Copied to the clipboard", "copy")
    end,
})

LayoutTab:Button({
    Title = "Code:SetCode()",
    Desc = "Replaces the code shown in the block",
    Icon = "code",
    Callback = function()
        CodeBlock:SetCode("local Lighting = game:GetService(\"Lighting\")\nLighting.ClockTime = " .. math.random(0, 24))
    end,
})

LayoutTab:Button({
    Title = "Code:Destroy()",
    Desc = "Removes the code block",
    Icon = "trash",
    Color = "Red",
    Callback = function()
        CodeBlock:Destroy()
    end,
})

TabMethodsTab:Paragraph({
    Title = "Tab Methods demo",
    Desc = "The elements below are controlled from the Window tab using LockAll, UnlockAll, GetLocked, GetUnlocked, ScrollToTheElement and Select",
    Image = "list-checks",
})

TabMethodsTab:Toggle({
    Title = "Demo toggle",
    Callback = function(state)
        note("Demo toggle", tostring(state), "toggle-right")
    end,
})

TabMethodsTab:Slider({
    Title = "Demo slider",
    Step = 1,
    Value = { Min = 0, Max = 100, Default = 20 },
    Callback = function() end,
})

TabMethodsTab:Input({
    Title = "Demo input",
    Placeholder = "Type",
    Callback = function() end,
})

TabMethodsTab:Dropdown({
    Title = "Demo dropdown",
    Values = { "One", "Two", "Three" },
    Value = "One",
    Callback = function() end,
})

TabMethodsTab:Keybind({
    Title = "Demo keybind",
    Value = "K",
    Callback = function() end,
})

TabMethodsTab:Colorpicker({
    Title = "Demo colorpicker",
    Default = Color3.fromHex("#ffc83a"),
    Callback = function() end,
})

for i = 1, 8 do
    TabMethodsTab:Paragraph({
        Title = "Filler paragraph " .. i,
        Desc = "Extra content so the tab becomes scrollable",
    })
end

TabMethodsTab:Button({
    Title = "Last element",
    Desc = "ScrollToTheElement scrolls here and highlights it",
    Icon = "flag",
    Callback = function()
        note("Tab Methods", "You reached the last element", "flag")
    end,
})

local WindowSizeSlider
WindowSizeSlider = WindowTab:Slider({
    Title = "Window width",
    Desc = "Calls Window:SetSize with the new width",
    Step = 10,
    Value = { Min = 560, Max = 850, Default = WindowWidth },
    Callback = function(value)
        WindowWidth = value
        Window:SetSize(UDim2.fromOffset(WindowWidth, WindowHeight))
    end,
})

WindowTab:Slider({
    Title = "Window height",
    Desc = "Calls Window:SetSize with the new height",
    Step = 10,
    Value = { Min = 350, Max = 560, Default = WindowHeight },
    Callback = function(value)
        WindowHeight = value
        Window:SetSize(UDim2.fromOffset(WindowWidth, WindowHeight))
    end,
})

WindowTab:Slider({
    Title = "UI scale",
    Desc = "Calls Window:SetUIScale",
    Step = 0.05,
    Value = { Min = 0.6, Max = 1.4, Default = 1 },
    Callback = function(value)
        Window:SetUIScale(value)
    end,
})

WindowTab:Input({
    Title = "Window title",
    Desc = "Calls Window:SetTitle",
    Value = "WindUI Full Example",
    Callback = function(text)
        Window:SetTitle(text)
    end,
})

WindowTab:Input({
    Title = "Window author",
    Desc = "Calls Window:SetAuthor",
    Value = "Every element and every method",
    Callback = function(text)
        Window:SetAuthor(text)
    end,
})

WindowTab:Keybind({
    Title = "Toggle key",
    Desc = "Calls Window:SetToggleKey to change the key that opens and closes the window",
    Value = "RightShift",
    Callback = function() end,
})

WindowTab:Button({
    Title = "Apply toggle key F4",
    Desc = "Window:SetToggleKey(Enum.KeyCode.F4)",
    Callback = function()
        Window:SetToggleKey(Enum.KeyCode.F4)
        note("Toggle key", "The window now toggles with F4", "keyboard")
    end,
})

WindowTab:Button({
    Title = "Restore toggle key RightShift",
    Callback = function()
        Window:SetToggleKey(Enum.KeyCode.RightShift)
        note("Toggle key", "The window now toggles with RightShift", "keyboard")
    end,
})

WindowTab:Toggle({
    Title = "Acrylic blur",
    Desc = "Calls WindUI:ToggleAcrylic",
    Value = true,
    Callback = function(state)
        WindUI:ToggleAcrylic(state)
    end,
})

WindowTab:Toggle({
    Title = "Resizable",
    Desc = "Calls Window:IsResizable to allow or block dragging the corner",
    Value = true,
    Callback = function(state)
        Window:IsResizable(state)
    end,
})

WindowTab:Toggle({
    Title = "Panel background",
    Desc = "Calls Window:SetPanelBackground",
    Value = true,
    Callback = function(state)
        Window:SetPanelBackground(state)
    end,
})

WindowTab:Toggle({
    Title = "User card",
    Desc = "Calls Window.User:Enable and Window.User:Disable",
    Value = true,
    Callback = function(state)
        if state then
            Window.User:Enable()
        else
            Window.User:Disable()
        end
    end,
})

WindowTab:Toggle({
    Title = "Anonymous user",
    Desc = "Calls Window.User:SetAnonymous",
    Value = false,
    Callback = function(state)
        Window.User:SetAnonymous(state)
    end,
})

WindowTab:Toggle({
    Title = "Notifications at the bottom",
    Desc = "Calls WindUI:SetNotificationLower",
    Value = false,
    Callback = function(state)
        WindUI:SetNotificationLower(state)
    end,
})

WindowTab:Button({
    Title = "ToggleFullscreen",
    Desc = "Window:ToggleFullscreen",
    Icon = "maximize",
    Callback = function()
        Window:ToggleFullscreen()
    end,
})

WindowTab:Button({
    Title = "Minimize",
    Desc = "Window:Minimize collapses the window to its topbar and calling it again restores it",
    Icon = "minus",
    Callback = function()
        Window:Minimize()
    end,
})

WindowTab:Button({
    Title = "SetToTheCenter",
    Desc = "Window:SetToTheCenter moves the window back to the center of the screen",
    Icon = "move",
    Callback = function()
        Window:SetToTheCenter()
    end,
})

WindowTab:Button({
    Title = "Close then Open after 3 seconds",
    Desc = "Window:Close and Window:Open",
    Icon = "eye-off",
    Callback = function()
        Window:Close()
        task.delay(3, function()
            if not Destroyed then
                Window:Open()
            end
        end)
    end,
})

WindowTab:Button({
    Title = "Toggle after 2 seconds",
    Desc = "Window:Toggle switches between open and closed",
    Icon = "eye",
    Callback = function()
        Window:Toggle()
        task.delay(2, function()
            if not Destroyed then
                Window:Toggle()
            end
        end)
    end,
})

WindowTab:Button({
    Title = "SetBackgroundImageTransparency",
    Desc = "Window:SetBackgroundImageTransparency",
    Icon = "image",
    Callback = function()
        Window:SetBackgroundImageTransparency(0.5)
    end,
})

WindowTab:Button({
    Title = "Tag:SetTitle",
    Desc = "Changes the text of the version tag",
    Icon = "tag",
    Callback = function()
        VersionTag:SetTitle("v" .. math.random(1, 9) .. "." .. math.random(0, 9) .. "." .. math.random(0, 9))
    end,
})

WindowTab:Button({
    Title = "Tag:SetColor",
    Desc = "Changes the color of the gradient tag",
    Icon = "palette",
    Callback = function()
        GradientTag:SetColor(Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
    end,
})

WindowTab:Button({
    Title = "Tag:SetIcon",
    Desc = "Changes the icon of the version tag",
    Icon = "star",
    Callback = function()
        VersionTag:SetIcon("star")
    end,
})

WindowTab:Button({
    Title = "Tag:Destroy",
    Desc = "Removes the gradient tag",
    Icon = "trash",
    Color = "Red",
    Callback = function()
        GradientTag:Destroy()
    end,
})

WindowTab:Button({
    Title = "Add a new Tag",
    Desc = "Window:Tag creates another tag in the topbar",
    Icon = "plus",
    Callback = function()
        Window:Tag({
            Title = "New " .. math.random(1, 99),
            Icon = "sparkles",
            Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
            Radius = 13,
        })
    end,
})

WindowTab:Button({
    Title = "Add topbar button",
    Desc = "Window:CreateTopbarButton adds another button next to minimize and close",
    Icon = "plus",
    Callback = function()
        Window:CreateTopbarButton("Extra" .. math.random(1, 999), "star", function()
            note("Topbar", "Extra topbar button", "star")
        end, 970)
    end,
})

WindowTab:Button({
    Title = "Hide the Demo topbar button",
    Desc = "Window:DisableTopbarButtons receives a list of button names",
    Icon = "eye-off",
    Callback = function()
        Window:DisableTopbarButtons({ "Demo" })
    end,
})

WindowTab:Button({
    Title = "Edit the open button",
    Desc = "Window:EditOpenButton changes title, icon, color, corner, stroke, scale and dragging",
    Icon = "pencil",
    Callback = function()
        Window:EditOpenButton({
            Title = "Custom open button",
            Icon = "rocket",
            CornerRadius = UDim.new(0, 12),
            StrokeThickness = 3,
            Enabled = true,
            Draggable = true,
            OnlyMobile = false,
            OnlyIcon = false,
            Scale = 1.1,
            Color = ColorSequence.new(Color3.fromHex("#ff0080"), Color3.fromHex("#7928ca")),
        })
    end,
})

WindowTab:Button({
    Title = "Open button icon only",
    Desc = "Window:EditOpenButton with OnlyIcon true",
    Icon = "pencil",
    Callback = function()
        Window:EditOpenButton({
            Icon = "rocket",
            OnlyIcon = true,
            OnlyMobile = false,
            Draggable = true,
            CornerRadius = UDim.new(1, 0),
            StrokeThickness = 2,
            Scale = 1,
        })
    end,
})

WindowTab:Section({ Title = "Tab methods", Desc = "These buttons act on the Tab Methods tab" })

WindowTab:Button({
    Title = "TabMethodsTab:LockAll()",
    Desc = "Locks every element of the Tab Methods tab",
    Icon = "lock",
    Callback = function()
        TabMethodsTab:LockAll()
    end,
})

WindowTab:Button({
    Title = "TabMethodsTab:UnlockAll()",
    Desc = "Unlocks every element of the Tab Methods tab",
    Icon = "lock-open",
    Callback = function()
        TabMethodsTab:UnlockAll()
    end,
})

WindowTab:Button({
    Title = "TabMethodsTab:GetLocked()",
    Desc = "Counts the locked elements",
    Icon = "list",
    Callback = function()
        note("GetLocked", tostring(#TabMethodsTab:GetLocked()) .. " locked elements", "lock")
    end,
})

WindowTab:Button({
    Title = "TabMethodsTab:GetUnlocked()",
    Desc = "Counts the unlocked elements",
    Icon = "list",
    Callback = function()
        note("GetUnlocked", tostring(#TabMethodsTab:GetUnlocked()) .. " unlocked elements", "lock-open")
    end,
})

WindowTab:Button({
    Title = "TabMethodsTab:Select()",
    Desc = "Switches to the Tab Methods tab",
    Icon = "arrow-right",
    Callback = function()
        TabMethodsTab:Select()
    end,
})

WindowTab:Button({
    Title = "TabMethodsTab:ScrollToTheElement()",
    Desc = "Switches to the Tab Methods tab and scrolls to its last element",
    Icon = "arrow-down",
    Callback = function()
        TabMethodsTab:Select()
        task.wait(0.3)
        TabMethodsTab:ScrollToTheElement(#TabMethodsTab.Elements)
    end,
})

WindowTab:Button({
    Title = "Window:SelectTab(1)",
    Desc = "Selects a tab by its index",
    Icon = "arrow-right",
    Callback = function()
        Window:SelectTab(1)
    end,
})

WindowTab:Section({ Title = "Danger zone" })

WindowTab:Button({
    Title = "Destroy the window",
    Desc = "Window:Destroy removes the whole interface",
    Icon = "trash",
    Color = "Red",
    Callback = function()
        Window:Dialog({
            Title = "Destroy window",
            Content = "This removes the whole interface. Continue?",
            Icon = "triangle-alert",
            Buttons = {
                {
                    Title = "Cancel",
                    Icon = "x",
                    Variant = "Tertiary",
                    Callback = function() end,
                },
                {
                    Title = "Destroy",
                    Icon = "trash",
                    Variant = "Primary",
                    Callback = function()
                        Window:Destroy()
                    end,
                },
            },
        })
    end,
})

PopupTab:Section({ Title = "Notifications", Desc = "WindUI:Notify" })

PopupTab:Button({
    Title = "Simple notification",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "Simple",
            Content = "Only Title and Content",
        })
    end,
})

PopupTab:Button({
    Title = "Notification with icon",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "With icon",
            Content = "Icon and IconThemed tint the icon with the theme color",
            Icon = "sparkles",
            IconThemed = true,
            Duration = 4,
        })
    end,
})

PopupTab:Button({
    Title = "Notification without close button",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "No close button",
            Content = "CanClose false hides the X button",
            Icon = "shield",
            CanClose = false,
            Duration = 6,
        })
    end,
})

PopupTab:Button({
    Title = "Long notification",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "Long duration",
            Content = "Duration 10 keeps this notification for ten seconds with a progress bar",
            Icon = "clock",
            Duration = 10,
        })
    end,
})

local Persistent

PopupTab:Button({
    Title = "Persistent notification",
    Desc = "Stays for 60 seconds unless you close it with the next button",
    Icon = "bell",
    Callback = function()
        Persistent = WindUI:Notify({
            Title = "Persistent",
            Content = "Close me from code using Notification:Close()",
            Icon = "bell",
            Duration = 60,
        })
    end,
})

PopupTab:Button({
    Title = "Close persistent notification",
    Desc = "Notification:Close()",
    Icon = "x",
    Callback = function()
        if Persistent then
            Persistent:Close()
        end
    end,
})

PopupTab:Section({ Title = "Dialogs and popups", Desc = "Window:Dialog and WindUI:Popup" })

PopupTab:Button({
    Title = "Window:Dialog with two buttons",
    Icon = "message-square",
    Callback = function()
        Window:Dialog({
            Title = "Dialog",
            Content = "Dialogs appear inside the window and block it until you answer",
            Icon = "info",
            Width = 360,
            Buttons = {
                {
                    Title = "Cancel",
                    Icon = "x",
                    Variant = "Tertiary",
                    Callback = function()
                        note("Dialog", "Cancelled", "x")
                    end,
                },
                {
                    Title = "Confirm",
                    Icon = "check",
                    Variant = "Primary",
                    Callback = function()
                        note("Dialog", "Confirmed", "check")
                    end,
                },
            },
        })
    end,
})

PopupTab:Button({
    Title = "Window:Dialog with every variant",
    Icon = "message-square",
    Callback = function()
        Window:Dialog({
            Title = "Button variants",
            Content = "Primary, Secondary, Tertiary and White",
            Icon = "palette",
            IconThemed = true,
            Buttons = {
                {
                    Title = "Primary",
                    Variant = "Primary",
                    Callback = function()
                        note("Variant", "Primary", "check")
                    end,
                },
                {
                    Title = "Secondary",
                    Variant = "Secondary",
                    Callback = function()
                        note("Variant", "Secondary", "check")
                    end,
                },
                {
                    Title = "Tertiary",
                    Variant = "Tertiary",
                    Callback = function()
                        note("Variant", "Tertiary", "check")
                    end,
                },
                {
                    Title = "White",
                    Variant = "White",
                    Callback = function()
                        note("Variant", "White", "check")
                    end,
                },
            },
        })
    end,
})

PopupTab:Button({
    Title = "WindUI:Popup",
    Icon = "message-square",
    Callback = function()
        WindUI:Popup({
            Title = "Popup",
            Icon = "sparkles",
            IconThemed = true,
            Content = "Popups are similar to dialogs and can be opened without calling the window",
            Buttons = {
                {
                    Title = "Nope",
                    Icon = "x",
                    Variant = "Tertiary",
                    Callback = function()
                        note("Popup", "Closed", "x")
                    end,
                },
                {
                    Title = "Nice",
                    Icon = "check",
                    Variant = "Primary",
                    Callback = function()
                        note("Popup", "Accepted", "check")
                    end,
                },
            },
        })
    end,
})

local ThemeDropdown = ThemeTab:Dropdown({
    Title = "Theme",
    Desc = "WindUI:SetTheme changes the whole interface",
    Values = WindUI:GetThemeNames(),
    Value = WindUI:GetCurrentTheme(),
    SearchBarEnabled = true,
    Callback = function(name)
        WindUI:SetTheme(name)
    end,
})

ThemeTab:Dropdown({
    Title = "Font",
    Desc = "WindUI:SetFont changes the font of every text",
    Values = {
        "rbxassetid://12187365364",
        "rbxasset://fonts/families/GothamSSm.json",
        "rbxasset://fonts/families/Arial.json",
        "rbxasset://fonts/families/Montserrat.json",
    },
    Value = "rbxassetid://12187365364",
    Callback = function(font)
        WindUI:SetFont(font)
    end,
})

ThemeTab:Toggle({
    Title = "Acrylic",
    Desc = "WindUI:ToggleAcrylic",
    Value = true,
    Callback = function(state)
        WindUI:ToggleAcrylic(state)
    end,
})

ThemeTab:Button({
    Title = "AddTheme at runtime",
    Desc = "Creates a random theme, refreshes the dropdown and applies it",
    Icon = "plus",
    Callback = function()
        local base = Color3.fromRGB(math.random(30, 220), math.random(30, 220), math.random(30, 220))
        WindUI:AddTheme({
            Name = "Runtime Theme",
            Accent = base:Lerp(Color3.new(0, 0, 0), 0.7),
            Dialog = base:Lerp(Color3.new(0, 0, 0), 0.8),
            Outline = Color3.new(1, 1, 1),
            Text = Color3.new(1, 1, 1),
            Placeholder = base:Lerp(Color3.new(1, 1, 1), 0.3),
            Background = base:Lerp(Color3.new(0, 0, 0), 0.9),
            Button = base,
            Icon = base:Lerp(Color3.new(1, 1, 1), 0.4),
            Toggle = base,
            Slider = base,
            Checkbox = base,
            ElementBackground = base:Lerp(Color3.new(0, 0, 0), 0.75),
            ElementBackgroundTransparency = 0,
        })
        ThemeDropdown:Refresh(WindUI:GetThemeNames())
        WindUI:SetTheme("Runtime Theme")
    end,
})

ThemeTab:Button({
    Title = "LoadThemes(\"Sakura\", \"Neon\")",
    Desc = "Loads only the named themes of the extra pack and returns their names",
    Icon = "download",
    Callback = function()
        local loaded = WindUI:LoadThemes("Sakura", "Neon")
        note("LoadThemes", join(loaded), "download")
    end,
})

ThemeTab:Button({
    Title = "GetThemes",
    Desc = "Counts the registered themes",
    Icon = "list",
    Callback = function()
        note("GetThemes", tostring(count(WindUI:GetThemes())) .. " themes", "palette")
    end,
})

ThemeTab:Button({
    Title = "GetCurrentTheme",
    Icon = "palette",
    Callback = function()
        note("GetCurrentTheme", tostring(WindUI:GetCurrentTheme()), "palette")
    end,
})

ThemeTab:Button({
    Title = "GetTransparency",
    Icon = "layers",
    Callback = function()
        note("GetTransparency", tostring(WindUI:GetTransparency()), "layers")
    end,
})

ThemeTab:Button({
    Title = "GetWindowSize",
    Icon = "maximize",
    Callback = function()
        local size = WindUI:GetWindowSize()
        note("GetWindowSize", size.X.Offset .. " x " .. size.Y.Offset, "maximize")
    end,
})

ThemeTab:Button({
    Title = "Refresh theme list",
    Desc = "Dropdown:Refresh with WindUI:GetThemeNames",
    Icon = "refresh-cw",
    Callback = function()
        ThemeDropdown:Refresh(WindUI:GetThemeNames())
    end,
})

ThemeTab:Section({ Title = "Localization", Desc = "WindUI:SetLanguage and the loc: prefix" })

ThemeTab:Dropdown({
    Title = "Language",
    Desc = "Switches every text that starts with loc:",
    Values = { "en", "es" },
    Value = "en",
    Callback = function(language)
        WindUI:SetLanguage(language)
    end,
})

ThemeTab:Paragraph({
    Title = "loc:LANG_TITLE",
    Desc = "loc:LANG_DESC",
    Image = "languages",
})

ThemeTab:Button({
    Title = "loc:LANG_BUTTON",
    Desc = "loc:LANG_BUTTON_DESC",
    Icon = "languages",
    Callback = function()
        note("Localization", "Translated button pressed", "languages")
    end,
})

if Window.ConfigManager then
    local ConfigManager = Window.ConfigManager
    local Config = ConfigManager:CreateConfig("example")
    Window:SetCurrentConfig(Config)

    ConfigTab:Paragraph({
        Title = "Config system",
        Desc = "Elements with a Flag are saved to disk. Change them, press Save, change them again and press Load to restore",
        Image = "save",
    })

    ConfigTab:Toggle({
        Title = "Saved toggle",
        Flag = "SavedToggle",
        Value = true,
        Callback = function(state)
            note("Saved toggle", tostring(state), "toggle-right")
        end,
    })

    ConfigTab:Slider({
        Title = "Saved slider",
        Flag = "SavedSlider",
        Step = 1,
        Value = { Min = 0, Max = 100, Default = 25 },
        Callback = function() end,
    })

    ConfigTab:Input({
        Title = "Saved input",
        Flag = "SavedInput",
        Value = "hello",
        Callback = function() end,
    })

    ConfigTab:Keybind({
        Title = "Saved keybind",
        Flag = "SavedKeybind",
        Value = "H",
        Callback = function() end,
    })

    ConfigTab:Dropdown({
        Title = "Saved dropdown",
        Flag = "SavedDropdown",
        Values = { "One", "Two", "Three" },
        Value = "Two",
        Callback = function() end,
    })

    ConfigTab:Colorpicker({
        Title = "Saved colorpicker",
        Flag = "SavedColor",
        Default = Color3.fromHex("#30ff6a"),
        Callback = function() end,
    })

    ConfigTab:Button({
        Title = "Config:Save()",
        Desc = "Writes every flagged element to disk",
        Icon = "save",
        Color = "Green",
        Callback = function()
            Config:Save()
            note("Config", "Saved", "save")
        end,
    })

    ConfigTab:Button({
        Title = "Config:Load()",
        Desc = "Restores every flagged element from disk",
        Icon = "download",
        Callback = function()
            local ok, message = Config:Load()
            note("Config", ok and "Loaded" or tostring(message), "download")
        end,
    })

    ConfigTab:Button({
        Title = "Config:Delete()",
        Desc = "Removes the config file",
        Icon = "trash",
        Color = "Red",
        Callback = function()
            local ok, message = Config:Delete()
            note("Config", tostring(message), ok and "trash" or "x")
        end,
    })

    ConfigTab:Button({
        Title = "Config:SetAutoLoad(true)",
        Desc = "Marks the config to load automatically the next time the script runs",
        Icon = "rotate-cw",
        Callback = function()
            Config:SetAutoLoad(true)
            Config:Save()
            note("Config", "Auto load enabled", "rotate-cw")
        end,
    })

    ConfigTab:Button({
        Title = "Config:SetAutoLoad(false)",
        Icon = "rotate-cw",
        Callback = function()
            Config:SetAutoLoad(false)
            Config:Save()
            note("Config", "Auto load disabled", "rotate-cw")
        end,
    })

    ConfigTab:Button({
        Title = "Config:Set(\"Note\", value)",
        Desc = "Stores custom data inside the config and saves it",
        Icon = "database",
        Callback = function()
            Config:Set("Note", "Saved at " .. os.date("%X"))
            Config:Save()
            note("Config", "Custom data stored", "database")
        end,
    })

    ConfigTab:Button({
        Title = "Config:Get(\"Note\")",
        Desc = "Reads the custom data back",
        Icon = "database",
        Callback = function()
            note("Config custom data", tostring(Config:Get("Note")), "database")
        end,
    })

    ConfigTab:Button({
        Title = "Config:GetData()",
        Desc = "Counts registered elements and custom data",
        Icon = "list",
        Callback = function()
            local data = Config:GetData()
            note("Config data", count(data.elements) .. " elements, autoload " .. tostring(data.autoload), "list")
        end,
    })

    ConfigTab:Button({
        Title = "ConfigManager:AllConfigs()",
        Desc = "Lists the config files on disk",
        Icon = "folder",
        Callback = function()
            note("Configs on disk", join(ConfigManager:AllConfigs()), "folder")
        end,
    })

    ConfigTab:Button({
        Title = "ConfigManager:GetConfig(\"example\")",
        Icon = "folder",
        Callback = function()
            note("GetConfig", tostring(ConfigManager:GetConfig("example") ~= nil), "folder")
        end,
    })

    ConfigTab:Button({
        Title = "ConfigManager:GetAutoLoadConfigs()",
        Icon = "folder",
        Callback = function()
            note("Auto load configs", join(ConfigManager:GetAutoLoadConfigs()), "folder")
        end,
    })

    ConfigTab:Button({
        Title = "ConfigManager:DeleteConfig(\"example\")",
        Icon = "trash",
        Color = "Red",
        Callback = function()
            local ok, message = ConfigManager:DeleteConfig("example")
            note("DeleteConfig", tostring(message), ok and "trash" or "x")
        end,
    })
else
    ConfigTab:Paragraph({
        Title = "Config unavailable",
        Desc = "Your executor does not expose file functions such as writefile",
        Image = "triangle-alert",
        Color = "Orange",
    })
end

LockedTab:Paragraph({
    Title = "Locked tab",
    Desc = "This tab was created with Locked true so it cannot be opened",
})

WindUI:CreateSettingsTab(Window, {
    Section = ExtrasFolder,
    Title = "Settings",
    Icon = "settings",
    ShowTheme = true,
    ShowAcrylic = true,
    ShowUIScale = true,
    ShowKeybind = false,
    ShowConfig = false,
})

local AI = WindUI:AttachAI(Window, {
    Name = "Hub Assistant",
    Title = "Hub Assistant",
    System = "You are a short and friendly assistant inside a script hub",
    Icon = "sparkles",
    Order = 990,
    Accent = Color3.fromHex("#30ff6a"),
    MaxHistory = 20,
    Ask = function(prompt, history)
        return "You said: " .. prompt .. " (" .. #history .. " messages in history)"
    end,
})

AITab:Paragraph({
    Title = "AI chat panel",
    Desc = "WindUI:AttachAI adds a chat panel and a topbar button. Ask receives your prompt and returns the answer, or you can pass Provider, Model and ApiKey to use Groq or OpenAI",
    Image = "sparkles",
})

AITab:Button({
    Title = "AI:Toggle()",
    Desc = "Shows or hides the chat panel",
    Icon = "message-circle",
    Callback = function()
        AI:Toggle()
    end,
})

AITab:Button({
    Title = "AI:Open()",
    Icon = "eye",
    Callback = function()
        AI:Open()
    end,
})

AITab:Button({
    Title = "AI:Hide()",
    Icon = "eye-off",
    Callback = function()
        AI:Hide()
    end,
})

AITab:Button({
    Title = "AI:Ask(\"Hello\")",
    Desc = "Sends a message from code",
    Icon = "send",
    Callback = function()
        AI:Open()
        AI:Ask("Hello from code")
    end,
})

AITab:Button({
    Title = "AI:Clear()",
    Desc = "Clears the conversation",
    Icon = "eraser",
    Callback = function()
        AI:Clear()
    end,
})

AITab:Button({
    Title = "AI:SetName()",
    Desc = "Renames the assistant",
    Icon = "type",
    Callback = function()
        AI:SetName("Assistant " .. math.random(1, 99))
    end,
})

AITab:Button({
    Title = "AI:SetSystem()",
    Desc = "Changes the system prompt",
    Icon = "settings",
    Callback = function()
        AI:SetSystem("You answer only in one short sentence")
    end,
})

AITab:Button({
    Title = "AI:Destroy()",
    Desc = "Removes the chat panel and its topbar button",
    Icon = "trash",
    Color = "Red",
    Callback = function()
        AI:Destroy()
    end,
})

Window:SelectTab(1)

WindUI:Notify({
    Title = "WindUI Full Example",
    Content = "Open every tab to see each element and its methods",
    Icon = "sparkles",
    IconThemed = true,
    Duration = 6,
})
