local ok, scriptCode = pcall(function()
    return game:HttpGet("https://sole-hub.vercel.app/api/script")
end)

if not ok or type(scriptCode) ~= "string" or scriptCode == "" then
    warn("Sole Hub fetch failed.")
    return
end

local fn, err = loadstring(scriptCode)
if not fn then
    warn("Failed to parse Sole Hub script:", err)
    return
end

fn()

print("Sole Hub example loaded successfully.")
