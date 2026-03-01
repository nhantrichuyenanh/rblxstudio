> Most tutorials on YouTube are outdated (using LegacyChatService), so I decided to make one  with updated methods (using TextChatService).
>
> ----
> **If you don't know why these steps are carried out, please watch/read scripting tutorials on YT/DevForum.**
------
>**1. Detecting Player joining/leaving:**
> Add a script in ServerScriptService. Here's the following code:
```
game:GetService("Players").PlayerAdded:Connect(function(Player)
	print(Player.Name, "has joined.")
end)

game:GetService("Players").PlayerRemoving:Connect(function(Player)
	print(Player.Name, "has left.")
end)

--> Or Player.DisplayName :)
--> You can test play and check the Output.
```
>**2. Setting up RemoteEvents for Player joining/leaving detection script:**
> Since we have PlayerAdded/Removing detection script, we can use a RemoteEvent to send data from Server (the script we added in ServerScriptService) to Client (where the Chat Message will be displayed).
>
>----
>- Add a Folder in ReplicatedStorage and name it as *PlayerEvents* (or however you like).
>- Add 2 RemoteEvent named *Joining* and *Leaving* (or again however you like) 
>- **I'll assume them as PlayerEvents, Joining & Leaving in this tutorial for better clarity and to avoid any confusion.**

>**3. Updating Player joining/leaving detection script:**
```
local PlayerEvents = game:GetService("ReplicatedStorage"):FindFirstChild("PlayerEvents")

game:GetService("Players").PlayerAdded:Connect(function(Player)
	PlayerEvents:FindFirstChild("Joining"):FireAllClients(Player)
end)

game:GetService("Players").PlayerRemoving:Connect(function(Player)
	PlayerEvents:FindFirstChild("Leaving"):FireAllClients(Player)
end)

--> FireAllClients for displaying Chat Message to everyone.
```
>**4. Displaying Chat Message:**
> Add a LocalScript in StarterPlayerScripts. Here's the following code:
```
local PlayerEvents = game:GetService("ReplicatedStorage"):FindFirstChild("PlayerEvents")

PlayerEvents:FindFirstChild("Joining").OnClientEvent:Connect(function(Player)
	game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(Player.Name.." has joined.")
end)

PlayerEvents:FindFirstChild("Leaving").OnClientEvent:Connect(function(Player)	
	game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(Player.Name.." has left.")
end)
 --> Or Player.DisplayName :)

--[[ Rich Text Support: 
<font color='#ffffff'>{Player.Name.. " has joined."}</font>`
More information at the end.
]]
```
>**5. More:**
> And that's it. It's done. Play on Client (not Studio) and it should work as intended.

>◆  Add a Sound that plays when *Joining* or *Leaving* is fired. 
> e.g. (Assuming Sound is parented under LocalScript.)

```
local PlayerEvents = game:GetService("ReplicatedStorage"):FindFirstChild("PlayerEvents")

PlayerEvents:FindFirstChild("Joining").OnClientEvent:Connect(function(Player)
	game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(Player.Name.." has joined.")
	script:FindFirstChildOfClass("Sound"):Play()
end)

PlayerEvents:FindFirstChild("Leaving").OnClientEvent:Connect(function(Player)	
	game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(Player.Name.." has left.")
	script:FindFirstChildOfClass("Sound"):Play()
end)
```

>◆  Customize text color, etc...
```
--> create.roblox.com/docs/ui/rich-text
```
Here's some I find useful.
![image|100x100](rbxassetid://14973619995)
![image|100x100](rbxassetid://14973621604)
![image|100x100](rbxassetid://14973623493)
![image|100x100](rbxassetid://14973625438)
![image|100x100](rbxassetid://14973627150)
----
>Feel free to leave your opinions and suggestions. If you have any inquiries, let me know!
>Thanks for reading my first tutorial  ☺️  (from 🇻🇳).
