local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Theme = require(script.Parent:WaitForChild("Theme"))

local Drag = {}

function Drag.Attach(frame, handle)
    local dragging = false
    local dragInput
    local mousePos
    local framePos
    local dragTween

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            local goal = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)

            if dragTween then
                dragTween:Cancel()
            end

            dragTween = TweenService:Create(frame, Theme.BezierFast, { Position = goal })
            dragTween:Play()
        end
    end)
end

return Drag
