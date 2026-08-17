local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("Theme"))
local Controls = script.Parent:WaitForChild("Controls")

local Tab = {}
Tab.__index = Tab

function Tab.new(section, name)
    local window = section.Window

    local tabHolder = Instance.new("Frame")
    tabHolder.Name = name .. "TabHolder"
    tabHolder.Size = UDim2.new(1, 0, 0, 22)
    tabHolder.BackgroundTransparency = 1
    tabHolder.BorderSizePixel = 0
    tabHolder.Parent = section.TabList

    local underline = Instance.new("Frame")
    underline.Name = "Frame"
    underline.Position = UDim2.new(0, 0, 1, -3)
    underline.Size = UDim2.new(0, 0, 0, 2)
    underline.BackgroundColor3 = Theme.Colors.Text
    underline.BorderSizePixel = 0
    underline.Parent = tabHolder
    Theme.CreateUICorner(underline, 999)

    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 16)
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Theme.Colors.SubText
    btn.TextSize = 14
    btn.FontFace = Theme.Font
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = tabHolder

    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Visible = #window.Tabs == 0
    page.Parent = window.PageHolder

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 6)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = page

    local tab = setmetatable({
        TabButton = btn,
        Page = page,
        Underline = underline,
        Window = window,
        Section = section,
        Name = name,
    }, Tab)

    local function select()
        for _, existingTab in pairs(window.Tabs) do
            if existingTab ~= tab then
                existingTab.Page.Visible = false
                TweenService:Create(existingTab.TabButton, Theme.BezierFast, { TextColor3 = Theme.Colors.SubText }):Play()
                TweenService:Create(existingTab.Underline, Theme.BezierFast,{ Size = UDim2.new(0, 0, 0, 2) }):Play()
            end
        end

        page.Visible = true
        local textWidth = btn.TextBounds.X * 0.45
        TweenService:Create(btn, Theme.BezierFast, { TextColor3 = Theme.Colors.Text }):Play()
        TweenService:Create(underline, Theme.Bezier, { Size = UDim2.new(0, textWidth, 0, 2) }):Play()

        if window.TabTitle then
            window.TabTitle.Text = name
        end
    end

    btn.MouseButton1Click:Connect(select)
    table.insert(window.Tabs, tab)

    if #window.Tabs == 1 then
        select()
    end

    return tab
end

function Tab:Toggle(config)
    local Toggle = require(Controls:WaitForChild("Toggle"))
    return Toggle.new(self, config)
end

function Tab:Button(config)
    local Button = require(Controls:WaitForChild("Button"))
    return Button.new(self, config)
end

function Tab:Slider(config)
    local Slider = require(Controls:WaitForChild("Slider"))
    return Slider.new(self, config)
end

return Tab
