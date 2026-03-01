>❖  **Prelude**
> This guide assumes you have little knowledge of tables.
> I highly recommend **you thoroughly read the comments in code blocks** for in-depth detail.
```
--[[  Reference Websites:
create.roblox.com/docs/luau/tables
create.roblox.com/docs/reference/engine/libraries/table
lua.org/pil/2.5.html
]]
```
>❖  **Reason**
> **to read this tutorial**
> During my self-learning, I read lots of DevForum topics and watched numerous tutorials on YouTube. **It's one thing to read and watch, but quite another to fully understand.** One of these is tables.
>----
> **Most of them underplay the role of tables.** The overemphasis on theory and little to no coverage of applications irked me. I write this tutorial in part to compensate just that.

>❖  **Disclaimer**
> **Tables are a complex and multifaceted topic**. Take for instance, *multi-dimensional array* (or matrix) and *Serialization*. I can't provide examples for them. Furthermore, there are too many applications for tables for me to cover them all.
>
>----
> Moreover, **they are objects**, stored in specific regions of memory and their references (or pointers) can only be manipulated. They can have multiple references, are created (not declared), and more. They're related to *Object-oriented programming*, which is a whole new ball game.
>
>----
>**Therefore, this tutorial will only cover the main and essential parts.**
------
## ❖  Theory
>◆  **Definition**
>**Tables are objects that can store multiple values.** They are a collection of data values (i.e.: numbers, strings, boolean, nil, functions, Roblox objects). 
> *With that, it opens the door to endless possibilities.*
>----
> Why are they a big deal? **Well, to put it bluntly, it's ubiquitous. It is a must-have.** Higher-order scripting makes use of large amounts of data, and that data often exists in the form of tables.
> *It may sound intimidating, especially when you barely know tables. However, once you read the entire guide, I'm confident you find tables indispensable.*

>◆  **Features**
>- You can retrieve, manipulate, add, and remove values from a table.
>- Those values can be *anything*, from **numbers, strings, userdata (Roblox objects and Services), tables (essentially a table in another table), and even functions**.
```
--> Values: number, string, objects, functions
local UserId, PlayerUsername, Players = 1, "Roblox", game:GetService("Players")
local function checkPlayerAmount() 
	print("Number of players in the server: "..#Players:GetPlayers())
end

--| try print(type()) the values above and check the Output
--> Tables are *constructed* in the form of curly brackets.
local t = {} --> A common reference name for a table.
print(type(t)) --> table
```
> Table is divided into two forms: **array and dictionary.**
> Constructing a table is as easy as pie. *Read the code blocks below and you'll get the hang of it.*

