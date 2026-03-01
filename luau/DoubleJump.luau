local MaxJumps = 2
local JumpCooldown = 0.2

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local JumpAmount = 0
local CanPlayerJump = false

Humanoid.StateChanged:Connect(function(_, NewState)
	if Enum.HumanoidStateType.Landed == NewState then
		JumpAmount = 0
		CanPlayerJump = false
	elseif Enum.HumanoidStateType.Freefall == NewState then
		task.wait(JumpCooldown)
		CanPlayerJump = true
	elseif Enum.HumanoidStateType.Jumping == NewState then
		CanPlayerJump = false
		JumpAmount += 1
	end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if CanPlayerJump and JumpAmount < MaxJumps then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)