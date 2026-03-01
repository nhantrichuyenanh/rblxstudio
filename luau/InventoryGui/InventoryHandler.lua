local InventoryHandler = { 
	OBJECTS = {
		Hotbar = {};
		Inventory = {}
	}, 
	SETTINGS = {
		INVENTORY_KEYBIND = Enum.KeyCode.Backquote
		; --> KeyCode to open Inventory (set INVENTORY_KEYBIND to nil to disable Inventory).
		DRAG_OUTSIDE_TO_DROP = true
		; --> Drag any Tool outside of the Inventory or Hotbar to drop it.
		SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR = false
		; --> Displays all slots in the Hotbar whether empty or not.
		EQUIP_TOUCH_SENSITIVITY = 60
		; --> Speaks for itself.
		LOCK_SLOTS = false
		; --> Locks all NewSlot in Hotbar so they can't be equipped or unequipped.
		LOCK_SLOTS_POSITIONS = false
		; --> Locks all NewSlot.Position so they can't be dragged.
	},
	SlotAmount = 9
}

--|| PLAYER ||-- 
local Player = game:GetService("Players").LocalPlayer
local PlayerMouse = Player:GetMouse()

--|| INVENTORY ||-- 
local InventoryGui = script.Parent.Parent
local Hotbar = InventoryGui:FindFirstChild("Hotbar")
local Inventory = InventoryGui:FindFirstChild("Inventory")
local ToolSlot = script.Parent:FindFirstChild("ToolSlot")

--|| HOTBAR KEYBINDS ||-- 
local EnumKeys = {
	Enum.KeyCode.One,
	Enum.KeyCode.Two,
	Enum.KeyCode.Three,
	Enum.KeyCode.Four,
	Enum.KeyCode.Five,
	Enum.KeyCode.Six,
	Enum.KeyCode.Seven,
	Enum.KeyCode.Eight,
	Enum.KeyCode.Nine,
	Enum.KeyCode.Zero
}

--[[
	OBJECT-ORIENTED PROGRAMMING
		METATABLE OF TOOLOBJECT
]]--
local ToolObjectMetatable = {}
ToolObjectMetatable.__index = ToolObjectMetatable

--[[ 
	  METATABLE FUNCTIONS 
	TOOLOBJECT'S BEHAVIOR
]]--

--| Checks if Tool is equipped or otherwise. Triggered when NewSlot is selected or not. |--
function ToolObjectMetatable:IsEquipped()
	local Character = Player.Character

	if Character then
		return self.Tool.Parent == Player.Character
	else
		return false
	end
end

--[[
	Disconnects all ToolObject.ToolEvents
	Triggered when Tool is removed from Backpack and/or NewSlot is swapped.
]]--
function ToolObjectMetatable:DisconnectAll()
	for _, ToolEvent in pairs(self.ToolEvents) do
		ToolEvent:Disconnect()
	end
	
	if (Inventory.Visible or InventoryHandler.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR) and self.Frame.Parent ~= InventoryGui and self.Frame.Parent ~= Inventory.Frame then
		local ToolName = self.Frame:FindFirstChild("ToolName")
		local ToolQuantity = self.Frame:FindFirstChild("ToolQuantity")
		local ToolIcon = self.Frame:FindFirstChild("ToolIcon")

		if ToolName and ToolQuantity and ToolIcon then
			ToolName.Text = ""
			ToolQuantity.Text = ""
			ToolIcon.Image = ""
		end
	else
		self.Frame:Destroy()
	end

	if self.Parent == "Hotbar" and self.Position then
		game:GetService("ContextActionService"):UnbindAction(self.Position.."Hotbar")
		InventoryHandler.OBJECTS.Hotbar[self.Position] = nil
	elseif self.Parent == "Inventory" then
		InventoryHandler.OBJECTS.Inventory[self.Tool.Name] = nil
	end
	self = nil
end

--[[
	Updates Tool.TextureId
	Triggered when TextureIdChanged is fired, determining NewSlot's appearance.
]]
function ToolObjectMetatable:UpdateIcon()
	local Frame = self.Frame
	local TextureId = self.Tool.TextureId

	if TextureId == "" or TextureId == nil then
		Frame.ToolName.Visible = true
		Frame.ToolIcon.Visible = false
		Frame.ToolIcon.Image = ""
	else
		Frame.ToolName.Visible = false
		Frame.ToolIcon.Visible = true
		Frame.ToolIcon.Image = TextureId
	end
end

