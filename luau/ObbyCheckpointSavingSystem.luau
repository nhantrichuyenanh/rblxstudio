local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("ObbyDataStore")
local Checkpoints = game.Workspace:WaitForChild("Checkpoints"):GetChildren()

for i, checkpoint in pairs(Checkpoints) do
	checkpoint.TeamColor = game.Teams:FindFirstChild(checkpoint.Name).TeamColor
	checkpoint.BrickColor = game.Teams:FindFirstChild(checkpoint.Name).TeamColor
end

game.Players.PlayerAdded:Connect(function(player)
	local data
	local success, errorMessage = pcall(function()
		data = DataStore:GetAsync(player.UserId.."stage")
	end)
	if success then
		if data then
			player.Team = game.Teams[data]
		else
			player.Team = game.Teams.Stage1
		end
	else
		player.Team = game.Teams.Stage1
	end
	player:LoadCharacter()
end)

game.Players.PlayerRemoving:Connect(function(player)
	local success, errorMessage = pcall(function()
		DataStore:SetAsync(player.UserId.."stage", player.Team.Name)
	end)
end)