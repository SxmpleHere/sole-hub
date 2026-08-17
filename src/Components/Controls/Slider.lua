local Theme = require(script.Parent.Parent.Parent:WaitForChild("Utils"):WaitForChild("Theme"))
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Slider = {}
Slider.__index = Slider

function Slider.new(tab, config)
    config = config or {}

    local name = config.Name or "Slider"
    local min = config.Min or 0
    local max = config.Max or 100
    local default = config.Default or min
    local increment = config.Increment or 1
    local callback = config.Callback or function() end

    local holder = Instance.new("Frame")
    holder.Name = "Frame"
    holder.Size = UDim2.new(1, 0, 0, 46)
    holder.BackgroundColor3 = Theme.Colors.Section
    holder.BorderSizePixel = 0
    holder.Parent = tab.Page
    Theme.CreateUICorner(holder, 5)
    Theme.CreateStroke(holder, Theme.Colors.Stroke, 1)

    local label = Instance.new("TextLabel")
    label.Position = UDim2.new(0.0234634, 0, 0.441951, 0)
    label.Size = UDim2.new(0.4, 0, 0.112167, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.Colors.Text
    label.TextSize = 15
    label.FontFace = Theme.Font
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local track = Instance.new("Frame")
    track.Name = "Track"
    track.Position = UDim2.new(0.532909, 0, 0.434783, 0)
    track.Size = UDim2.new(0, 163, 0, 5)
    track.BackgroundColor3 = Theme.Colors.ToggleOff
    track.BorderSizePixel = 0
    track.Parent = holder
    Theme.CreateUICorner(track, 999)

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Position = UDim2.new(0.857858, 0, 0.441951, 0)
    valueLabel.Size = UDim2.new(0.05, 0, 0.112167, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Theme.Colors.SubText
    valueLabel.TextSize = 14
    valueLabel.FontFace = Theme.Font
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = holder

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Theme.Colors.Text
    fill.BorderSizePixel = 0
    fill.Parent = track
    Theme.CreateUICorner(fill, 999)

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(0, 0, 0.5, 0)
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.BackgroundColor3 = Theme.Colors.Text
    knob.BorderSizePixel = 0
    knob.ZIndex = 2
    knob.Parent = track
    Theme.CreateUICorner(knob, 999)

    local interact = Instance.new("TextButton")
    interact.Name = "Interact"
    interact.AnchorPoint = Vector2.new(0, 0.5)
    interact.Position = UDim2.new(0, 0, 0.5, 0)
    interact.Size = UDim2.new(1, 0, 0, 20)
    interact.BackgroundTransparency = 1
    interact.Text = ""
    interact.Parent = track

    local dragging = false
    local slider = { Value = default, Holder = holder }

    local function apply(value, fire)
        value = math.clamp(value, min, max)
        if increment > 0 then
            value = min + math.floor((value - min) / increment + 0.5) * increment
            value = math.clamp(value, min, max)
        end

        slider.Value = value
        local pct = (max ~= min) and (value - min) / (max - min) or 0
        fill.Size = UDim2.new(pct, 0, 1, 0)
        knob.Position = UDim2.new(pct, 0, 0.5, 0)
        valueLabel.Text = tostring(value)

        if fire then
            callback(value)
        end
    end

    local function fromInput(xPos)
        local trackPos = track.AbsolutePosition.X
        local trackSize = track.AbsoluteSize.X
        if trackSize <= 0 then return end
        local pct = math.clamp((xPos - trackPos) / trackSize, 0, 1)
        apply(min + (max - min) * pct, true)
    end

    interact.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            fromInput(input.Position.X)
        end
    end)

    interact.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            fromInput(input.Position.X)
        end
    end)

    function slider:Set(value)
        apply(value, true)
    end

    apply(default, false)

    return slider
end

return Slider
