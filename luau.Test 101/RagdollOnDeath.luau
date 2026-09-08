-- ServerScriptService

game:GetService("Players").PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		Humanoid.BreakJointsOnDeath = false
		
		local Motor6D = {}
		for _, v in ipairs(Character:GetDescendants()) do
			if v:IsA("Motor6D") then
				table.insert(Motor6D, v)
			end
		end
		
		Humanoid.Died:Connect(function()
			for i = 1, #Motor6D do
				local v = Motor6D[i]
				
				local A0 = Instance.new("Attachment")
				local A1 = Instance.new("Attachment")
				A0.Parent = v.Part0
				A0.CFrame = v.C0
				A1.Parent = v.Part1
				A1.CFrame = v.C1
				
				local BallSocketConstraint = Instance.new("BallSocketConstraint")
				BallSocketConstraint.LimitsEnabled = true
				BallSocketConstraint.TwistLimitsEnabled = true
				BallSocketConstraint.UpperAngle = 90
				BallSocketConstraint.Parent = v.Parent
				BallSocketConstraint.Attachment0 = A0
				BallSocketConstraint.Attachment1 = A1
				
				v:Destroy()
			end
		end)
	end)
end)