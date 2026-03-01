--> 1. Using a Set:
local Numbers = {1, 2, 3, 2, 4}
local Set = {}
local Duplicates = {}

for _, n in ipairs(Numbers) do
	if Set[n] then
		Duplicates[#Duplicates + 1] = n
	else
		Set[n] = true
	end
end

-------------------------------------------------------------------------
--> 2. Using Sorting:
local Numbers = {1, 2, 3, 2, 4}
table.sort(Numbers)

local Duplicates = {}
local Previous = nil

for _, n in ipairs(Numbers) do
	if n == Previous then
		Duplicates[#Duplicates + 1] = n
	else
		Previous = n
	end
end

-------------------------------------------------------------------------
--> 3. Using a Hash Map:
local Numbers = {1, 2, 3, 2, 4}
local Frequency = {}
local Duplicates = {}

for _, n in ipairs(Numbers) do
	Frequency[n] = (Frequency[n] or 0) + 1
	if Frequency[n] == 2 then
		Duplicates[#Duplicates + 1] = n
	end
end

-------------------------------------------------------------------------

if #Duplicates > 0 then
	print("Duplicates:", table.concat(Duplicates, ", "))
else
	print("No Duplicates found.")
end