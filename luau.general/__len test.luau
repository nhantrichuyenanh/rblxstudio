local t = {"string", 2, nil, true, {}}

local mt = {
	__len = function(t)
		local n = 0
		for _, _ in pairs(t) do
			n += 1
		end
		return n
	end
}
setmetatable(t, mt)

print(#t)  --> 4