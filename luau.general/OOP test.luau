local Set = {}
Set.__index = Set

-- Function to construct a set from an optional list of items
function Set.new(items)
	local newSet = {}
	for key, value in items or {} do
		newSet[value] = true
	end
	return setmetatable(newSet, Set)
end

-- Function to add an item to a set
function Set:add(item)
	self[item] = true
end

-- Function to remove an item from a set
function Set:remove(item)
	self[item] = nil
end

-- Function to check if a set contains an item
function Set:contains(item)
	return self[item] == true
end

-- Function to output set as a comma-delimited list for debugging
function Set:output()
	local elems = {}
	for key, value in self do
		table.insert(elems, tostring(key))
	end
	print(table.concat(elems, ", "))
end

local fruits = Set.new({"Apple", "Lemon", "Orange", "Cherry", "Lime", "Peach"})
local fruits = Set.new({"Apple", "Lemon", "Orange", "Cherry", "Lime", "Peach"})
fruits:add("Mango")
local fruits = Set.new({"Apple", "Lemon", "Orange", "Cherry", "Lime", "Peach"})
fruits:remove("Orange")
local fruits = Set.new({"Apple", "Lemon", "Orange", "Cherry", "Lime", "Peach"})

local result1 = fruits:contains("Cherry")
print(result1) -- true

local result2 = fruits:contains("Watermelon")
print(result2) -- false
local function getIntersection(set1, set2)
	local result = Set.new()
	for key, value in set1 do
		if set2:contains(key) then
			result:add(key)
		end
	end
	return result
end

local freshFruits = Set.new({"Mango", "Lemon", "Orange", "Cherry", "Lime", "Peach"})
local frozenFruits = Set.new({"Mango", "Peach", "Pineapple"})

local commonFruits = getIntersection(freshFruits, frozenFruits)
commonFruits:output() -- Mango, Peach
function Set:__add(otherSet)
	local result = Set.new()
	for entry in self do
		result[entry] = true
	end
	for entry in otherSet do
		result[entry] = true
	end
	return result
end

local sweetFruits = Set.new({"Apple", "Mango", "Cherry", "Peach"})
local sourFruits = Set.new({"Lemon", "Lime"})

local allFruits = sweetFruits + sourFruits
allFruits:output() -- Peach, Lime, Apple, Cherry, Lemon, Mango
function Set:__sub(otherSet)
	local result = Set.new()
	for entry in self do
		result[entry] = true
	end
	for entry in otherSet do
		result[entry] = nil
	end
	return result
end

local allFruits = Set.new({"Apple", "Lemon", "Mango", "Cherry", "Lime", "Peach"})
local sourFruits = Set.new({"Lemon", "Lime"})

local sweetFruits = allFruits - sourFruits
sweetFruits:output() -- Mango, Apple, Cherry, Peach