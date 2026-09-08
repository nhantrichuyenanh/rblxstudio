-- StarterPlayerScripts

local Players = game:GetService("Players")
local Client = Players.LocalPlayer

local Configurations = {
	USE_TEAM_COLOURS = true, 
	--> Player outlines will be based on team colours instead of the colours below if enabled.
	
	ALLY_FILL_COLOUR = Color3.fromRGB(131, 212, 255), 
	--> Fill colour for allies.
	ALLY_FILL_TRANSPARENCY = 0.4, 
	--> Fill transparency for allies.
	
	ALLY_OUTLINE_COLOUR = Color3.fromRGB(42, 163, 255), 
	--> Outline colour for allies.
	ALLY_OUTLINE_TRANSPARENCY = 0, 
	--> Outline transparency for allies.
	
	ENEMY_FILL_COLOUR = Color3.fromRGB(255, 82, 85), 
	--> Fill colour for enemies.
	ENEMY_FILL_TRANSPARENCY = 1, 
	--> Fill transparency for enemies.

	ENEMY_OUTLINE_COLOUR = Color3.fromRGB(208, 32, 32), 
	--> Outline colour for enemies.
	ENEMY_OUTLINE_TRANSPARENCY = 0, 
	--> Outline transparency for enemies.
}

local function ConfigureHighlight(HighlightObject, Player)
	if Player.Team == Client.Team then --> Player is an ally.
		HighlightObject.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		HighlightObject.FillTransparency = Configurations.ALLY_FILL_TRANSPARENCY
		HighlightObject.OutlineTransparency = Configurations.ALLY_OUTLINE_TRANSPARENCY
		
		if Configurations.USE_TEAM_COLOURS then
			HighlightObject.FillColor = Player.TeamColor.Color
			HighlightObject.OutlineColor = Player.TeamColor.Color
		else
			HighlightObject.FillColor = Configurations.ALLY_FILL_COLOUR
			HighlightObject.OutlineColor = Configurations.ALLY_OUTLINE_COLOUR
		end
	else --> Player is an enemy.
		HighlightObject.DepthMode = Enum.HighlightDepthMode.Occluded
		HighlightObject.FillTransparency = Configurations.ENEMY_FILL_TRANSPARENCY
		HighlightObject.OutlineTransparency = Configurations.ENEMY_OUTLINE_TRANSPARENCY
		
		if Configurations.USE_TEAM_COLOURS then
			HighlightObject.FillColor = Player.TeamColor.Color
			HighlightObject.OutlineColor = Player.TeamColor.Color
		else
			HighlightObject.FillColor = Configurations.ENEMY_FILL_COLOUR
			HighlightObject.OutlineColor = Configurations.ENEMY_OUTLINE_COLOUR
		end
	end
end

local function ApplyHighlight(player)
	local character = player.Character or player.CharacterAdded:Wait()

	local highlightObject = character:FindFirstChild("TEAM HIGHLIGHTER") or Instance.new("Highlight")
	highlightObject.Name = "TEAM HIGHLIGHTER"

	ConfigureHighlight(highlightObject, player)

	highlightObject.Parent = character
end

local function InitializeHighlight(player)
	if player == Client then
		return
	end

	if player.Character then
		ApplyHighlight(player)
	end

	player.CharacterAdded:Connect(function()
		ApplyHighlight(player)
	end)

	player:GetPropertyChangedSignal("Team"):Connect(function()
		ApplyHighlight(player)
	end)
end

Players.PlayerAdded:Connect(InitializeHighlight)

Client:GetPropertyChangedSignal("Team"):Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= Client then
			ApplyHighlight(player)
		end
	end
end)

for _, player in ipairs(Players:GetPlayers()) do
	InitializeHighlight(player)
end