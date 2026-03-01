--[[
In Python, u can concat and merge 2 tables via .. and +
But in Luau, u can not. To do so, u have to use Metatable to achieve that
same for strings :/
]]
-- {} is both an array and dictionary
-- array has i, v (index, value) while dictionary has k, v (key, val)

local t1 = {
	x = 5; 
	y = 7
} --> two tables (t1 & t2)
local t2 = 
	{
	x = 1, 
	y = 3
	}

local mt = {
	__add = function(t1, t2) --> triggered when t1+t2
		return {t1.x + t2.x; t1.y + t2.y}
	end,
	__concat = function(t1, t2) --> t1..t2
		local ret = {}
		for i, v in pairs(t1) do
			table.insert(ret, v)
		end
		for i, v in pairs(t2) do
			table.insert(ret, v)
		end
		return ret
	end,
}
setmetatable(t1, mt) setmetatable(t2, mt)
print(t1+t2, table.concat(t1..t2, " ;")) --> check Output