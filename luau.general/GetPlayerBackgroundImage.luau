-- https://devforum.roblox.com/t/getting-a-players-background-image/4809017

local function GetPlayerBackground(UserID : number)
	local BGID = game:GetService('Players'):GetProfileConfigurationFromUserIdAsync(UserID).BackgroundAssetId or 0
	local Background = game:GetService('InsertService'):LoadAsset(BGID):WaitForChild('AvatarBackground')
	local BackgroundImage = Background.ImageId.Value
	local BackgroundColor = Background.Color.Value
	
	Background:Destroy()

	return BackgroundImage, BackgroundColor
end
-- example: 
local BGid, BGColor = GetPlayerBackground(PLAYER.UserId)
PlaceholderImage.Image = 'rbxassetid://'..BGid
