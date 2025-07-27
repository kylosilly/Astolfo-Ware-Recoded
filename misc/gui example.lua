-- credits to ! nfpw (@nfpw) on discord
--[[
-- use that for loading ur script hub
local shared = (getgenv and getgenv()) or shared or _G
shared.Anka = {
    Config = {
        Color = Color3.fromRGB(255, 128, 64),
        Keybind = Enum.KeyCode.RightShift,
        MinHeight = 100,
        MaxHeight = 600,
        InitialHeight = 400,
        MinWidth = 300,
        MaxWidth = 800,
        InitialWidth = 500,
    }
}
loadstring(readfile("scripthub.lua"))()
--]]

-- example usage
local cloneref = cloneref or function(v) return v; end
local function getservice(v) return cloneref(game:GetService(v)); end
local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;
local shared = (getgenv and getgenv()) or shared or _G

local ReplicatedStorage = getservice("ReplicatedStorage")
local UserInputService = getservice("UserInputService")
local TweenService = getservice("TweenService")
local HttpService = getservice("HttpService")
local TextService = getservice("TextService")
local RunService = getservice("RunService")
local Players = getservice("Players")
local ScriptName = "Anka Hub"

local function requesturl(url)
	if RunService:IsStudio() then	
		return nil
	end
	local req = http_request({
		Url = url,
		Method = "GET"
	})
	if req.StatusCode ~= 200 then
		return nil, req.StatusCode
	end
	return req.Body
end

local Config = (shared.Anka and shared.Anka.Config) or nil
local Library = loadstring(requesturl("https://raw.githubusercontent.com/nfpw/XXSCRIPT/refs/heads/main/Library/Module.lua"))()
local Window = Library:CreateWindow(Config, gethui())
local WindowName = Library:SetWindowName(ScriptName)

local Tabs = {
    Main = Window:CreateTab("Main"),
    Settings = Window:CreateTab("Settings"),
}

-- if u dont choose left or right it will auto generate based on size add "left" or "right" as 2nd argument
local Sections = {
    Toggle = Tabs.Main:CreateSection("Toggle"),
    Label = Tabs.Main:CreateSection("Label"),
    Button = Tabs.Main:CreateSection("Button"),
    TextBox = Tabs.Main:CreateSection("TextBox"),
    Slider = Tabs.Main:CreateSection("Slider"),
    Dropdown = Tabs.Main:CreateSection("Dropdown"),
    Color = Tabs.Main:CreateSection("Color Picker"),
    Other = Tabs.Main:CreateSection("Color Picker"),
}

-- toggle

Sections.Toggle:CreateToggle("Basic Toggle", false, function(state)
    print("Basic toggle state:", state)
end)

Sections.Toggle:CreateToggle("Default On", true, function(state)
    print("Default toggle is now:", state)
end)

Sections.Toggle:CreateToggle("Normal Toggle", false, function(state)
    print("Normal toggle state:", state)
end, "normal")

Sections.Toggle:CreateToggle("Dangerous Toggle", false, function(state)
    print("Dangerous action activated:", state)
end, "dangerous")

Sections.Toggle:CreateToggle("Buggy Toggle", false, function(state)
    print("Buggy feature toggled:", state)
end, "buggy")

Sections.Toggle:CreateToggle("Freaky Feature Toggle", true, function(state)
    print("Full feature state:", state)
end, "dangerous", "Warning: This feature may cause sus when enabled!")

local keybindtoggle = Sections.Toggle:CreateToggle("Keybind Toggle", false, function(state)
    print("Keybind toggle state:", state)
end)
local keybind = keybindtoggle:CreateKeybind("F", function(key)
    print("Keybind pressed:", key)
end, "Toggle")

local sigmatoggle = Sections.Toggle:CreateToggle("Sigma Toggle Hold", true, function(state)
    print("Complete toggle state changed to:", state)
end, "normal", "sigmatoggle")
local kb = sigmatoggle:CreateKeybind("K", function(key)
    print("Keybind pressed:", key)
end, "Hold")
kb:SetBind(Enum.KeyCode.J)

local nilkeybindtoggle = Sections.Toggle:CreateToggle("Nil Keybind Toggle", false, function(state)
    print("Keybind toggle state:", state)
end)
local keybind = nilkeybindtoggle:CreateKeybind(nil, function(key)
    print("Keybind pressed:", key)
end, "Toggle")

-- label

local label = Sections.Label:CreateLabel("Welcome to the UI Library!")

