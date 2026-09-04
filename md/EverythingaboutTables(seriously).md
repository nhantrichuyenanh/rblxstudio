https://www.lualearning.org/tutorials/7c77db98-b155-4ac3-a252-0d6e5b3919b9/tables

❖  **Reason to read this tutorial**

In most, if not all tutorials, tables are taught in a theoretical sense like what is array vs dictionary and table operations like `table.insert`. Even Roblox's documentation approaches tables this way.
**All of them underplay the role of tables. You use it all the time, even if you don't realize it.**

**Read the description of this tutorial!** They're not just something you create yourself with `{}`. **Roblox APIs constantly return tables as you work with Instances, services, and data.**

```
print(type(workspace:GetChildren())) --> table
workspace.Baseplate --> indexing the Workspace Instance to get its "Baseplate" child, keep the word "indexing" in mind at the end of this tutorial
    -- or --
workspace["Baseplate"] --> same as workspace.Baseplate, same syntax as dictionary["key"]

--[[
Roblox Instances can have child Instances, forming a parent-child hierarchy.
GetChildren() returns an array-like table containing the Instance's direct children.
GetDescendants() returns an array-like table containing every descendant of the Instance.
]]
print(game:GetService("Lighting"):GetChildren(), workspace:GetDescendants())
--[[
Output:
▼ {
    [1] = Sky,
    [2] = SunRays,
    [3] = Atmosphere,
    [4] = Bloom,
    [5] = DepthOfField
}
▼ {
    [1] = Camera,
    [2] = Baseplate,
    [3] = Texture,
    [4] = Terrain,
    [5] = SpawnLocation,
    [6] = Decal
}
]]
```

---

❖ **Practical examples**

◆  **Dance Floor**
```
local Tiles = script.Parent:FindFirstChild("Tiles"):GetChildren() 

while task.wait(1) do
	for _, Tile in ipairs(Tiles) do -- ipairs because Tiles is an array.
		Tile.Color = Color3.new(math.random(), math.random(), math.random())
	end
end
```
◆  **Get Random Tool**
```
local Part = script.Parent

local ProximityPrompt = Instance.new("ProximityPrompt")
ProximityPrompt.ActionText = ""
ProximityPrompt.ClickablePrompt = false
ProximityPrompt.Exclusivity = 1
ProximityPrompt.HoldDuration = .5
ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
ProximityPrompt.MaxActivationDistance = 5
ProximityPrompt.Name = Part.Name
ProximityPrompt.ObjectText = ""
ProximityPrompt.RequiresLineOfSight = true
ProximityPrompt.Parent = Part

local Tools = game:GetService("ServerStorage"):FindFirstChild("Tools"):GetChildren()

ProximityPrompt.TriggerEnded:Connect(function(Player)
	Tools[math.random(1, #Tools)]:Clone().Parent = Player.Backpack
	Part:FindFirstChildOfClass("Sound"):Play()
end)

--[[
table[index] = value
table[math.random(1, #table)] = random value

The same method of picking a random value from an array also applies for a sky changer script, for example.
]]
```
◆  **Rotate Model**
```
local Speed = 1
local Rotation = 1
local Model = script.Parent:FindFirstChild("Parts")
local ModelCFrame = Model:GetModelCFrame()

function Rotate(model, paramCFrame)
	local BaseParts = {}

	for _, v in ipairs(model:GetChildren()) do
		if v:IsA("BasePart") then table.insert(BaseParts, v) end
	end

	for _, v in ipairs(BaseParts) do 
		v.CFrame = paramCFrame * ModelCFrame:ToObjectSpace(v.CFrame)
	end
end

while task.wait() do
	Rotation += (Speed/5)
	if Rotation > 360 then Rotation = 0 end
	Rotate(Model, ModelCFrame * CFrame.Angles(0, math.rad(Rotation), 0))
end
```
◆  **Data Storage / Saving Data**
```
--[[
DataStoreService is the simplest example and official way of saving data.
Adapted from GnomeCode's "Save Player Data with Roblox Datastores": youtu.be/H-cDbjd5-bs
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local Database = DataStoreService:GetDataStore("PlayerData")

-- A dictionary that keeps each player's data in memory while they are in the server.
local SessionData = {}

-- Load PlayerData from the DataStore.
Players.PlayerAdded:Connect(function(Player)
	local leaderstats = Instance.new("Folder", Player)
	leaderstats.Name = "leaderstats"
	
	local Coins = Instance.new("IntValue", leaderstats)
	Coins.Name = "Coins"
	
	local Success, PlayerData
	local Attempt = 1

	repeat
		Success, PlayerData = pcall(function()
			return Database:GetAsync(Player.UserId)
		end)
		Attempt += 1
	until Success or Attempt == 5
	
	if Success then
		-- No saved data means this is a new player, so give them default data.
		if not PlayerData then
			PlayerData = {
				Coins = 0
			}
		end

		-- Store the player's data in our SessionData dictionary.
		-- The player's UserId is the key, and their PlayerData table is the value.
		SessionData[Player.UserId] = PlayerData
	else
		Player:Kick("Your data couldn't be loaded.")
	end
	
	-- Get the player's Coins from their data table.
	Coins.Value = SessionData[Player.UserId].Coins

	-- Keep the data table updated whenever the leaderstat changes.
	Coins.Changed:Connect(function()
		SessionData[Player.UserId].Coins = Coins.Value
	end)
end)


-- Save PlayerData to the DataStore when a player leaves.
local function PlayerRemoving(Player)
	-- Only save if we successfully loaded data for this player.
	if SessionData[Player.UserId] then
		local Success, ErrorMessage
		local Attempt = 1

		repeat
			Success, ErrorMessage = pcall(function()
				Database:SetAsync(
					Player.UserId,
					SessionData[Player.UserId]
				)
			end)
			Attempt += 1
		until Success or Attempt == 5
	end
end

Players.PlayerRemoving:Connect(PlayerRemoving)


-- Save all players' data when the server shuts down.
game:BindToClose(function()
	if game:GetService("RunService"):IsStudio() then
		return
	end

	for _, Player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			PlayerRemoving(Player)
		end)
	end
end)

--[[
SessionData
[261]        PlayerData
               └── Coins = 100
[100022]     PlayerData
               └── Coins = 250
[14413460]   PlayerData
               └── Coins = 50
]]
```

