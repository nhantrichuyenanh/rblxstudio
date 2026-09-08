-- StarterPlayerScripts

-- To Disable Shiftlock:
-- 1. Go To Properties of StarterPlayer
-- 2. Untick EnableMouseLockOption

local UserInputService = game:GetService('UserInputService')

local currentCameraConn, OnCustom

-- Ignore Mobile Players
if UserInputService.TouchEnabled then return end

-- On Camera Type Changed
local function OnCameraTypeChanged(newCameraType)
	if newCameraType == Enum.CameraType.Custom then
		if UserInputService.MouseBehavior == Enum.MouseBehavior.Default then
			UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
			UserInputService.MouseIconEnabled = false
			OnCustom = true
		end
		
	elseif UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		UserInputService.MouseIconEnabled = true
		OnCustom = false
	end
end

-- On New Camera
local function OnNewCamera()
	local currentCamera = workspace.CurrentCamera
	if currentCamera then
		if currentCameraConn then
			currentCameraConn:Disconnect()
		end
		local function OnCameraChange(prop)
			if prop == 'CameraType' then
				OnCameraTypeChanged(currentCamera.CameraType)
			end
		end
		currentCameraConn = currentCamera.Changed:Connect(OnCameraChange)
		OnCameraTypeChanged(currentCamera.CameraType)
	end
end

-- On Workspace Changed
local function OnWorkspaceChanged(prop)
	if prop == 'CurrentCamera' then
		OnNewCamera()
	end
end
workspace.Changed:Connect(OnWorkspaceChanged)

OnNewCamera()

-- Had an issue with exiting to explorer tab and then rejoining to Character. This should fix that issue!
while true do
	if OnCustom and UserInputService.MouseBehavior == Enum.MouseBehavior.Default then
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
	end
	task.wait(1)
end