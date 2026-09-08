local Player = game:GetService("Players").LocalPlayer

print(Player.AccountAge)
print(Player.AgeChecked)
print(game:GetService("GroupService"):GetGroupsAsync(Player.UserId))
local success, result = pcall(Player.GetFriendsOnlineAsync, Player)

if success then
	for _, friend in pairs(result) do
		print(friend)
	end
end