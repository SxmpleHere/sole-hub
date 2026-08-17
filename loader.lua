--// Sole Hub - Secure Loadstring Script
--// Bu script sadece Roblox'tan çalışır, browser'dan değil
--// Usage: loadstring(httpget("https://YOUR-PROJECT.vercel.app/api/script"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// User ID Whitelist
local whitelist = {
    123456789, -- Senin User ID'n
    987654321, -- Arkadaşın ID'si
}

--// Whitelist kontrol
local allowed = false
for _, userId in ipairs(whitelist) do
    if player.UserId == userId then
        allowed = true
        break
    end
end

if not allowed then
    warn("❌ Access Denied: Your User ID is not whitelisted")
    warn("Your User ID: " .. tostring(player.UserId))
    return
end

print("✅ Whitelist check passed")
print("✅ Sole Hub loaded successfully!")

--// DarkUI Library (opsiyonel)
local libSuccess, lib = pcall(function()
    local src = game:GetService("ReplicatedStorage"):WaitForChild("sole-hub"):WaitForChild("src")
    return require(src)
end)

if libSuccess and lib then
    local window = lib:New({
        Name = "Sole Hub",
        Transparency = false,
    })

    if window then
        local main = window:Section("Main")
        local generalTab = main:Tab("General")

        generalTab:Button({
            Name = "Test Button",
            Callback = function()
                print("✅ Button clicked!")
            end,
        })

        print("✅ Window created successfully!")
    end
else
    print("⚠️ DarkUI not found - running basic mode")
end
