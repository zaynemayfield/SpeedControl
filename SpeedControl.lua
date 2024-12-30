-- SpeedControl Addon: Cycles through speed commands (s1, s2, s3, s4)

local speedCommands = { "s1", "s2", "s3", "s4" }
local currentSpeedIndex = 1

-- Function to send the chat command
local function sendSpeedCommand()
    local command = speedCommands[currentSpeedIndex]
    SendChatMessage(command, "SAY")
    print("Speed changed to: " .. command) -- Feedback in chat
end

-- Function to cycle through speeds
function SpeedControl_Cycle()
    currentSpeedIndex = currentSpeedIndex % #speedCommands + 1 -- Increment index cyclically
    sendSpeedCommand()
end

-- Create a frame for the button
local frame = CreateFrame("Frame", "SpeedControlFrame", UIParent)
frame:SetSize(100, 50) -- Width, Height
frame:SetPoint("CENTER", UIParent, "CENTER") -- Center on screen
frame:EnableMouse(true)
frame:SetMovable(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

-- Create a background for the frame
frame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
frame:SetBackdropColor(0, 0, 0, 0.8)

-- Create the single button
local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
button:SetSize(80, 30) -- Width, Height
button:SetText("Cycle Speed")
button:SetPoint("CENTER", frame, "CENTER")
button:SetScript("OnClick", SpeedControl_Cycle)

-- Add keybinding header and names
BINDING_HEADER_SPEED_CONTROL = "Speed Control"
BINDING_NAME_SPEEDCONTROL_CYCLE = "Cycle Speed"
