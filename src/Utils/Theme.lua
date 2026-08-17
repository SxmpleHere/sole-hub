local Theme = {}

Theme.Colors = {
    Bg = Color3.new(0.0784314, 0.0784314, 0.0784314),
    Section = Color3.new(0.0980392, 0.0980392, 0.0980392),
    Stroke = Color3.new(0.156863, 0.156863, 0.156863),
    Text = Color3.new(0.960784, 0.960784, 0.960784),
    SubText = Color3.new(0.392157, 0.392157, 0.392157),
    ToggleOff = Color3.new(0.215686, 0.215686, 0.215686),
    NavIdle = Color3.new(0.294118, 0.294118, 0.294118),
}

Theme.Font = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Theme.InterFont = Font.new("rbxasset://fonts/families/Inter.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Theme.Bezier = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Theme.BezierFast = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Theme.BezierHalf = TweenInfo.new(Theme.Bezier.Time / 2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

function Theme.CreateUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 7)
    corner.Parent = parent
    return corner
end

function Theme.CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Colors.Stroke
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

return Theme
