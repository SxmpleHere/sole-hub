local Root = script

local Theme = require(Root:WaitForChild("Utils"):WaitForChild("Theme"))
local Whitelist = require(Root:WaitForChild("Utils"):WaitForChild("Whitelist"))
local Window = require(Root:WaitForChild("Components"):WaitForChild("Window"))

local lib = {}
lib.__index = lib

lib.Theme = Theme
lib.Window = Window
lib.Whitelist = Whitelist

lib.new = function(config)
    return Window.new(config)
end
lib.New = lib.new

function lib:New(config)
    return Window.new(config)
end

return lib
