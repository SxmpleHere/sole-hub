local Whitelist = {}
Whitelist.__index = Whitelist

local function NormalizeUserIds(list)
    local normalized = {}

    for _, value in ipairs(list or {}) do
        local userId = tonumber(value)
        if userId then
            normalized[userId] = true
        end
    end

    return normalized
end

function Whitelist.new(config)
    config = config or {}

    local allowedUserIds = config.AllowedUserIds or config.Whitelist or {}
    local enabled = config.Enabled ~= false

    return setmetatable({
        Enabled = enabled,
        AllowedUserIds = NormalizeUserIds(allowedUserIds),
        Strict = config.Strict == true,
    }, Whitelist)
end

function Whitelist:IsAllowed(player)
    if not self.Enabled then
        return true
    end

    if not player then
        return false
    end

    return self.AllowedUserIds[player.UserId] == true
end

function Whitelist:Check(player)
    if not self.Enabled then
        return true
    end

    if self:IsAllowed(player) then
        return true
    end

    return false, "Access denied: player not in whitelist."
end

function Whitelist:Authorize(player)
    local allowed, reason = self:Check(player)
    if allowed then
        return true
    end

    warn(reason or "Access denied.")
    return false
end

return Whitelist
