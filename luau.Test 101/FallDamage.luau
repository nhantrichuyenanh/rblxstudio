-- ServerScriptService

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		local StartPosition
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")	

		Humanoid.StateChanged:Connect(function(oldState, NewState)
			if NewState == Enum.HumanoidStateType.Freefall then StartPosition = Character:WaitForChild("HumanoidRootPart").Position.Y

			elseif NewState == Enum.HumanoidStateType.Landed then
				if not StartPosition then return end
				local LandPosition = Character:WaitForChild("HumanoidRootPart").Position.Y
				if StartPosition < LandPosition then return end
				local DistanceFallen = (StartPosition - LandPosition)	

				Humanoid:TakeDamage(DistanceFallen)
			end
		end)
	end)	
end)