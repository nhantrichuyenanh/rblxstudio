-- M?t table có th? có metatable, 
-- nó s? nh?n n?p ch?ng m?t table khác.

f1 = {x = 1, y = 2}
f2 = {x = 5, y = 6}

-- S? sinh l?i n?u:  
-- s = f1 + f2
-- Vì không th? c?ng hai table.

-- T?o metatable.
my_meta = {} 
function my_meta.__add(a, b) 
	local ret = {}
	ret.x = a.x + b.y 
	ret.y = a.x - b.y
	return ret
end

-- Set protptype cho c? hai.
setmetatable(f1, my_meta)
setmetatable(f2, my_meta)

r1 = f1 + f2 -- G?i .__add(f1, f2) trong metatable c?a f1.
r2 = f2 + f1 -- Tuong t? luôn, metatable c?a f2.
print(r1.x, r1.y)   -- > 7   -5
print(r2.x, r2.y)   -- > 7   3

-- Hi?u don gi?n hon thì m?t table bình thu?ng,
-- ch? d? ch?a d? li?u mà thôi,
-- metatable thêm vào s? là b? ti?n x? lý cho nó.

-- Thêm table vào table thông qua key __index.
defaultFavs = {animal = 'dog', food = 'donuts'} 
myFavs = {food = 'pizza'} 
setmetatable(myFavs, {__index = defaultFavs}) 
eatenBy = myFavs.animal     -- > 'dog'

-- Giá tr? c?a __index, __add, .. du?c g?i là metamethod.
-- Full list, a là m?t table v?i m?t metamethod.
--[[
    __add(a, b)            cho a + b
    __sub(a, b)            cho a - b
    __mul(a, b)            cho a * b
    __div(a, b)            cho a / b
    __mod(a, b)            cho a % b
    __pow(a, b)            cho a ^ b
    __unm(a)               cho -a
    __concat(a, b)         cho a .. b
    __len(a)               cho #a
    __eq(a, b)             cho a == b
    __lt(a, b)             cho a < b
    __le(a, b)             cho a <= b
    __index(a, b)          <hàm ho?c m?t table> cho a.b
    __newindex(a, b, c)    cho a.b = c
    __call(a, ...)         cho a(...)
--]]