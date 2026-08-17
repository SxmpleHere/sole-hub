const whitelist = [
    123456789, // Senin User ID
    987654321, // Arkadaş ID
]

const scriptContent = `--// Sole Hub - Protected Script
--// Usage: loadstring(httpget("https://your-api.vercel.app/api/script"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("✅ Sole Hub loaded successfully!")
print("Player: " .. player.Name)

-- Buraya DarkUI ya da diğer kodlarını ekle
`

export default function handler(req, res) {
    // Roblox HttpGet User-Agent'ı kontrol et
    const userAgent = req.headers["user-agent"] || ""
    const isBrowser = userAgent.includes("Mozilla") && !userAgent.includes("Roblox")

    // Browser'dan request gelirse reddetme
    if (isBrowser || req.method !== "GET") {
        return res.status(403).json({ error: "Access denied" })
    }

    // Script döndür
    res.setHeader("Content-Type", "text/plain; charset=utf-8")
    res.status(200).send(scriptContent)
}