--| Triggered to determine NewSlot/DraggedSlot.Parent |--
function ToolObjectMetatable:GetParentInstance()
	return self.Parent == "Inventory" and Inventory.Frame or Hotbar
end

--[[ 
	Shows Tool.ToolTip
	Triggered when NewSlot is hovered.
]]-- 
function ToolObjectMetatable:ShowDescription()
	local ToolDescription = self.Tool.ToolTip
	local Frame = self.Frame
	if ToolDescription == "" then
		return
	end

	local DescriptionFrame = Instance.new("TextButton", InventoryGui)
	DescriptionFrame.Name = "DescriptionFrame"
	DescriptionFrame.AnchorPoint = Vector2.new(0.5, 0)
	DescriptionFrame.Font = Enum.Font.GothamMedium
	DescriptionFrame.TextSize = 14
	DescriptionFrame.TextStrokeTransparency = 0
	DescriptionFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
	DescriptionFrame.BorderSizePixel = 0
	DescriptionFrame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	DescriptionFrame.BackgroundTransparency = 0.75
	DescriptionFrame.ZIndex = 5
	DescriptionFrame.TextWrapped = true

	local UICorner = Instance.new("UICorner", DescriptionFrame)
	UICorner.CornerRadius = UDim.new(0.4, 0)

	local TextBounds = game:GetService("TextService"):GetTextSize(ToolDescription, DescriptionFrame.TextSize, DescriptionFrame.Font, Vector2.new(400, 1000)) + Vector2.new(10, 4)
	DescriptionFrame.Size = UDim2.new(0, TextBounds.X, 0, TextBounds.Y)
	DescriptionFrame.Position = UDim2.new(0, Frame.AbsolutePosition.X + (Frame.AbsoluteSize.X / 2), 0, Frame.AbsolutePosition.Y - TextBounds.Y - 2)
	DescriptionFrame.Text = ToolDescription
	self.DescriptionFrame = DescriptionFrame
end

--[[ 
	Hides Tool.ToolTip
	Triggered when NewSlot stops being hovered or is dragged.
]]-- 
function ToolObjectMetatable:RemoveDescription()
	if self.DescriptionFrame then
		self.DescriptionFrame:Destroy()
	end
end

--[[ 
	MODULESCRIPT FUNCTIONS
	LOCALSCRIPT'S FUNCTIONS
]]-- 

--| Hides Tool.ToolTip |-- 
function InventoryHandler:RemoveCurrentDescription()
	local DescriptionFrame = InventoryGui:FindFirstChild("DescriptionFrame")
	if DescriptionFrame then
		DescriptionFrame:Destroy()
	end
end

--| Enables Inventory.SearchBox |-- 
function InventoryHandler:SearchTool()
	script:FindFirstChild("SearchBarSound"):Play()
	local ToolName: string = Inventory.SearchBox.Text
	if ToolName == "" then
		for _, ToolObject in pairs(self.OBJECTS["Inventory"]) do
			ToolObject.Frame.Visible = true
		end
	elseif ToolName then
		for _, ToolObject in pairs(self.OBJECTS["Inventory"]) do
			ToolObject.Frame.Visible = string.find(ToolObject.Name:lower(), ToolName:lower()) and true or false
		end
	end
end

--[[ 
	Optional ModuleScript functions:
	• LockSlots(boolean)
	• LockSlotsPosition(boolean)
	• SetDragOutsideToDrop(boolean)
]]--

function InventoryHandler:LockSlots(boolean: boolean)
	self.SETTINGS.LOCK_SLOTS = boolean

	if boolean then
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid:UnequipTools()
		end
	end
end

function InventoryHandler:LockSlotsPosition(boolean: boolean) 
	self.SETTINGS.LOCK_SLOTS_POSITIONS = boolean
end

function InventoryHandler:SetDragOutsideToDrop(boolean: boolean)
	self.SETTINGS.DRAG_OUTSIDE_TO_DROP = boolean
end

--| ⭐ |--
function InventoryHandler:NewTool(Tool: Tool)
	if Tool:GetAttribute("ToolAdded") or not Tool:IsA("Tool") then
		return
	end

	local Length = 0
	for _, _ in pairs(InventoryHandler.OBJECTS.Hotbar) do
		Length += 1
	end

	InventoryHandler:AddTool(Tool, Length == self.SlotAmount and "Inventory" or "Hotbar", Tool:GetAttribute("Position"))
end

