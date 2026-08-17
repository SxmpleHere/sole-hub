const scriptContent = `local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local function ensureFolder(parent, name)
    local existing = parent:FindFirstChild(name)
    if existing and existing:IsA("Folder") then
        return existing
    end
    local folder = Instance.new("Folder")
    folder.Name = name
    folder.Parent = parent
    return folder
end

local function ensureModule(parent, name, source)
    local existing = parent:FindFirstChild(name)
    if existing and existing:IsA("ModuleScript") then
        existing.Source = source
        return existing
    end
    local module = Instance.new("ModuleScript")
    module.Name = name
    module.Source = source
    module.Parent = parent
    return module
end

local function fetchRaw(path)
    return game:HttpGet("https://raw.githubusercontent.com/SxmpleHere/sole-hub/main/" .. path)
end

local root = ensureFolder(ReplicatedStorage, "sole-hub")
local srcRoot = ensureFolder(root, "src")

local files = {
    "src/init.lua",
    "src/Components/Window.lua",
    "src/Components/Section.lua",
    "src/Components/Tab.lua",
    "src/Components/Controls/Button.lua",
    "src/Components/Controls/Toggle.lua",
    "src/Components/Controls/Slider.lua",
    "src/Utils/Theme.lua",
    "src/Utils/Animations.lua",
    "src/Utils/Drag.lua",
    "src/Utils/Whitelist.lua",
}

for _, filePath in ipairs(files) do
    local rel = filePath:match("^src/(.*)$")
    local parts = rel and rel:split("/") or {}
    local parent = srcRoot
    for i = 1, #parts - 1 do
        parent = ensureFolder(parent, parts[i])
    end
    local name = parts[#parts]:match("^(.-)%.lua$")
    local source = fetchRaw(filePath)
    ensureModule(parent, name, source)
end

local UI = require(srcRoot:WaitForChild("init"))

local Window = UI:New({
    Name = "Aimbot",
    Transparency = false,
})

local Section = Window:Section("UNIVERSAL")

local Tab1 = Section:Tab("Aimbot")
local Tab2 = Section:Tab("Visuals")

Tab1:Toggle({
    Name = "Enable Aim Assist",
    Default = false,
    Callback = function(state)
        print("Aim Assist:", state)
    end,
})

Tab1:Slider({
    Name = "Speed",
    Min = 0,
    Max = 200,
    Default = 50,
    Increment = 5,
    Callback = function(value)
        print(value)
    end,
})

Tab1:Button({
    Name = "Reset",
    Callback = function()
        print("basıldı")
    end,
})

Tab1:Toggle({
    Name = "Silent Aim",
    Default = true,
    Callback = function(state)
        print("Silent Aim:", state)
    end,
})

Tab2:Toggle({
    Name = "ESP Boxes",
    Default = false,
    Callback = function(state)
        print("ESP Boxes:", state)
    end,
})

local windowOpen = true

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.KeyCode == Enum.KeyCode.A then
        if windowOpen then
            Window:Close()
            windowOpen = false
        end
    end
end)
`

export default function handler(req, res) {
    if (req.method !== "GET") {
        return res.status(405).json({ error: "Method not allowed" })
    }

    const userAgent = String(req.headers["user-agent"] || "")
    const isRobloxRequest = /Roblox|RobloxStudio/i.test(userAgent)

    if (!isRobloxRequest) {
        return res.status(403).json({ error: "Access denied: only Roblox clients are allowed" })
    }

    res.setHeader("Content-Type", "text/plain; charset=utf-8")
    res.status(200).send(scriptContent)
}
