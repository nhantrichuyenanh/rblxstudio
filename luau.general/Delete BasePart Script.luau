local trap = script.Parent

local function onTouch(objectTouched)
    print("Something touched the trap")
    -- Destroy the touching object
    objectTouched:Destroy()
end

trap.Touched:Connect(onTouch)