>- Array contains index and value (commonly written as **i**, **v**).
> 	◇  As aforementioned, table can contain values. 
> 	◇  **These values are associated by their order**, or in other words: index. 
> 	◇  Whether they're ordered through numerical order or unspecified will be mentioned later.
```
--> Format: local t = {v1, v2, v3, ..., vn}
local appurtenances = {"Real Estate", "Legal", "Household",  "Educational", "Financial"}
print(appurtenances)
--[[
Output: [1], [2], [3], [4], [5] are indices while "Real Estate", "Legal", "Household", "Educational", and "Financial" are values.
[1] = "Real Estate",
[2] = "Legal",
[3] = "Household",
[4] = "Educational",
[5] = "Financial"
]]
```
>- Dictionary, or associative array, contains key and value (commonly written as **k**, **v**).
>	◇  This time, **these values are associated by their keys**, which are sorted by alphabetical order.
>	◇  The key simply holds the value, to which it can be referred to retrieve the value.
```
--[[ Format:
local t = { --> Comma or semicolon to seperate each pair key-value.
	["k"] = v;
--| String key ["k"]
	k = v; --| Key k
	[p] = j; --| Variable value [p]
}
local t = {["k"] = v, k = v, [p] = j} --> Format can be like array.
]]
local timeline = { --> Numeric key [n]
	[2020] = "Introduction of Universal Windows Platform (UWP) Support, Roblox Education";
	[2021] = "Roblox IPO, Roblox Studio Improvements:";
	[2022] = "Introduction of Roblox Cloud, Advanced Scripting Capabilities";
	[2023] = "Roblox Metaverse Expansion, Enhanced Graphics and Rendering"
}
print(timeline)
--> Output: [2020], [2021], [2022], [2023] are keys while the strings are values.

--| Creating an associative array using the values from earlier; string key ["k"]
local PlayerInfo = {["UserId"] = UserId, ["PlayerUsername"] = PlayerUsername, ["Players"] = Players, ["checkPlayerAmount"] = checkPlayerAmount}
print(PlayerInfo) --[[ Output: sorts the keys by alphabetical order.
["PlayerUsername"] = "Roblox",
["Players"] = Players,
["UserId"] = 1,
["checkPlayerAmount"] = "function"
]]
```
>◆  Manipulation
> **Table's values can be modified**, just like variables with operators for numbers and properties for Roblox objects.
>
>----
>- Get, modify, add & remove value.
> It's just like variables but with a bit more typing. **Feel free to skip this part.**
```
--[[ Get:
Array: t[i]
Dictionary: t["k"] or t.k
In Lua(u), index starts at 1, unlike most programming languages which start at 0.
]]
print(appurtenances[2]) --> array with index
print(timeline[2023]) --> associative array with numeric key
print(PlayerInfo.checkPlayerAmount) --> function: [adress]
print(PlayerInfo.checkPlayerAmount()) --> Number of players in the server: number

--[[ Modify:
Array: t[i] = v
Dictionary: t["k"] = v or t.k = v
]]
appurtenances[1] = "Gardening"

--[[ Add:
table.insert(t, v) or table.insert(t, i, v) and t[#t + 1]
Functions from the table library. More on that later on.
]]
table.insert(PlayerInfo, 1000) --> table.insert(array, value); dictionary would work but value would be assigned with an index.
print(PlayerInfo) --[[ Output:
[1] = 1000,
["PlayerUsername"] = "Roblox",
["Players"] = Players,
["UserId"] = 1,
["checkPlayerAmount"] = "function"
]]

--[[ Remove:
table.remove(t, v) and t["k"] = nil or t.k = nil
Again, more on that later on.
]]
table.remove(PlayerInfo, 1) --> table.remove(array, index); table.remove(PlayerInfo, 2) doesn't work since there's no index 2 in dictionary PlayerInfo.
print(PlayerInfo) --[[ Output:
["PlayerUsername"] = "Roblox",
["Players"] = Players,
["UserId"] = 1,
["checkPlayerAmount"] = "function"
]]
```
>- **Iterate value.**
>	◇  Iteration is commonplace in Luau and is also the main way to **get a specific value or all of the values in a table**.
>	◇  For loop has two variables: **index or key and value.**
>	◇  **It's used extensively in table applications.**
```
--[[ Template:

--| Array:
for i, v in t do
	--> Two variables to employ.
	--| You can use if statement, modify value, or whatever you want depending on your project.
	print(i, v)
end
	-- or --
for i = 1, #t do
	--> If you want to simply loop the table from one to the length of the table, or #t
	print(i, t[i])
	--> t[i] = v as covered before.
end

--| Dictionary:
for k, v in pairs(t) do
	--| Since dictionary has key and value, for loop statement must be typed with two variables and pairs() or ipairs().
	--| pairs() returns key-value pairs while ipairs() returns index-value pairs:
	--> create.roblox.com/docs/tutorials/fundamentals/coding-5/pairs-and-ipairs
end
--| For loops variables can be modifed in any situation, making them flexible.
]]

for _, name in appurtenances do --> I don't need the order, just the name. Underscore does just that.
	if name == "Legal" then
		print("Getting legal advice...")
	end
end
for year, desc in pairs(timeline) do --> ipairs wouldn't work in this case.
	if year == 2021 then
		print(desc)
	end
end
```
>- **table.**

