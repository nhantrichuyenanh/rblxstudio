local BadgeID = ""

game.Players.PlayerAdded:Connect(function(Player)
    task.wait(1)
    if not game:GetService("BadgeService"):UserHasBadgeAsync(Player.UserId, BadgeID) then
         game:GetService("BadgeService"):AwardBadge(Player.UserId, BadgeID)
    end
end)