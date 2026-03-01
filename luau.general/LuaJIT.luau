local x = 0

--[[ wikiwand.com/en/LuaJIT#Internal_representation
	1e1 = 10
	1e2 = 100
	1e3 = 1000
]]--

for i = 1, 1e4 do
	x += 11
	if i % 10 == 0 then
		x += 22
	end
	x += 33
end

print(x)