---

❖ **Roblox services**

◆ **CollectionService**
```
--> From Dot Product's "STOP PUTTING SCRIPTS IN PARTS! | Roblox CollectionService Scripting Tutorial (2024)": youtu.be/80z3Xg8Sy_g

local CollectionService = game:GetService("CollectionService")

for _, part in CollectionService:GetTagged("KillBrick") do
	part.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") then
			hit.Parent.Humanoid.Health = 0
		end
	end)
end

-- Or you can use GetAttribute no need for CollectionService :P
```
◆ **Players** (Murder Mystery 2, Piggy, Flee the Facility, Hide and Seek Extreme)
```
local Players = game:GetService("Players")

local Maps = game:GetService("ServerStorage"):WaitForChild("Maps")
local MIN_PLAYERS, ROUND_TIME, INTERMISSION_TIME = 2, 120, 15

while true do
	-- Wait until there are enough players to start a round.
	repeat task.wait(1)
	until #Players:GetPlayers() >= MIN_PLAYERS

	-- Intermission
	for Time = INTERMISSION_TIME, 0, -1 do
		print("Round starting in:", Time)
		task.wait(1)
	end

	-- Pick a random map.
	local AvailableMaps = Maps:GetChildren()
	local Map = AvailableMaps[math.random(1, #AvailableMaps)]:Clone()
	Map.Parent = workspace

	local PlayersInRound = Players:GetPlayers()

	-- Pick one random player to be the Seeker.
	local Seeker = PlayersInRound[math.random(1, #PlayersInRound)]

	for _, Player in ipairs(PlayersInRound) do
		local Character = Player.Character

		if Character then
			if Player == Seeker then
				Player:SetAttribute("Role", "Seeker")
				Character:PivotTo(Map.SeekerSpawn.CFrame)
			else
				Player:SetAttribute("Role", "Hider")
				Character:PivotTo(Map.HiderSpawn.CFrame)
			end
		end
	end

	-- Run the round timer.
	for Time = ROUND_TIME, 0, -1 do
		task.wait(1)

		if Time % 10 == 0 then
			print("Time remaining:", Time)
		end
	end

	Map:Destroy()

	-- Players return to the lobby here.
end
```
◆ **GroupService**
```
local GroupService = game:GetService("GroupService")

local ADMIN_GROUP_ID = 1200769
local STAR_GROUP_ID = 4199740

game:GetService("Players").PlayerAdded:Connect(function(Player)
	local Groups = GroupService:GetGroupsAsync(Player.UserId)
	--[[ Assuming Player joined 5 groups.
	   ▼  {
    		[1] =  ▼  {
       		["EmblemId"] = 123456789,
       		["EmblemUrl"] = "http://www.roblox.com/asset/?id=123456789",
       		["Id"] = 123456789,
       		["IsInClan"] = false,
       		["IsPrimary"] = false,
       		["Name"] = "Example",
      		 ["Rank"] = 1,
       		["Role"] = "Fan"
    		},
    		[2] =  ▶ {...},
    		[3] =  ▶ {...},
    		[4] =  ▶ {...},
    		[5] =  ▶ {...},
		  } 
	]]

	for _, Group in ipairs(Groups) do
		if Group.Id == ADMIN_GROUP_ID then
			print(Player.Name, "is Roblox staff!")
			break
		elseif Group.Id == STAR_GROUP_ID then
			print(Player.Name, "is a Star Creator!")
			break
		end
	end
end)
```
◆ **MarketplaceService**
```
local MarketplaceService = game:GetService("MarketplaceService")

local Button = script.Parent
local Name = Button.NameLabel
local Price = Button.PriceLabel

local GAMEPASS_ID = 123456789

local GamePassInfo = MarketplaceService:GetProductInfoAsync(GAMEPASS_ID, Enum.InfoType.GamePass)

Name.Text = GamePassInfo.Name
Price.Text = utf8.char(0xE002).." "..GamePassInfo.PriceInRobux
Button.Image = "rbxthumb://type=GamePass&id=" .. GAMEPASS_ID .. "&w=150&h=150"

Button.Activated:Connect(function()
	MarketplaceService:PromptGamePassPurchase(
		game:GetService("Players").LocalPlayer,
		GAMEPASS_ID
	)
end)
```

