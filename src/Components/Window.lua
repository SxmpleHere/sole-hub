local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Theme = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("Theme"))
local Drag = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("Drag"))
local Animations = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("Animations"))
local Whitelist = require(script.Parent.Parent:WaitForChild("Utils"):WaitForChild("Whitelist"))
local Section = require(script.Parent:WaitForChild("Section"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Window = {}
Window.__index = Window

local function RaiseError(windowFrame, reason)
    local line = debug.info(3, "l") or debug.info(2, "l") or 0
    local msg = "Line " .. tostring(line) .. ": " .. reason
    warn(msg .. "  -  Client - Module:" .. tostring(line))

    if windowFrame then
        local existing = windowFrame:FindFirstChild("ErrorOverlay")
        if existing then
            existing:Destroy()
        end

        local overlay = Instance.new("Frame")
        overlay.Name = "ErrorOverlay"
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 1
        overlay.BorderSizePixel = 0
        overlay.ZIndex = 50
        overlay.Parent = windowFrame

        local box = Instance.new("Frame")
        box.Size = UDim2.new(0, 260, 0, 120)
        box.Position = UDim2.new(0.5, 0, 0.5, 0)
        box.AnchorPoint = Vector2.new(0.5, 0.5)
        box.BackgroundColor3 = Theme.Colors.Section
        box.BorderSizePixel = 0
        box.Parent = overlay
        Theme.CreateUICorner(box, 8)

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -24, 0, 20)
        title.Position = UDim2.new(0, 12, 0, 10)
        title.BackgroundTransparency = 1
        title.Text = "Error"
        title.TextColor3 = Theme.Colors.Text
        title.TextSize = 15
        title.FontFace = Theme.Font
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = box

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, -24, 0, 62)
        text.Position = UDim2.new(0, 12, 0, 34)
        text.BackgroundTransparency = 1
        text.Text = msg
        text.TextColor3 = Theme.Colors.Text
        text.TextSize = 12
        text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        text.TextWrapped = true
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextYAlignment = Enum.TextYAlignment.Top
        text.Parent = box

        TweenService:Create(overlay, Theme.BezierFast, { BackgroundTransparency = 0.5 }):Play()
        TweenService:Create(box, Theme.Bezier, { Size = UDim2.new(0, 260, 0, 120) }):Play()
    end
end

