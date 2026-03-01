Hooktool #1:
script:game:GetService("Players").PlayerAdded:connect(function(player)
local function hookTool(tool)

Hooktool #2:
game:GetService("Players").PlayerAdded:connect(function(player)
local function hookTool(tool)
if not tool:IsA("Tool") then
return
end
game:GetService("RunService").Heartbeat:wait() tool.Parent = player.Character
end
player:WaitForChild("Backpack").ChildAdded:connect(hookTool)
player.ChildAdded:connect(function(child) if child:IsA("Backpack") then
child.ChildAdded:connect(hookTool) end end)
for i,v in pairs(player.Backpack:GetChildren()) do hookTool(v) end end)