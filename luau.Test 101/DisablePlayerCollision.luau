-- ServerScriptService

local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

local GROUP_NAME = game:GetService("Players").Name

pcall(function() -- create the collision group if it doesn't exist
	PhysicsService:RegisterCollisionGroup(GROUP_NAME)
end)

-- Players in this group won't collide with each other
PhysicsService:CollisionGroupSetCollidable(GROUP_NAME, GROUP_NAME, false)

local function setCollisionGroup(character)
	for _, instance in ipairs(character:GetDescendants()) do
		if instance:IsA("BasePart") then
			instance.CollisionGroup = GROUP_NAME
		end
	end

	character.DescendantAdded:Connect(function(instance)
		if instance:IsA("BasePart") then
			instance.CollisionGroup = GROUP_NAME
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(setCollisionGroup)
end)