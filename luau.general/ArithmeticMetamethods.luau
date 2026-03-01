local t1, t2 = {x = 4, y = 3},  {x = 5, y = 2}
local mt = {
	__unm = function(t)
		local ret = {}
		for k, v in t do
			ret[k] = -v
		end
		return ret
	end,
	
	__add = function(t1, t2)
		return {t1.x + t2.x; t1.y + t2.y}
	end,
	
	__sub = function(t1, t2)
		return {t1.x - t2.x; t1.y - t2.y}
	end,
	
	__mul = function(t1, t2)
		return {t1.x * t2.x; t1.y * t2.y}
	end,
	
	__div = function(t1, t2)
		return {t1.x / t2.x; t1.y / t2.y}
	end,
	
	__idiv = function(t1, t2)
		return {t1.x // t2.x; t1.y // t2.y}
	end,
	
	__mod = function(t1, t2)
		return {t1.x % t2.x; t1.y % t2.y}
	end,
	
	__pow = function(t1, t2)
		return {t1.x ^ t2.x; t1.y ^ t2.y}
	end,
	
	__eq = function(t1, t2)
		if t1.x == t2.x then
			return true
		elseif t1.y == t2.y then
			return true
		else return false end
	end,
	
	__lt = function(t1, t2)
		
	end,
	
	__le = function(t1, t2)
		
	end,
}
setmetatable(t1, mt) setmetatable(t2, mt)

local t = {
	unm = {-t1, -t2};
	add = t1 + t2;
	sub = t1 - t2;
	mul = t1 * t2;
	div = t1 / t2;
	idiv = t1 // t2;
	mod = t1 % t2;
	pow = t1 ^ t2;
	eq = t1 == t2;
}

print(t)