function Window.new(config)
    config = config or {}

    local title = config.Name or config.Title or "Window Title"
    local transparent = config.Transparency == true
    local whitelistConfig = config.Whitelist or config.WhiteList or {}
    local whitelist = Whitelist.new(whitelistConfig)
    local player = Players.LocalPlayer

    if whitelist:Authorize(player) == false then
        return nil
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = title
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = playerGui

    local frame = Instance.new("CanvasGroup")
    frame.Name = "CanvasGroup"
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Size = UDim2.new(0, 594, 0, 433)
    frame.BackgroundColor3 = Theme.Colors.Bg
    frame.BorderSizePixel = 0
    frame.Parent = gui

    Theme.CreateUICorner(frame, 7)
    local shadow = Instance.new("UIShadow")
    shadow.Parent = frame

    local titleBar = Instance.new("TextLabel")
    titleBar.Name = "Title"
    titleBar.Position = UDim2.new(0.0154857, 0, 0.0286552, 0)
    titleBar.Size = UDim2.new(0.109523, 0, 0.044289, 0)
    titleBar.BackgroundTransparency = 1
    titleBar.Text = title
    titleBar.TextColor3 = Theme.Colors.Text
    titleBar.TextSize = 16
    titleBar.FontFace = Theme.Font
    titleBar.TextXAlignment = Enum.TextXAlignment.Left
    titleBar.Parent = frame

    local dragHandle = Instance.new("Frame")
    dragHandle.Name = "DragHandle"
    dragHandle.Size = UDim2.new(1, 0, 0, 40)
    dragHandle.BackgroundTransparency = 1
    dragHandle.BorderSizePixel = 0
    dragHandle.Parent = frame

    Drag.Attach(frame, dragHandle)

    local featuresPage = Instance.new("CanvasGroup")
    featuresPage.Name = "FeaturesPage"
    featuresPage.Size = UDim2.new(1, 0, 1, 0)
    featuresPage.BackgroundTransparency = 1
    featuresPage.BorderSizePixel = 0
    featuresPage.Parent = frame

    local divider = Instance.new("Frame")
    divider.Name = "Frame"
    divider.Position = UDim2.new(0.176768, 0, 0.00229885, 0)
    divider.Size = UDim2.new(0, 1, 0, 434)
    divider.BackgroundColor3 = Theme.Colors.Stroke
    divider.BorderSizePixel = 0
    divider.Parent = featuresPage

    local sectionHolder = Instance.new("Frame")
    sectionHolder.Name = "SectionHolder"
    sectionHolder.Position = UDim2.new(0.015899, 0, 0.0757637, 0)
    sectionHolder.Size = UDim2.new(0.16, 0, 0.85, 0)
    sectionHolder.BackgroundTransparency = 1
    sectionHolder.BorderSizePixel = 0
    sectionHolder.Parent = featuresPage

    local sectionList = Instance.new("UIListLayout")
    sectionList.Padding = UDim.new(0, 18)
    sectionList.SortOrder = Enum.SortOrder.LayoutOrder
    sectionList.Parent = sectionHolder

    local tabTitle = Instance.new("TextLabel")
    tabTitle.Name = "TabTitle"
    tabTitle.Position = UDim2.new(0.193937, 0, 0.0286552, 0)
    tabTitle.Size = UDim2.new(0.109523, 0, 0.044289, 0)
    tabTitle.BackgroundTransparency = 1
    tabTitle.Text = ""
    tabTitle.TextColor3 = Theme.Colors.Text
    tabTitle.TextSize = 16
    tabTitle.FontFace = Theme.Font
    tabTitle.TextXAlignment = Enum.TextXAlignment.Left
    tabTitle.Parent = featuresPage

    local pageHolder = Instance.new("Frame")
    pageHolder.Name = "PageHolder"
    pageHolder.Position = UDim2.new(0.188784, 0, 0.0874961, 0)
    pageHolder.Size = UDim2.new(0, 473, 0, 337)
    pageHolder.BackgroundTransparency = 1
    pageHolder.BorderSizePixel = 0
    pageHolder.Parent = featuresPage

    local homePage = Instance.new("CanvasGroup")
    homePage.Name = "HomePage"
    homePage.Size = UDim2.new(1, 0, 1, 0)
    homePage.BackgroundTransparency = 1
    homePage.BorderSizePixel = 0
    homePage.Visible = false
    homePage.Parent = frame

    local avatar = Instance.new("CanvasGroup")
    avatar.Name = "Avatar"
    avatar.Position = UDim2.new(0.0152027, 0, 0.0321782, 0)
    avatar.Size = UDim2.new(0, 50, 0, 50)
    avatar.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
    avatar.BorderSizePixel = 0
    avatar.Parent = homePage
    Theme.CreateUICorner(avatar, 999)

    local avatarImage = Instance.new("ImageLabel")
    avatarImage.Position = UDim2.new(0.09, 0, 0.27, 0)
    avatarImage.Size = UDim2.new(0.8, 0, 0.8, 0)
    avatarImage.BackgroundTransparency = 1
    avatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150"
    avatarImage.Parent = avatar

    local greeting = Instance.new("TextLabel")
    greeting.Position = UDim2.new(0.111486, 0, 0.0321782, 0)
    greeting.Size = UDim2.new(0, 300, 0, 50)
    greeting.BackgroundTransparency = 1
    greeting.Text = "Good Morning, " .. player.Name
    greeting.TextColor3 = Theme.Colors.Text
    greeting.TextSize = 20
    greeting.FontFace = Theme.Font
    greeting.TextXAlignment = Enum.TextXAlignment.Left
    greeting.Parent = homePage

    local function statCard(xScale, label, value)
        local card = Instance.new("Frame")
        card.Position = UDim2.new(xScale, 0, 0.185644, 0)
        card.Size = UDim2.new(0, 185, 0, 82)
        card.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
        card.BorderSizePixel = 0
        card.Parent = homePage
        Theme.CreateUICorner(card, 7)

        local labelText = Instance.new("TextLabel")
        labelText.Position = UDim2.new(0.0635824, 0, 0.129739, 0)
        labelText.Size = UDim2.new(0, 155, 0, 13)
        labelText.BackgroundTransparency = 1
        labelText.Text = label
        labelText.TextColor3 = Theme.Colors.SubText
        labelText.TextSize = 14
        labelText.FontFace = Theme.Font
        labelText.TextXAlignment = Enum.TextXAlignment.Left
        labelText.Parent = card

        local valueText = Instance.new("TextLabel")
        valueText.Position = UDim2.new(0.0635824, 0, 0.398032, 0)
        valueText.Size = UDim2.new(0, 155, 0, 13)
        valueText.BackgroundTransparency = 1
        valueText.Text = value
        valueText.TextColor3 = Theme.Colors.Text
        valueText.TextSize = 24
        valueText.FontFace = Theme.Font
        valueText.TextXAlignment = Enum.TextXAlignment.Left
        valueText.Parent = card

        return valueText
    end

    statCard(0.0219595, "Executor", "Luna")
    local runtimeValue = statCard(0.350859, "Script Runtime", "0:00:00")
    statCard(0.676, "Status", "Undetected")

    local startTime = os.clock()
    task.spawn(function()
        while homePage.Parent do
            local elapsed = os.clock() - startTime
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = math.floor(elapsed % 60)
            runtimeValue.Text = string.format("%d:%02d:%02d", h, m, s)
            task.wait(1)
        end
    end)

    local settingsPage = Instance.new("CanvasGroup")
    settingsPage.Name = "SettingsPage"
    settingsPage.Size = UDim2.new(1, 0, 1, 0)
    settingsPage.BackgroundTransparency = 1
    settingsPage.BorderSizePixel = 0
    settingsPage.Visible = false
    settingsPage.Parent = frame

    local comingSoon = Instance.new("TextLabel")
    comingSoon.AnchorPoint = Vector2.new(0.5, 0.5)
    comingSoon.Position = UDim2.new(0.5, 0, 0.5, 0)
    comingSoon.Size = UDim2.new(0, 300, 0, 30)
    comingSoon.BackgroundTransparency = 1
    comingSoon.Text = "Coming soon.."
    comingSoon.TextColor3 = Theme.Colors.SubText
    comingSoon.TextSize = 18
    comingSoon.FontFace = Theme.InterFont
    comingSoon.Parent = settingsPage

    local window = setmetatable({
        Frame = frame,
        SectionHolder = sectionHolder,
        PageHolder = pageHolder,
        TabTitle = tabTitle,
        HomePage = homePage,
        SettingsPage = settingsPage,
        FeaturesPage = featuresPage,
        Tabs = {},
        Error = RaiseError,
        ActivePage = "features",
    }, Window)

    local nav = Instance.new("Frame")
    nav.Name = "Frame"
    nav.Position = UDim2.new(0, 0, 0.933025, 0)
    nav.Size = UDim2.new(1, -1, 0, 30)
    nav.BackgroundColor3 = Theme.Colors.Stroke
    nav.BorderSizePixel = 0
    nav.Parent = frame

    local icons = {}
    local pages = {}
    local switching = false

    local function makeIcon(name, image, xScale)
        local icon = Instance.new("ImageButton")
        icon.Name = name
        icon.Position = UDim2.new(xScale, 0, 0.146666, 0)
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.BackgroundTransparency = 1
        icon.BorderSizePixel = 0
        icon.Image = image
        icon.ImageColor3 = Theme.Colors.NavIdle
        icon.Parent = nav
        icons[name] = icon
        return icon
    end

    local homeIcon = makeIcon("home", "rbxassetid://117906088481880", 0.871838)
    local featuresIcon = makeIcon("features", "rbxassetid://136217097965233", 0.913997)
    local settingsIcon = makeIcon("settings", "rbxassetid://135898386481523", 0.954469)

    local function switchTo(pageName)
        if switching then return end
        if window.ActivePage == pageName then return end
        switching = true

        local current = pages[window.ActivePage]
        local target = pages[pageName]

        for name, icon in pairs(icons) do
            TweenService:Create(icon, Theme.BezierFast, { ImageColor3 = (name == pageName) and Theme.Colors.Text or Theme.Colors.NavIdle }):Play()
        end

        window.Frame.Title.Visible = (pageName == "features")

        if current then
            local fadeOut = TweenService:Create(current, Theme.BezierFast, { GroupTransparency = 1 })
            fadeOut:Play()
            fadeOut.Completed:Connect(function()
                current.Visible = false
                target.Visible = true
                target.GroupTransparency = 1
                local fadeIn = TweenService:Create(target, Theme.BezierFast, { GroupTransparency = 0 })
                fadeIn:Play()
                fadeIn.Completed:Connect(function()
                    switching = false
                end)
            end)
        else
            target.Visible = true
            target.GroupTransparency = 1
            local fadeIn = TweenService:Create(target, Theme.BezierFast, { GroupTransparency = 0 })
            fadeIn:Play()
            fadeIn.Completed:Connect(function()
                switching = false
            end)
        end

        window.ActivePage = pageName
    end

    homeIcon.MouseButton1Click:Connect(function()
        switchTo("home")
    end)
    featuresIcon.MouseButton1Click:Connect(function()
        switchTo("features")
    end)
    settingsIcon.MouseButton1Click:Connect(function()
        switchTo("settings")
    end)

    pages.home = homePage
    pages.features = featuresPage
    pages.settings = settingsPage

    featuresPage.Visible = true
    window.ActivePage = "features"
    window.NavIcons = icons
    window.NavBar = nav
    window.NavPages = pages
    window.SwitchPage = switchTo
    window.Frame.Title.Visible = true
    window.NavIcons.features.ImageColor3 = Theme.Colors.Text

    Animations.OpenWindow(frame, transparent and 0.2 or 0)

    return window
end

function Window:Close()
    Animations.CloseWindow(self.Frame)
end

function Window:Section(name)
    return Section.new(self, name)
end

return Window
