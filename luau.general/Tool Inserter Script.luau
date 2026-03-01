local function giveGear(player, id)
	if (player.Character) then
		local m = game:GetService("InsertService"):LoadAsset(id)
		local t = m:FindFirstChildOfClass("Tool")
		if (t) then
			t.Parent = player.Character -- make them equip the item
		end
		m:Destroy() -- cleanup after
	end
end

giveGear(game:GetService("Players").LocalPlayer, ID)