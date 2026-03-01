local BadgeService = game:GetService("BadgeService")
local BadgeId = 0

script.Parent.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(hit.Parent.Name) then
		local Player = game.Players[hit.Parent.Name]
		BadgeService:AwardBadge(Player.UserId, BadgeId)
	end
end)
