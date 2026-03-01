local Numbers = {1, 5, 2, 8, 3}
local Min = Numbers[1]
local Max = Numbers[1]
local Sum = 0

for _, n in ipairs(Numbers) do
	if n < Min then
		Min = n
	end
	if n > Max then
		Max = n
	end
	Sum = Sum + n
end

local Average = Sum / #Numbers
local Results = {
	"Minimum: "..Min;
	"Maximum: "..Max;
	"Average: "..Average;
}

print(Results)