---

❖ **They are really everywhere.**

◆  **ModuleScript** (a table that other scripts can use via `require()`)

```
-- TopbarPlus v3.4.0
local Icon = require(game:GetService("ReplicatedStorage").Icon)

local FPSIndicator = Icon.new():align("Right")
local Frames, Elapsed = 0, 0

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
	Frames += 1
	Elapsed += deltaTime

	if Elapsed >= 0.5 then
		FPSIndicator:setLabel(("%d FPS"):format(math.round(Frames / Elapsed)))
		Frames = 0
		Elapsed = 0
	end
end)
```

```
-- In one of my games, I have a lot of consumable tools that behave the same way.

-- ModuleScript:
local ConsumableTools = {}

local function ApplyGrip(Tool, Grip)
	Tool.GripForward = Grip.Forward
	Tool.GripPos = Grip.Position
	Tool.GripRight = Grip.Right
	Tool.GripUp = Grip.Up
end

function ConsumableTools.Activated(Tool, Config)
	local Enabled = true

	Tool.Activated:Connect(function()
		if not Enabled then return end
		Enabled = false

		ApplyGrip(Tool, Config.ActiveGrip)

		local Handle = Tool:FindFirstChild("Handle")
		local Sound = Handle and Handle:FindFirstChild(Config.SoundName or "DrinkSound")

		if Sound then Sound:Play() end

		task.wait(Config.ConsumeTime or 1)

		ApplyGrip(Tool, Config.IdleGrip)

		Enabled = true
	end)

	if Config.EquippedSoundName then
		Tool.Equipped:Connect(function()
			local Handle = Tool:FindFirstChild("Handle")
			local Sound = Handle and Handle:FindFirstChild(Config.EquippedSoundName)

			if Sound then Sound:Play() end
		end)
	end
end

return ConsumableTools

-- In a Tool's Script:
local ConsumableTools = require(game:GetService("ReplicatedStorage").ToolModules.ConsumableTools)
local Tool = script.Parent

ConsumableTools.Activated(Tool, {
	SoundName = "DrinkSound",
	EquippedSoundName = "OpenSound",
	ConsumeTime = 1.3,
	ActiveGrip = {
		Forward = Vector3.new(-1, 0, 0),
		Position = Vector3.new(-0.2, 0, -1.5),
		Right = Vector3.new(0, 0, -1),
		Up = Vector3.new(0, 1, 0),
	},
	IdleGrip = {
		Forward = Vector3.new(-1, 0, 0),
		Position = Vector3.new(0.25, 0, 0),
		Right = Vector3.new(0, 0, -1),
		Up = Vector3.new(0, 1, 0),
	},
})
```

