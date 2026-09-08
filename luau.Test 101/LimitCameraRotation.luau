-- StarterPlayerScripts

local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

RunService:BindToRenderStep(script.Parent.Name, Enum.RenderPriority.Camera.Value, function()
	local X, Y, Z = Camera.CFrame:ToOrientation()

	local limitX = math.clamp(math.deg(X), -45, 45)
	local limitY = math.clamp(math.deg(Y), -45, 45)

	Camera.CFrame = CFrame.new(Camera.CFrame.Position) * CFrame.fromOrientation(math.rad(limitX), math.rad(limitY), Z)
end)