> **The table library has inbuilt functions, allowing us to manupulate tables.**
> **A lot of these functions aren't important to know anyways.** They're only useful for very specfic use cases, which I won't delve into  that.
>----
> *Not all table functions work both on array and associative array.*
```
--> create.roblox.com/docs/reference/engine/libraries/table

print(table.concat(appurtenances, "; ")) --> Real Estate; Legal; Household; Educational; Financial
print(table.unpack(timeline)) --> for array; unpack(t) = table.unpack(t)
table.clear(PlayerInfo) print(PlayerInfo) --> {}

local leaderboards = { --| array example with table values in which each one store two keys
	{Name = "Builderman", Score = 75},
	{Name = "Stickmasterluke", Score = 90},
	{Name = "Shedletsky", Score = 67},
	{Name = "Berezaa", Score = 49},
	{Name = "Gusmanak", Score = 88}
}

--> table.insert(array, value) or table.insert(dictionary, {key, value})
table.insert(leaderboards, {Name = "Cindering", Score = 50})

for i, participant in ipairs(leaderboards) do
	if participant.Score < 50 then
		table.remove(leaderboards, i)
		break
	end
end

table.sort(leaderboards, function(a, b) return a.Score > b.Score end)
--| try print(leaderboards) and check the Output

--> table.find(t, v, i) only works on arrays, etc...
```
----
## ❖  Practice
> **In Roblox Studio, everything is a table.** To remind you, table can store data values. In fact, everything in Roblox Studio is an *object*.
>
>----
>For example, in a brand new Baseplate experience, workspace is a table.
```
print(type(workspace)) --> userdata (aka object)
print(type(workspace:GetChildren())) --> table
workspace.Baseplate --> Baseplate is also userdata (which is also an object)
	-- or --
workspace["Baseplate"] --> same as workspace.Baseplate
Baseplate = workspace.Baseplate
Baseplate.Name = "idk" --> Modifying object's property. 
--| You get the idea.

print(game:GetService("Lighting"):GetChildren(), workspace:GetDescendants())
--[[ 
Every parent-child hierarchy is essentially an array, with its values are the children.
GetChildren() enables us to get all the children (or elements) in a table. An object's method.
GetDescendants() gets not just the elements but also the children of those elements.

Output:
▼  {
    [1] = Sky,
    [2] = SunRays,
    [3] = Atmosphere,
    [4] = Bloom,
    [5] = DepthOfField
    }  
▼  {
    [1] = Camera,
    [2] = Baseplate,
    [3] = Texture,
    [4] = Terrain,
    [5] = SpawnLocation,
    [6] = Decal
    }
]]
```
> The theoretical knowledge aims to explain and lay the foundations of tables, their features, and usages.
> **The following code blocks below bring those features and usages into play.**
◆  **Dance Floor**:
```
--| You can also use for loop statements for every KillPart if you want to.
local Tiles = script.Parent:FindFirstChild("Tiles"):GetChildren() 

while task.wait(1) do
	for _,Tile in pairs(Tiles) do
		Tile.Color = Color3.new(math.random(), math.random(), math.random())
		--> Assigning a variable with math.random() makes it a constant, meaning its value won't change.
		--> Since Dance Floor's tiles are intended to change color every second, I'd rather not use a variable.
	end
end
--> pairs() is optional for arrays.
```
◆  **Get Random Item**:
```
local ProximityPrompt = Instance.new("ProximityPrompt", script.Parent)
ProximityPrompt.Name = "ObtainTool"
ProximityPrompt.ObjectText = ""
ProximityPrompt.ActionText = ""
ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
ProximityPrompt.ClickablePrompt = false
ProximityPrompt.HoldDuration = 1.5
ProximityPrompt.Exclusivity = 1
ProximityPrompt.RequiresLineOfSight = true
ProximityPrompt.MaxActivationDistance = 5

local Items = game:GetService("ServerStorage"):FindFirstChild("Items"):GetChildren()

ProximityPrompt.TriggerEnded:Connect(function(Player)
	for i = 1, #Items do
		Items[math.random(i, #Items)]:Clone().Parent = Player.Backpack
			--[[
			The script loops through the Items folder and picks a random Item. How come?
			Remember t[i] = v? Well, t[math.random(i, #t)] = random v
			Why random v? Because from index 1 to the last index (which is the length of t or #t), math.random(1, #t) picks a random index, therefore t[math.random(i, #t)] = random v
			And v is just an item in this case, since item is value in table Items
			Essentially, a random item is cloned and then Parented under the Player's Backpack.
			]]
		script.Parent:FindFirstChildOfClass("Sound"):Play() --> This is optional.
	end
end)
--> The same method of picking random v also applies for Sky Changer.
```
◆  **Rotate Model**:
```
local Speed = 1
local Rotation = 1
local Model = script.Parent:FindFirstChild("Parts")
local ModelCFrame = Model:GetModelCFrame()
 --> const; assuming model stays in one place

function Rotate(model, paramCFrame)
	local BaseParts = {}
	local function FindBaseParts(array)
		for _, v in pairs(array:GetChildren()) do
			if v:IsA("BasePart") then
				table.insert(BaseParts, v) --> one use case of table.insert()
			end
			FindBaseParts(v) --> getting BasePart descendants in Model
		end
	end

	FindBaseParts(model)
	for _, v in pairs(BaseParts)do 
		v.CFrame = paramCFrame * ModelCFrame:ToObjectSpace(v.CFrame) --> actually rotating the model
	end
end

while task.wait() do
	Rotation += (Speed/5)
	if Rotation > 360 then Rotation = 0 end
	Rotate(Model, ModelCFrame * CFrame.Angles(0, math.rad(Rotation), 0))
end
```
◆  **Data Storage / Saving Data**:
```
--[[
DataStoreService is by far and away the simplest example and official way of saving data.
There are also DataStore2, ProfileService, and Suphi's DataStore Module, which are far superior to it. 
Besides those are Object Storage and Inventory System.
Each of them are a topic of their own. Look up on the DevForum or YouTube to know more.
This code block is a demonstration of how data storage works.

Adapted from GnomeCode's "Save Player Data with Roblox Datastores": youtu.be/H-cDbjd5-bs?si=ELs0mVZ1JIV350P8
]]
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local Database = DataStoreService:GetDataStore("PlayerData")
local SessionData = {} --> t; stores PlayerData while on session, aka playing.

--> Retrieving PlayerData from Database.
Players.PlayerAdded:Connect(function(Player)
	local leaderstats = Instance.new("Folder", Player)
	leaderstats.Name = "leaderstats"
	
	local Coins = Instance.new("IntValue", leaderstats)
	Coins.Name = "Coins"
	
	local Success, PlayerData
	local Attempt = 1
	repeat
		Success, PlayerData = pcall(function() --> Database:GetAsync(k) = p
			return Database:GetAsync(Player.UserId)
		end)
		Attempt += 1
	until Success or Attempt == 5
	
	if Success then
		if not PlayerData then --> Newbie, hence no pre-exisiting data to retrieve. Therefore, assign a default value.
			PlayerData = { --> p; self-explanatory.
				["Coins"] = 0; --> j
			}
		end
		SessionData[Player.UserId] = PlayerData --> t[k] = p
	else
		Player:Kick("Your data couldn't be loaded.")
	end
	
	Coins.Value = SessionData[Player.UserId].Coins --> IntValue.Value = t[k].j; updating PlayerData based on Database.
	Coins.Changed:Connect(function() --> When Int.Value changes, t[k].j updates.
		SessionData[Player.UserId].Coins = Coins.Value
	end)
end)

--> Saving PlayerData to Database.
function PlayerRemoving(Player)
	if SessionData[Player.UserId] then --> If t[k] then Database:SetAsync(k, t[k]) end
		local Success, ErrorMessage
		local Attempt = 1
		repeat
			Success, ErrorMessage = pcall(function()
				Database:SetAsync(Player.UserId, SessionData[Player.UserId])
			end)
			Attempt += 1
		until Success or Attempt == 5
	end
end

Players.PlayerRemoving:Connect(function(Player)
	PlayerRemoving(Player)
end)

--> Saving all Players' PlayerData to Database when server shuts down.
game:BindToClose(function()
	if game:GetService("RunService"):IsStudio() then 
		return --> When test playing in Studio.
	end
	for _, Player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			PlayerRemoving(Player)
		end)
	end
end)
```
◆   **Configuaration Settings**:
	◇  One example is **HD Admin**. If you've ever used it before, you most likely have opened *Settings* to configure admin powers.
	◇  Another one is **Warbound**. By opening Resource → SettingsModule → *ClientConfig* or *ServerConfig*, you can adjust the weapon's settings or animation.
	◇  ...
