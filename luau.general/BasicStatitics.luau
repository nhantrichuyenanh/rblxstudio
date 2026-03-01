local Numbers = {4, 9, 1, 6, 2, 8, 3, 7, 5}
table.sort(Numbers)

local Min = Numbers[1]
local Max = Numbers[#Numbers]
local Sum = 0
for _, n in ipairs(Numbers) do
	Sum = Sum + n
end
local Average = Sum / #Numbers

local n = #Numbers
local Q2 = Numbers[math.ceil(n / 2)]
local Q1 = Numbers[math.ceil(n / 4)]
local Q3 = Numbers[math.ceil(3 * n / 4)]

local R = Max - Min
local DeltaQ = Q3 - Q1

local SquaredDeviations = 0
for _, n in ipairs(Numbers) do
	local Deviation = n - Average
	SquaredDeviations = SquaredDeviations + Deviation * Deviation
end
local Variance = SquaredDeviations / (n - 1)
local StandardDeviation = math.sqrt(Variance)

local Results = {
	"Minimum: "..Min;
	"Maximum: "..Max;
	"Average: "..Average;
	"Q1: "..Q1;
	"Q2 (Median): "..Q2;
	"Q3: "..Q3;
	"Range: "..R;
	"Interquartile Range (?Q): "..DeltaQ;
	"Variance (S²): "..Variance;
	"Standard Deviation (S): "..StandardDeviation;
}

print(Results)