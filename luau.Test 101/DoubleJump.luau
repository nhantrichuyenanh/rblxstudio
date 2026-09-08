-- StarterCharacterScripts

local UserInputService = game:GetService("UserInputService")
local character = script.Parent

local humanoid = character:WaitForChild("Humanoid")

local doubleJumpEnabled = false

humanoid.StateChanged:Connect(function(_oldState, newState)
	if newState == Enum.HumanoidStateType.Jumping then
		if not doubleJumpEnabled then
			task.wait(0.2)
			if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
				doubleJumpEnabled = true
			end
		end
	elseif newState == Enum.HumanoidStateType.Landed then
		doubleJumpEnabled = false
	end
end)

UserInputService.InputBegan:Connect(function(inputObject)
	if inputObject.KeyCode == Enum.KeyCode.Space then
		if doubleJumpEnabled then
			if humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				task.spawn(function()
					doubleJumpEnabled = false
				end)
			end
		end
	end
end)