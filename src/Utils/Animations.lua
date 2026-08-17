local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent:WaitForChild("Theme"))

local Animations = {}

function Animations.OpenWindow(frame, targetBgTransparency)
    frame.GroupTransparency = 1
    frame.GroupColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 1

    local firstTween = TweenService:Create(frame, Theme.BezierHalf, {
        GroupTransparency = 0.5,
        BackgroundTransparency = targetBgTransparency,
    })
    firstTween:Play()

    firstTween.Completed:Connect(function()
        TweenService:Create(frame, Theme.BezierHalf, {
            GroupTransparency = 0,
            GroupColor3 = Color3.fromRGB(255, 255, 255),
        }):Play()
    end)
end

function Animations.CloseWindow(frame)
    local firstTween = TweenService:Create(frame, Theme.BezierHalf, {
        GroupTransparency = 0.5,
        GroupColor3 = Color3.fromRGB(0, 0, 0),
    })
    firstTween:Play()

    firstTween.Completed:Connect(function()
        local secondTween = TweenService:Create(frame, Theme.BezierHalf, {
            GroupTransparency = 1,
            BackgroundTransparency = 1,
        })
        secondTween:Play()

        secondTween.Completed:Connect(function()
            local screenGui = frame:FindFirstAncestorWhichIsA("ScreenGui")
            if screenGui then
                screenGui:Destroy()
            end
        end)
    end)
end

return Animations