local wrappedlabel = Sections.Label:CreateLabel("This is a much longer text that will wrap to multiple lines when the WrapText parameter is set to true. It's useful for descriptions and longer explanations.",
    true -- wraptext
)

local statuslabel = Sections.Label:CreateLabel("Status: Idle")
statuslabel:UpdateText("Status: Active - "..os.date("%H:%M:%S"))

-- button

Sections.Button:CreateButton("click me", function()
    print("button was clicked")
end)

local toggleablelabel = Sections.Button:CreateLabel("This label can be toggled!")
local togglelabelbutton = Sections.Button:CreateButton("Toggle Label", function()
    local state = toggleablelabel:ToggleVisibility()
    print("Label is now:", state and "visible" or "hidden")
end)

local longbutton = Sections.Button:CreateButton("This is a button with a very long name that will wrap to multiple lines", function()
        print("Long button clicked!")
    end,
true)

Sections.Button:CreateButton("Update Status", function()
    statuslabel:UpdateText("Status: Button Pressed at "..os.date("%H:%M:%S"))
end)

-- textbox

local nameinput = Sections.TextBox:CreateTextBox(
    "enter name", -- title
    "your name here...", -- inside
    false, -- NumbersOnly
    function(value)
        print("name entered:", value)
    end
)

-- slider

local playercountslider = Sections.Slider:CreateSlider(
    "max players",
    1,      -- Min
    16,     -- Max
    8,      -- Default
    true,   -- Precise = true (integers only)
    function(value)
        print("max players:", value)
    end
)

local sensitivityslider = Sections.Slider:CreateSlider(
    "nouse sensitivity",
    0.1,
    10.0,
    2.5,
    false,
    function(value)
        print("sensitivity:", value)
    end
)

-- dropdown

local numberdropdown = Sections.Dropdown:CreateDropdown(
    "Number",
    {"1", "2", "3", "4", "5"},
    function(selected)
        print("selected number: ", selected)
    end,
    "1",  -- Initial value
    false     -- Multi = false (single selection)
)

local skillsdropdown = Sections.Dropdown:CreateDropdown(
    "Skills",
    {"Strength", "Agility", "Intelligence", "Luck", "Charisma"},
    function(selected)
        print("Selected skills:", table.concat(selected, ", "))
    end,
    {"Strength", "Agility"},  -- Initial selected values
    true  -- Multi = true (multiple selection)
)

local difficultydropdown = Sections.Dropdown:CreateDropdown(
    "Difficulty",
    {"Easy", "Normal", "Hard", "Expert"},
    function(selected)
        print("Difficulty changed to:", selected)
    end,
    "Normal"  -- Initial value
)

-- colorpicker

local testcolorpicker = Sections.Color:CreateColorpicker(
    "test Color",
    function(color, transparency)
        print("test color:", color, "transparency:", transparency)
    end
)

local accentcolorpicker = Sections.Color:CreateColorpicker(
    "UI Theme Color",
    function(color, transparency)
        print("UI theme updated:", color, "transparency:", transparency)
    end,
    true  -- IsAccentColorpicker = true
)
accentcolorpicker:UpdateColor(Color3.fromRGB(255, 128, 64))

-- other

Sections.Other:CreateButton("Randomize Settings", function()
    playercountslider:SetValue(math.random(1, 16))
    
    local numbers = {"1", "2", "3", "4", "5"}
    numberdropdown:SetOption(numbers[math.random(1, #numbers)])
    
    local randomcolor = Color3.fromRGB(
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255)
    )
    testcolorpicker:UpdateColor(randomcolor, math.random() * 0.5)
    accentcolorpicker:UpdateColor(randomcolor, math.random() * 0.5)
    
    print("Settings randomized!")
end)

-- config manager
local cfgm = loadstring(requesturl("https://raw.githubusercontent.com/nfpw/XXSCRIPT/refs/heads/main/Library/ConfigManager.lua"))()
cfgm:SetLibrary(Library)
cfgm:SetWindow(Window)
cfgm:SetFolder("Anka") -- ur script hub folder name
cfgm:BuildConfigSection(Tabs.Settings) -- choose tab to built section in
cfgm:LoadAutoloadConfig()

-- if u enable the assets u can do
Window:SetBackground("123456789")
Window:SetTileOffset(100) -- pixel offset
Window:SetTileScale(0.5) -- relative scale

-- background options
Window:SetBackgroundColor(Color3.fromRGB(40, 40, 40))
Window:SetBackgroundTransparency(0.5)