--|| 🌟 ||-- 
function InventoryHandler:AddTool(Tool: Tool, Parent: string, Position: number)

	--| POSITION |-- 
	Tool:SetAttribute("Position", nil)
	if Position == -1 then
		Parent = "Inventory"
		Position = nil
	end
	if not Position and Parent == "Hotbar" then
		for index = 1, self.SlotAmount do
			if self.OBJECTS.Hotbar[index] == nil then
				Position = index
				break
			end
		end
	end
	if Position and Hotbar:FindFirstChild(Position) then
		Hotbar:FindFirstChild(Position):Destroy()
	end

	--| VARIABLES |-- 
	local NewSlot = ToolSlot:Clone()
	local UIStroke = Instance.new("UIStroke", NewSlot)

	--| QUANTITY |-- 
	local Quantity = Tool:GetAttribute("Quantity") or 1
	if Quantity > 1 then
		NewSlot.ToolQuantity.Text = "x" .. Quantity
	end

	--| NEWSLOT & UISTROKE |-- 
	NewSlot.ToolName.Text = Tool.Name
	NewSlot.Parent = Parent == "Inventory" and Inventory.Frame or Hotbar
	NewSlot.Name = Parent == "Inventory" and Tool.Name or Position
	NewSlot.ToolNumber.Text = Parent == "Inventory" and "" or Position

	UIStroke.Color = Color3.fromRGB(64, 64, 64)
	UIStroke.Thickness = 1.65
	UIStroke.Transparency = 0.5
	UIStroke.Enabled = false
	
	--|| TOOLOBJECT ||-- 
	local ToolObject = {}
	setmetatable(ToolObject, ToolObjectMetatable)
	--| ToolObject contains Tool, NewSlot and all of their properties, while ToolObjectMetatable sets the methods for it. |--
	
	ToolObject.Tool = Tool
	ToolObject.Frame = NewSlot
	ToolObject.Parent = Parent
	ToolObject.Position = Position
	ToolObject.Name = Tool.Name
	self.OBJECTS[Parent][Position == nil and NewSlot.Name or Position] = ToolObject
	
	--[[ 
		SETTINGS.EQUIP_TOUCH_SENSITIVITY & game:GetService("ContextActionService"):BindAction()
		Triggered when NewSlot is selected.
	]]-- 
	local function ManageTool(_, InputState, InputObject)
		if InputObject and InputObject.UserInputType ~= Enum.UserInputType.Keyboard and InputObject.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		if
			not Humanoid
			or Humanoid.Health <= 0
			or not Tool.Parent
			or InputState == Enum.UserInputState.End
			or self.SETTINGS.LOCK_SLOTS
		then
			return
		end

		--| If Tool is equipped then it is unequipped. |-- 
		if ToolObject:IsEquipped() then
			Humanoid:UnequipTools()
			script:FindFirstChild("SelectToolSound"):Play()
			if not Tool.Enabled then
				UIStroke.Enabled = true
			else
				UIStroke.Enabled = false
			end
			NewSlot.Transparency = 0.65
			InventoryHandler.CurrentlyEquipped = nil
		--| If Tool is unequipped then it is equipped. |-- 
		elseif Tool.Enabled then
			Humanoid:EquipTool(Tool)
			script:FindFirstChild("SelectToolSound"):Play()
			UIStroke.Enabled = true
			NewSlot.Transparency = 0.5
			InventoryHandler.CurrentlyEquipped = NewSlot
		end
	end

	--[[ 
		ManageTool & ToolObject.ToolEvents.ToolRemoved
		Triggered when Tool is (un)equipped, determining CurrentlyEquipped and NewSlot's UIStroke appearance.
	]]-- 
	local function UpdateEquipped()
		if ToolObject:IsEquipped() and Tool.Enabled then
			InventoryHandler.CurrentlyEquipped = NewSlot
			NewSlot.Transparency = 0.5
			UIStroke.Enabled = true
		elseif ToolObject:IsEquipped() and not Tool.Enabled then
			InventoryHandler.CurrentlyEquipped = NewSlot
			NewSlot.Transparency = 0.5
			UIStroke.Enabled = true
		elseif not ToolObject:IsEquipped() and Tool.Enabled then
			InventoryHandler.CurrentlyEquipped = nil
			UIStroke.Enabled = false
			NewSlot.Transparency = 0.65
		elseif not ToolObject:IsEquipped() and not Tool.Enabled then
			InventoryHandler.CurrentlyEquipped = nil
			UIStroke.Enabled = true
			NewSlot.Transparency = 0.65
		end
		script:FindFirstChild("SelectToolSound"):Play()
	end

	--[[ 
		ManageTool & ToolObject.ToolEvents.EnabledChanged
		Triggered when EnabledChanged is fired, determining NewSlot's apperance.
	]]-- 
	local function UpdateEnabled()
		if Tool.Enabled then
			NewSlot.ImageTransparency = 0
			NewSlot.ToolIcon.ImageTransparency = 0
			NewSlot.ToolName.TextTransparency = 0
			NewSlot.ToolNumber.TextTransparency = 0
			NewSlot.ToolQuantity.TextTransparency = 0
			NewSlot.ToolQuantity.UIStroke.Transparency = 0
			NewSlot.ToolNumber.UIStroke.Transparency = 0
			NewSlot.ToolName.UIStroke.Transparency = 0
			UIStroke.Color = Color3.fromRGB(64, 64, 64)
			if ToolObject:IsEquipped() then
				NewSlot.Transparency = 0.5
				UIStroke.Enabled = true
			else
				UIStroke.Enabled = false
				NewSlot.Transparency = 0.65
			end
		elseif not Tool.Enabled then
			NewSlot.ImageTransparency = 0.35
			NewSlot.ToolIcon.ImageTransparency = 0.5
			NewSlot.ToolName.TextTransparency = 0.6
			NewSlot.ToolNumber.TextTransparency = 0.6
			NewSlot.ToolQuantity.TextTransparency = 0.6
			NewSlot.ToolQuantity.UIStroke.Transparency = 0.6
			NewSlot.ToolNumber.UIStroke.Transparency = 0.6
			NewSlot.ToolName.UIStroke.Transparency = 0.6
			UIStroke.Color = Color3.new(math.random(), math.random(), math.random())
		end
	end

	UpdateEnabled()
	UpdateEquipped()
	ToolObject:UpdateIcon()

	ToolObject.ToolEvents = {
		--| Fires when Tool.Enabled changes |--
		EnabledChanged = Tool:GetPropertyChangedSignal("Enabled"):Connect(UpdateEnabled);
		
		--| Fires when Tool is removed from Backpack. |--
		ToolRemoved = Tool.AncestryChanged:Connect(function(_, NewParent)
			if Player and (NewParent == nil or (NewParent ~= Player.Backpack and NewParent ~= Player.Character)) then
				ToolObject:DisconnectAll()
				Tool:SetAttribute("ToolAdded", false)
			end
			UpdateEquipped()
		end);
		
		--| Fires when Tool.Name changes. |--
		NameChanged = Tool:GetPropertyChangedSignal("Name"):Connect(function()
			NewSlot.ToolName.Text = Tool.Name
			ToolObject.Name = Tool.Name
		end);
		
		--| Fires when Tool.TextureId changes. |--
		TextureIdChanged = Tool:GetPropertyChangedSignal("TextureId"):Connect(function()
			ToolObject:UpdateIcon()
		end);
		
		--| Fires when Tool:GetAttribute("Quantity") changes. |--
		QuantityChanged = Tool:GetAttributeChangedSignal("Quantity"):Connect(function()
			Quantity = Tool:GetAttribute("Quantity") or 1
			if Quantity > 1 then
				NewSlot.ToolQuantity.Text = "x"..Quantity
			else
				NewSlot.ToolQuantity.Text = ""
			end
		end);
		
		--| Fires when NewSlot is hovered. |--
		MouseEnter = NewSlot.MouseEnter:Connect(function()
			if ToolObject.IsGrabbed then
				return
			end
			ToolObject:ShowDescription()
		end);
		
		--| Fires when NewSlot stops being hovered. |--
		MouseLeave = NewSlot.MouseLeave:Connect(function()
			ToolObject:RemoveDescription()
		end);

		-- [ 💫 ] -- 
		MouseGrab = NewSlot.MouseButton1Down:Connect(function()
			if self.SETTINGS.LOCK_SLOTS_POSITIONS then
				return
			end

			local GrabEnded
			local GrabMoved
			local DraggedSlot
			local CellSize = Inventory.Frame.GridLayout.CellSize
			ToolObject:RemoveDescription()

			-- [ 🌠 ] -- 
			GrabEnded = game:GetService("UserInputService").InputEnded:Connect(function(InputObject)
				if
					InputObject.UserInputType == Enum.UserInputType.MouseButton1
					or InputObject.UserInputType == Enum.UserInputType.Touch
				then
					GrabEnded:Disconnect()
					GrabMoved:Disconnect()
					ToolObject.IsGrabbed = false

					local SlotSwapped = false
					local DropTool = true

					--> DroppedSlot.Parent == Hotbar/Inventory ⇒ Slot is moved.
					for _, DroppedSlot in pairs(Player:WaitForChild("PlayerGui"):GetGuiObjectsAtPosition(PlayerMouse.X, PlayerMouse.Y)) do
						if DroppedSlot:IsA("ImageButton") and (DroppedSlot.Parent == Hotbar or DroppedSlot.Parent == Inventory.Frame) then
							local DroppedSlotObject = self.OBJECTS[DroppedSlot.Parent == Hotbar and "Hotbar" or "Inventory"][DroppedSlot.Parent == Hotbar and tonumber(DroppedSlot.Name) or DroppedSlot.Name]
							if DroppedSlotObject == ToolObject then
								DropTool = false
								if DraggedSlot then
									DraggedSlot:Destroy()
								end
								continue
							end

							--> Swap between slots.
							if DroppedSlotObject then
								SlotSwapped = true

								ToolObject:DisconnectAll()
								DroppedSlotObject:DisconnectAll()

								self:AddTool(DroppedSlotObject.Tool, Parent, Position)
								self:AddTool(Tool, DroppedSlotObject.Parent, DroppedSlotObject.Position)

								if DraggedSlot then
									DraggedSlot:Destroy()
								end

								--> HOTBAR
							elseif DroppedSlot.Parent == Hotbar then
								SlotSwapped = true

								ToolObject:DisconnectAll()
								self:AddTool(Tool, "Hotbar", tonumber(DroppedSlot.Name))
								if Parent == "Inventory" and DraggedSlot then
									DraggedSlot:Destroy()
								end
								DroppedSlot:Destroy()
							end

							if DroppedSlotObject then
								DroppedSlotObject:RemoveDescription()
							end
							if ToolObject then
								ToolObject:RemoveDescription()
							end

							--> INVENTORY
						elseif DroppedSlot:IsA("ImageLabel") and DroppedSlot == Inventory and not SlotSwapped and Parent == "Hotbar" then
							SlotSwapped = true
							ToolObject:DisconnectAll()
							self:AddTool(Tool, "Inventory")
							self:SearchTool()
							break
						end
					end

					--> DroppedSlot.Parent == nil ⇒ Tool is dropped.
					if not SlotSwapped then
						if DraggedSlot then
							DraggedSlot:Destroy()
						end
						NewSlot.Parent = ToolObject:GetParentInstance()
						if InventoryHandler.SETTINGS.DRAG_OUTSIDE_TO_DROP and DropTool and Tool.CanBeDropped then
							local Character = Player.Character
							if Character then
								Tool.Parent = Character
								game:GetService("RunService").RenderStepped:Wait()
								Tool.Parent = workspace
								--> If anyone knows how to make SETTINGS.DRAG_OUTSIDE_TO_DROP work without the use of WorldPivot, hit me up via DevForum. <3
								--> Deleting the line below this one will render SETTINGS.DRAG_OUTSIDE_TO_DROP essentially useless.
								Tool.WorldPivot += CFrame.new(0, 0, 0)
							end
						end

						if (NewSlot.AbsolutePosition - Vector2.new(PlayerMouse.X, PlayerMouse.Y)).Magnitude <= InventoryHandler.SETTINGS.EQUIP_TOUCH_SENSITIVITY then
							ManageTool()
						end
					end
				end
			end)

			-- [ 💫 ] -- 
			GrabMoved = PlayerMouse.Move:Connect(function()
				if not ToolObject.IsGrabbed then
					ToolObject.IsGrabbed = true

					-- [ ✨ ] -- 
					DraggedSlot = ToolSlot:Clone()
					DraggedSlot.Transparency = 1
					DraggedSlot.ToolName.Text = ""
					DraggedSlot.ToolQuantity.Text = ""
					DraggedSlot.ToolNumber.Visible = false
					DraggedSlot.Name = NewSlot.Name
					DraggedSlot.Size = NewSlot.Size
					DraggedSlot.Parent = ToolObject:GetParentInstance()
					
					NewSlot.Size = CellSize
					NewSlot.Parent = InventoryGui
				end

				local MousePosition = Vector2.new(PlayerMouse.X, PlayerMouse.Y)
				NewSlot.Position = UDim2.new(0, MousePosition.X - (CellSize.X.Offset / 2), 0, MousePosition.Y - (CellSize.Y.Offset / 2))
			end)
		end)

	}

	Tool:SetAttribute("ToolAdded", true)
	--| Hotbar Keybinds
	if Parent == "Hotbar" and Position then
		game:GetService("ContextActionService"):BindAction(Position.."Hotbar", ManageTool, false, EnumKeys[Position])
	end
end

return InventoryHandler