--// Sole Hub - Loadstring Ready Script
--// Usage: loadstring(httpget("https://sxmplehere.github.io/sole-hub/script.lua"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// Whitelist
local whitelist = {
    123456789, -- Replace with your User ID
    987654321, -- Add more IDs here
}

--// Check if player is whitelisted
local allowed = false
for _, userId in ipairs(whitelist) do
    if player.UserId == userId then
        allowed = true
        break
    end
end

if not allowed then
    warn("❌ Access Denied: Not whitelisted")
    return
end

print("✅ Whitelist check passed")

--// DarkUI Library Load
local libSuccess, lib = pcall(function()
    local src = game:GetService("ReplicatedStorage"):WaitForChild("sole-hub"):WaitForChild("src")
    return require(src)
end)

if not libSuccess then
    warn("⚠️ DarkUI not found in ReplicatedStorage, using basic UI")
    lib = nil
end

--// Create Window
local window
if lib then
    window = lib:New({
        Name = "Sole Hub",
        Transparency = false,
    })
else
    print("Running in basic mode (no DarkUI available)")
    return
end

if not window then
    warn("❌ Failed to create window")
    return
end

print("✅ Window created successfully")

--// Add Section
local main = window:Section("Main")
local settings = window:Section("Settings")

--// General Tab
local generalTab = main:Tab("General")

generalTab:Button({
    Name = "Test Button",
    Callback = function()
        print("✅ Button clicked!")
    end,
})

generalTab:Toggle({
    Name = "Enabled",
    Default = true,
    Callback = function(value)
        print("Toggle:", value)
    end,
})

generalTab:Slider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 5,
    Callback = function(value)
        print("Speed:", value)
    end,
})

--// Settings Tab
local configTab = settings:Tab("Config")

configTab:Button({
    Name = "Close Window",
    Callback = function()
        window:Close()
    end,
})

print("✅ Sole Hub loaded successfully!")