> **ModuleScript adds another layer of abstraction.** If you write a lot of repetitive code that follows the same logic, then you might benefit from it, especially if you're making a complex game with multiple systems or work with other developers.
>ㅤ
> FYI: I'm just a hobbyist developer, so I intentionally keep my game architecture simple. **Adding more abstractions can sometimes make a project harder to understand and maintain**, so I only use them when they provide a clear benefit.
>ㅤ
> Just because professional developers on DevForum and YouTube frequently use these abstractions doesn't mean you need them for every project. Sometimes, a bit of duplication or a simple `for loop` is good enough.


◆ **Output** (yes you read that right)
```
local Player = game:GetService("Players").LocalPlayer

print(Player.Character.Humanoid.Health) --> attempt to index nil with 'Humanoid'
```

> Remember the word "indexing" at the start? It's basically accessing something using a key (`dictionary["key"]`). Pretty similar to indexing tables, huh? That's not all.

◆ **__index in OOP**
> At its core, OOP is built out of tables. `MobBehavior`, `Zombie`, and `Skeleton` are all tables created with `{}`.
```
local MobBehavior = {}

function MobBehavior:TakeDamage(amount)
	self.Health -= amount
end

function MobBehavior:MoveTo(position)
	print(self.Name .. " is moving to", position)
end


local Zombie = {
	Name = "Zombie",
	Health = 100,
}

local Skeleton = {
	Name = "Skeleton",
	Health = 75,
}

setmetatable(Zombie, {__index = MobBehavior})
setmetatable(Skeleton, {__index = MobBehavior})

Zombie:TakeDamage(20)
Skeleton:MoveTo(Vector3.new(0, 0, 0))
```
> `Zombie` and `Skeleton` don't actually contain `TakeDamage` or `MoveTo`. When Lua tries to index `Zombie` with `TakeDamage` and can't find it, `__index` tells it to look in `MobBehavior` instead. The same thing happens with `Skeleton`. **This lets many objects share the same methods without copying the same code into every object.**
>ㅤ
> Even though `Zombie` and `Skeleton` are tables, we think of them as objects, `TakeDamage` and `MoveTo` as methods, and `MobBehavior` as a prototype. These terms **abstract away the underlying tables** and **help us reason about what the code represents** without having to think about the tables themselves.
>ㅤ
> Sounds similar to ModuleScript? **OOP is another layer of abstraction.** It can make systems in a complex game easier to organize, but it also introduces more concepts and indirection. **If you're already dealing with a large codebase and/or working with many developers, that tradeoff is worth it.**
>ㅤ
> Again, like ModuleScript, adding more abstractions can sometimes make a project harder to understand and maintain. **This is an example of when not to use OOP**: (no disrespect to the poster)
```
devforum.roblox.com/t/how-to-make-a-simple-round-system-with-object-oriented-programming/3126614
```

---

❖ **Recap**

The reason why I wrote this tutorial is because most, if not all tutorials fail to emphasize the importance of tables. They introduce what tables are and what you can do with them, much like how school teaches a subject without really showing how often you'll actually encounter them in real development.

To be clear, I don't mean any disrespect toward the people who made those tutorials or the way subjects are taught in school. They're teaching the fundamentals, which are important.

I genuinely hope this tutorial gives you a new perspective on scripting in Roblox Studio, helps you feel more comfortable with abstractions, and makes advanced topics like metatables and OOP feel less intimidating.

Have a good day scripting!
