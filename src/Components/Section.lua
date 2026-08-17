local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("Theme"))
local Tab = require(script.Parent:WaitForChild("Tab"))

local Section = {}
Section.__index = Section

function Section.new(window, name)
    local holder = Instance.new("Frame")
    holder.Name = name .. "SectionHolder"
    holder.AutomaticSize = Enum.AutomaticSize.Y
    holder.Size = UDim2.new(1, 0, 0, 0)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.ClipsDescendants = true
    holder.Parent = window.SectionHolder

    local label = Instance.new("TextLabel")
    label.Name = "Section Label"
    label.Size = UDim2.new(0, 0, 0, 19)
    label.AutomaticSize = Enum.AutomaticSize.X
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.Colors.SubText
    label.TextSize = 13
    label.FontFace = Theme.Font
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local minimize = Instance.new("ImageButton")
    minimize.Name = "Section Minimize"
    minimize.Position = UDim2.new(0, 0, 0, 3)
    minimize.Size = UDim2.new(0, 12, 0, 12)
    minimize.BackgroundTransparency = 1
    minimize.BorderSizePixel = 0
    minimize.Image = "rbxassetid://11421095840"
    minimize.ImageColor3 = Theme.Colors.SubText
    minimize.Parent = holder

    label:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        minimize.Position = UDim2.new(0, label.AbsoluteSize.X + 6, 0, 3)
    end)

    local tabList = Instance.new("CanvasGroup")
    tabList.Name = "TabList"
    tabList.Position = UDim2.new(0, 0, 0, 22)
    tabList.AutomaticSize = Enum.AutomaticSize.Y
    tabList.Size = UDim2.new(1, 0, 0, 0)
    tabList.BackgroundTransparency = 1
    tabList.BorderSizePixel = 0
    tabList.Parent = holder

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 4)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabList

    local section = setmetatable({
        Holder = holder,
        Label = label,
        TabList = tabList,
        Window = window,
        Collapsed = false,
    }, Section)

    minimize.MouseButton1Click:Connect(function()
        section.Collapsed = not section.Collapsed
        if section.Collapsed then
            TweenService:Create(tabList, Theme.Bezier, { GroupTransparency = 1, Position = UDim2.new(0, 0, 0, 10) }):Play()
            TweenService:Create(minimize, Theme.Bezier, { Rotation = 180 }):Play()
            task.delay(Theme.Bezier.Time, function()
                tabList.Visible = false
            end)
        else
            tabList.Visible = true
            tabList.GroupTransparency = 1
            tabList.Position = UDim2.new(0, 0, 0, 10)
            TweenService:Create(tabList, Theme.Bezier, { GroupTransparency = 0, Position = UDim2.new(0, 0, 0, 22) }):Play()
            TweenService:Create(minimize, Theme.Bezier, { Rotation = 0 }):Play()
        end
    end)

    return section
end

function Section:Tab(name)
    return Tab.new(self, name)
end

return Section
