-- StarterPlayerScripts

--[[ Scripted by coolcapidog
Channel ->> https://www.youtube.com/c/coolcapidog
]]
repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local part = Instance.new("Part", character)
part.Transparency = 1
part.Anchored = true
part.CanCollide = false

local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera

runService.RenderStepped:Connect(function()
	local tween = tweenService:Create(
		part,
		TweenInfo.new(2, Enum.EasingStyle.Back),
		{CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 6)})
	tween:Play()
	camera.CFrame = part.CFrame
end)