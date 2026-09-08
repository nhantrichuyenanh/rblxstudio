-- StarterCharacterScripts

local HumanoidRootPart = script.Parent:WaitForChild("HumanoidRootPart")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Debounce = false
local MouseDown = false

local MAX_DISTANCE, PULL_POWER = 100, 500
local RopeVisible = true
local RopeColor = BrickColor.new("New Yeller")

Mouse.Button1Up:Connect(function()
	MouseDown = false	
end)

Mouse.Button1Down:Connect(function()
	MouseDown = true
	
	if not Debounce then
		Debounce = true
		
		local HitPosition = Mouse.Hit.Position
		local Distance = (HitPosition - HumanoidRootPart.Position).Magnitude
		
		if Distance <= MAX_DISTANCE then
			local Part = Instance.new("Part")
			Part.Anchored = true
			Part.Transparency = 1
			Part.CanCollide = false
			Part.CastShadow = false
			Part.Position = HitPosition
			Part.Parent = workspace

			local Attachment1 = Instance.new("Attachment")
			Attachment1.Parent = Part

			local Attachment2 = Instance.new("Attachment")
			Attachment2.Parent = HumanoidRootPart

			local Rope = Instance.new("RopeConstraint")
			Rope.Attachment0 = Attachment1
			Rope.Attachment1 = Attachment2

			Rope.Length = Distance

			Rope.WinchEnabled = true
			Rope.WinchTarget = 3
			Rope.WinchSpeed = 80
			Rope.WinchForce = 10000
			Rope.WinchResponsiveness = 50

			Rope.Restitution = 0
			Rope.Visible = RopeVisible
			Rope.Color = RopeColor
			Rope.Parent = Part

			while MouseDown do
				task.wait()
			end

			Rope:Destroy()
			Attachment1:Destroy()
			Attachment2:Destroy()
			Part:Destroy()
		end
		
		Debounce = false
	end
end)