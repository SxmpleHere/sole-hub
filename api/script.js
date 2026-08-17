const scriptContent = `--// Sole Hub - Public Script
--// Usage: loadstring(httpget("https://sole-hub.vercel.app/api/script"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("✅ Sole Hub loaded successfully!")
print("Player: " .. player.Name)

-- Buraya DarkUI ya da diğer kodlarını ekle
`

export default function handler(req, res) {
    // Sadece GET request'lerine izin ver
    if (req.method !== "GET") {
        return res.status(405).json({ error: "Method not allowed" })
    }

    // Script döndür (tüm Roblox kullanıcılarına)
    res.setHeader("Content-Type", "text/plain; charset=utf-8")
    res.status(200).send(scriptContent)
}
