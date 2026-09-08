-- StarterPlayerScripts

local UserInputService = game:GetService("UserInputService")
local Player = game:GetService("Players").LocalPlayer

local CanWallJump = true

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end

	if input.KeyCode == Enum.KeyCode.Space then
		local InAir = Player.Character.Humanoid.FloorMaterial == Enum.Material.Air
		
		local Origin = Player.Character.PrimaryPart.Position -- HumanoidRootPart.Position
		local Direction = Player.Character.PrimaryPart.CFrame.LookVector

		local Wall = workspace:Raycast(Origin, Direction).Instance or nil
		
		if InAir and Wall and CanWallJump then
			CanWallJump = false

			Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

			-- TODO: add animation

			task.delay(0.2, function()
				CanWallJump = true
			end)
		end
	end
end)