> This leads us to ModuleScript. Besides Scripts and LocalScripts, tables are mostly used in it. **In fact, ModuleScripts are another representation of tables, called packages or libraries.** If you insert a new one and open it, you'll be greeted by:
```
local module = {}

return module

```
>**In practically every high-level programming languages, you need libraries. They make them useful and applicable.**
>
>----
>*We can program bespoke libraries tailored for our desired needs*, whether making a game or a Community Resource on the DevForum.
>e.g: DataStore2, Roblox Weapons Kit, Satchel, TopbarPlus, etc...
>----
>There're heaps of ModuleScript tutorials and examples and they're all varying. More on that at the end.
> Speaking of libraries, check out Roblox Engine Libraries:
> *⇒ create.roblox.com/docs/en-us/reference/engine/libraries*
◆  **and so on...**
------
>❖  **Conclusion**
>**Tables are omnipresent in Lua(u).**
> It is an integral part of it, *simple yet so powerful*.
> I hope my code blocks have made you guys realize the true potential of tables and help gain know-how.
>----
> Learning it is a stepping stone.
> But to make the most out of it, you must not only know all the nitty-gritty details of it but apply it to pratical usages in Roblox Studio as well, aka making a full-fledge experience.
>----
> **If you have any suggestion or feedback, comment down below.** 💖 
> I'm sincerely sorry if some parts aren't well defined. If you need futher explanation, just comment and I'll try my best to help out. 💝