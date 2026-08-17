local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent.Parent.Parent:WaitForChild("Utils"):WaitForChild("Theme"))

local Button = {}
Button.__index = Button

function Button.new(tab, config)
    config = config or {}
    local name = config.Name or "Button"
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
    label.Size = UDim2.new(0.8, 0, 0.112167, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.Colors.Text
    label.TextSize = 15
    label.FontFace = Theme.Font
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local interact = Instance.new("TextButton")
    interact.Name = "Interact"
    interact.Size = UDim2.new(1, 0, 1, 0)
    interact.BackgroundTransparency = 1
    interact.Text = ""
    interact.AutoButtonColor = false
    interact.Parent = holder

    interact.MouseButton1Down:Connect(function()
        TweenService:Create(holder, Theme.BezierFast, { BackgroundColor3 = Theme.Colors.Stroke }):Play()
    end)
    interact.MouseButton1Up:Connect(function()
        TweenService:Create(holder, Theme.BezierFast, { BackgroundColor3 = Theme.Colors.Section }):Play()
    end)
    interact.MouseLeave:Connect(function()
        TweenService:Create(holder, Theme.BezierFast, { BackgroundColor3 = Theme.Colors.Section }):Play()
    end)
    interact.MouseButton1Click:Connect(function()
        callback()
    end)

    local button = { Holder = holder, Label = label }
    function button:SetName(newName)
        label.Text = newName
    end

    return button
end

return Button
