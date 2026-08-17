const scriptContent = `--// Sole Hub - Protected Script
--// Usage: loadstring(httpget("https://sole-hub.vercel.app/api/script"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("✅ Sole Hub loaded successfully!")
print("Player: " .. player.Name)

-- Buraya DarkUI ya da diğer kodlarını ekle
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
