local Character = script.Parent or task.wait(5)
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

game:GetService("RunService").RenderStepped:Connect(function()
    local CurrentTime = tick()
    if Humanoid.WalkSpeed >= 16 and Humanoid.Sit == false then
        if Humanoid.MoveDirection.Magnitude > 0 then
            local Bobble = Vector3.new(math.cos(CurrentTime * 10) * .35, math.abs(math.sin(CurrentTime * 10)) * .35, 0)
            -- Bobble (X, Y, 0)
            Humanoid.CameraOffset = Humanoid.CameraOffset:lerp(Bobble, .25)
        else
            Humanoid.CameraOffset = Humanoid.CameraOffset * .75
        end
    end
end)