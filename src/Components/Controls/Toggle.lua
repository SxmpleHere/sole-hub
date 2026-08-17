local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent.Parent.Parent:WaitForChild("Utils"):WaitForChild("Theme"))

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(tab, config)
    config = config or {}

    local name = config.Name or "Toggle"
    local default = config.Default or false
    local callback = config.Callback or function() end

    local holder = Instance.new("Frame")
    holder.Name = "Frame"
    holder.Size = UDim2.new(1, 0, 0, 46)
    holder.BackgroundColor3 = Theme.Colors.Section
    holder.BorderSizePixel = 0
    holder.Parent = tab.Page
    Theme.CreateUICorner(holder, 7)
    Theme.CreateStroke(holder, Theme.Colors.Stroke, 1)

    local label = Instance.new("TextLabel")
    label.Position = UDim2.new(0.0255865, 0, 0.441951, 0)
    label.Size = UDim2.new(0.6, 0, 0.112167, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.Colors.Text
    label.TextSize = 15
    label.FontFace = Theme.Font
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local switch = Instance.new("Frame")
    switch.Name = "Frame"
    switch.Position = UDim2.new(0.931818, 0, 0.292995, 0)
    switch.Size = UDim2.new(0, 18, 0, 18)
    switch.BackgroundColor3 = default and Theme.Colors.Text or Theme.Colors.ToggleOff
    switch.BorderSizePixel = 0
    switch.Parent = holder
    Theme.CreateUICorner(switch, 999)

    local switchShadow = Instance.new("UIShadow")
    switchShadow.Color = Color3.fromRGB(245, 245, 245)
    switchShadow.Parent = switch
    switchShadow.Enabled = default

    local button = Instance.new("TextButton")
    button.Name = "Frame"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = holder

    local toggle = { State = default, Holder = holder, Switch = switch }

    local function set(state, fire)
        toggle.State = state
        TweenService:Create(switch, Theme.BezierFast, { BackgroundColor3 = state and Theme.Colors.Text or Theme.Colors.ToggleOff }):Play()
        switchShadow.Enabled = state
        if fire then
            callback(state)
        end
    end

    button.MouseButton1Click:Connect(function()
        set(not toggle.State, true)
    end)

    function toggle:Set(state)
        set(state, true)
    end

    return toggle
end

return Toggle
