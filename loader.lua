--// Sole Hub - Public Loadstring Script
--// Bu script tüm Roblox kullanıcıları tarafından kullanılabilir
--// Usage: loadstring(httpget("https://sole-hub.vercel.app/api/script"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("✅ Sole Hub loaded successfully!")
print("✅ Player: " .. player.Name)

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
