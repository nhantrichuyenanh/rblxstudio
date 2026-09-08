-- StarterCharacterScripts

local humanoid = script.Parent:WaitForChild("Humanoid")

game:GetService("RunService").RenderStepped:Connect(function()
	local currentTime = tick()
	if humanoid.MoveDirection.Magnitude > 0 then -- if you start walking
		local bobbleX = math.cos(currentTime * 10) * .25
		local bobbleY = math.abs(math.sin(currentTime * 10)) * .25        

		local bobble = Vector3.new(bobbleX, bobbleY, 0)

		humanoid.CameraOffset = humanoid.CameraOffset:lerp(bobble, .25)
	else -- if you stop walking
		humanoid.CameraOffset = humanoid.CameraOffset * .75
	end
end)