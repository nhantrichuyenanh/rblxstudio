local Character = script.Parent or task.wait(5)

Character.Humanoid.Died:Connect(function()
	for _, v in pairs(Character:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = game.Workspace
		end
	end
	if game.Players[script.Parent.Name]:FindFirstChild("Backpack") then
		for _, v in pairs(game.Players[script.Parent.Name].Backpack:GetChildren()) do
			v.Parent = game.Workspace
		end
	end
end)