--|| VARIABLES ||-- 
local Player = game:GetService("Players").LocalPlayer
local Backpack = Player:WaitForChild("Backpack")
local CurrentCamera = workspace.CurrentCamera

local ScreenGui = script.Parent
local Hotbar = ScreenGui.Hotbar
local Inventory = ScreenGui.Inventory
local ToolSlot = script.ToolSlot
local InventoryHandler = require(script.InventoryHandler)

--|| FUNCTIONS ||-- 

--| SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR |--
local function ShowSlots()
	for index = 1, InventoryHandler.SlotAmount do
		local ToolObject = InventoryHandler.OBJECTS.Hotbar[index]
		if not ToolObject and not Hotbar:FindFirstChild(index) and index <= InventoryHandler.SlotAmount then
			local NewSlot = ToolSlot:Clone()
			NewSlot.ToolName.Text = ""
			NewSlot.ToolQuantity.Text = ""
			NewSlot.ToolNumber.Text = index
			NewSlot.Name = index
			NewSlot.Parent = Hotbar
		end
	end
end

--| ManageInventory() |-- 
local function RemoveEmptySlots()
	for index = 1, 9 do
		local ToolObject = InventoryHandler.OBJECTS.Hotbar[index]
		local ToolFrame = Hotbar:FindFirstChild(index)
		if not ToolObject and ToolFrame then
			ToolFrame:Destroy()
			if Hotbar:FindFirstChild(index) then
				RemoveEmptySlots()
			end
		end
	end
end

--| SETTINGS.INVENTORY_KEYBIND |-- 
local function ManageInventory(_, InputState)
	if InputState == Enum.UserInputState.Begin then
		Inventory.Visible = not Inventory.Visible
		local CurrentState = Inventory.Visible
		
		script:FindFirstChild("InventorySound"):Play()
		InventoryHandler:RemoveCurrentDescription()
		
		if CurrentState then 
			--> Visible
			ShowSlots()
		else
			--> Invisible
			if not InventoryHandler.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR then
				RemoveEmptySlots()
			end
		end
	elseif not InputState then
		for index = InventoryHandler.SlotAmount + 1, InventoryHandler.SlotAmount do
			local ToolObject = InventoryHandler.OBJECTS.Hotbar[index]
			local ToolFrame = Hotbar:FindFirstChild(index)
			if ToolObject then
				local Tool = ToolObject.Tool
				ToolObject:DisconnectAll()
				Tool:SetAttribute("ToolAdded", nil)
				InventoryHandler:NewTool(Tool)
			elseif ToolFrame then
				ToolFrame:Destroy()
			end
		end
	end
end

--| Inventory.SearchBox:GetPropertyChangedSignal("Text"):Connect() |-- 
local function SearchTool()
	InventoryHandler:SearchTool()
end

-- [ ⭐ ] -- 
local function NewTool(Tool)
	if Tool:IsA("Tool") then
		InventoryHandler:NewTool(Tool)
	end
end

--| Player.CharacterAdded:Connect() |-- 
local function ReloadInventory(Character)
	InventoryHandler.CurrentlyEquipped = nil
	Backpack = Player:WaitForChild("Backpack")

	for _, Tool in pairs(Backpack:GetChildren()) do
		if Tool:IsA("Tool") then
			NewTool(Tool)
		end
	end
	
	Backpack.ChildAdded:Connect(NewTool)
	Character.ChildAdded:Connect(NewTool)
end

-- [ CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect() ] -- 
local function UpdateHUDPosition()
	local HotbarOffset, InvOffset if game:GetService("RunService"):IsStudio() then HotbarOffset = 1.8 InvOffset = 47 elseif game:GetService("RunService"):IsClient() then HotbarOffset = 1.4 InvOffset = 27 end
	local ViewportSize = CurrentCamera.ViewportSize
	
	Hotbar.Position = UDim2.fromOffset(ViewportSize.X / 2, ViewportSize.Y - (Hotbar.Size.Y.Offset * HotbarOffset))
	Inventory.Size = UDim2.fromOffset(math.clamp(605, 100, ViewportSize.X - 200 >= 100 and ViewportSize.X - 200 or 100), math.clamp(312, 100, ViewportSize.Y - 100))
	Inventory.Position = UDim2.fromOffset(ViewportSize.X / 2, ViewportSize.Y - Hotbar.Size.Y.Offset - Inventory.Size.Y.Offset - InvOffset)
	Inventory.Frame.GridLayout.CellSize = UDim2.new(0, 60, 0, 60)
	ManageInventory()
end

--|| INITIALIZATION ||-- 
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
UpdateHUDPosition()
ReloadInventory(Player.Character or Player.CharacterAdded:Wait())
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateHUDPosition)
Player.CharacterAdded:Connect(ReloadInventory)
Inventory.SearchBox:GetPropertyChangedSignal("Text"):Connect(SearchTool)
if InventoryHandler.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR then ShowSlots() end

--> PC
if InventoryHandler.SETTINGS.INVENTORY_KEYBIND then
	game:GetService("ContextActionService"):BindAction("ManageInventory", ManageInventory, false, InventoryHandler.SETTINGS.INVENTORY_KEYBIND) 
end

--> Mobile
if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled and not game:GetService("UserInputService").MouseEnabled then
	InventoryHandler.SlotAmount = 5
end

local LOCK_SLOTS = InventoryHandler.SETTINGS.LOCK_SLOTS
local DRAG_OUTSIDE_TO_DROP = InventoryHandler.SETTINGS.DRAG_OUTSIDE_TO_DROP
local MouseButton1Click = {
	InventoryButton = function()
		ManageInventory(nil, Enum.UserInputState.Begin)
	end,
	SlotLockButton = function()
		LOCK_SLOTS = not LOCK_SLOTS
		InventoryHandler:LockSlots(LOCK_SLOTS)
	end,
	ToolDropButton = function()
		DRAG_OUTSIDE_TO_DROP = not DRAG_OUTSIDE_TO_DROP
		InventoryHandler:SetDragOutsideToDrop(DRAG_OUTSIDE_TO_DROP)
	end,
}

for _, v in pairs(script.Parent:FindFirstChild("MobileFrame"):GetChildren()) do
	if v:IsA("ImageButton") then
		v.MouseButton1Click:Connect(function()
			v:SetAttribute("IsPressed", not v:GetAttribute("IsPressed"))
			for k, f in pairs(MouseButton1Click) do
				if v.Name == k then
					f()
				end
			end
		end)
		v:GetAttributeChangedSignal("IsPressed"):Connect(function()
			if v.Name ~= "InventoryButton" then
				script:FindFirstChild("InventoryHandler"):FindFirstChild("SelectToolSound"):Play()
			end
			if v:GetAttribute("IsPressed") then
				v.Image = "rbxassetid://"..v:GetAttribute("ImagePressed")
			else
				v.Image = "rbxassetid://"..v:GetAttribute("Image")
			end
		end)
	end
end