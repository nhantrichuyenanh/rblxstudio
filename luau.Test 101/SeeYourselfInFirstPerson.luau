-- StarterCharacterScripts

-- initialize local variables
local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character.Humanoid

-- camera settings
player.CameraMode = Enum.CameraMode.LockFirstPerson
camera.FieldOfView = 100
humanoid.CameraOffset = Vector3.new(0, 0, -1)

-- set and keep every body part Transparency to its real transparency
for childIndex, child in pairs(character:GetChildren()) do
	if child:IsA("BasePart") and child.Name ~= "Head" then

		child:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			child.LocalTransparencyModifier = child.Transparency
		end)

		child.LocalTransparencyModifier = child.Transparency

	end
end

-- if the player steps in a vehicle
camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
	if camera.CameraSubject:IsA("VehicleSeat") then
		camera.CameraSubject = humanoid
	end
end)