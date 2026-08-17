local DarkUI = require(script.Parent.src)

local window = DarkUI:New({
    Name = "Sole Hub",
    Transparency = false,
})

local main = window:Section("Main")
local combat = window:Section("Combat")

local tabA = main:Tab("General")
tabA:Button({
    Name = "Hello",
    Callback = function()
        print("Button clicked")
    end,
})

tabA:Toggle({
    Name = "Enabled",
    Default = true,
    Callback = function(value)
        print("Toggle:", value)
    end,
})

local slider = tabA:Slider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 25,
    Increment = 5,
    Callback = function(value)
        print("Slider:", value)
    end,
})

local tabB = combat:Tab("Aim")
tabB:Button({
    Name = "Fov",
    Callback = function()
        print("Fov button")
    end,
})

window:Close()
