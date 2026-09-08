-- StarterPlayerScripts

local IsXrayOn = false

game:GetService("UserInputService").InputBegan:Connect(function(InputObject, GameProcessedEvent)
	if GameProcessedEvent then return end
	
	if InputObject.KeyCode == Enum.KeyCode.X then
		IsXrayOn = not IsXrayOn
		for _, descendant in pairs(workspace:GetDescendants()) do
			if descendant:IsA("BasePart") then
				if IsXrayOn then
					if not descendant:FindFirstChild("OriginalTransparency") then
						local originalTransparency = Instance.new("NumberValue")
						originalTransparency.Name = "OriginalTransparency"
						originalTransparency.Value = descendant.Transparency
						originalTransparency.Parent = descendant
					end
					descendant.Transparency = 0.5	
				else
					descendant.Transparency = descendant.OriginalTransparency.Value
				end
			end
		end
	end
end)