repeat
	task.wait()
until game:IsLoaded()

local Player = game.Players.LocalPlayer
local Character = Player.Character

local Part = Instance.new("Part", Character)
Part.Anchored = true
Part.CanCollide = false

game:GetService("RunService").RenderStepped:Connect(function()
	game:GetService("TweenService"):Create(Part, TweenInfo.new(2, Enum.EasingStyle.Back), {CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 6)}):Play()
	workspace.CurrentCamera.CFrame = Part.CFrame
end)