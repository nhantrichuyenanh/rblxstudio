-- class không du?c tích h?p s?n (không nhu C++, Java...) 
-- Có nhi?u cách khác nhau d? t?o thông qua
--   vi?c s? d?ng table và metatable.
local newObj

Dog = {}                                -- 1.
function Dog:new()                      -- 2.
	newObj = {sound = 'woof'}           -- 3.
	self.__index = self                 -- 4.
	return setmetatable(newObj, self)   -- 5.
end

function Dog:makeSound()                -- 6.
	print('I say ' .. self.sound)
end

mrDog = Dog:new()                       -- 7.
mrDog:makeSound() -- > 'I say woof'     -- 8.

-- 1. Dog gi?ng nhu m?t class, nhung th?c ch?t là table.

-- 2. Hàm tablename:func(...) du?c hi?u nhu
--   hàm tablename.func(self, ...)
--   d?u hai ch?m : thêm self vào
--   thành tham s? th? nh?t.
--   Ð?c 7 & 8 bên du?i d? hi?u nó thêm nhu nào.

-- 3. newObj s? là instance m?i cho class Dog.

-- 4. self = class m?i t?o ra. Thông thu?ng
--   self = Dog, nhung ph?n k? th?a s? thay d?i nó.
--   newObj get các hàm t? chính nó nhung set
--   metatable c?a newObj và __index c?a nó
--   vào chính nó (Dog).

-- 5. Nên nh?: setmetatable s? return tham s? d?u.

-- 6. D?u hai ch?m : nhu trong m?c 2, nhung self này
--   có th? s? d?ng cho l?p con k? th?a thông qua Dog.new().

-- 7. Gi?ng nhu Dog.new(Dog), self = Dog trong new().
-- 8. Gi?ng nhu mrDog.makeSound(mrDog); self = mrDog.

----------------
-- Ví d? k? th?a.
----------------

LoudDog = Dog:new()                     -- 1.

function LoudDog:makeSound()
	local s = self.sound .. ' '               -- 2.
	print(s .. s)
end

seymour = LoudDog:new()                 -- 3.
seymour:makeSound() -- > 'woof woof'    -- 4.

-- 1. LoudDog l?y method & property t? Dog.

-- 2. B?n thân nó có key 'sound' t? hàm new().

-- 3. Gi?ng nhu LoudDog.new(LoudDog),
--   và du?c chuy?n thành Dog.new(LoudDog),
--   LoudDog không có key 'new', nhung nó có
--   __index = Dog trong metatable c?a nó (LoudDog).
--   K?t qu?: metatable c?a seymour là LoudDog, và
--   LoudDog.__index = LoudDog. Nên seymour.key s?
--   = seymour.key, LoudDog.key, Dog.key, b?t k?
--   table nào cung là cái d?u tiên v?i key nh?n du?c.

-- 4. Key 'makeSound' có s?n trong LoudDog, seymour k? th?a,
--   nó gi?ng nhu LoudDog.makeSound(seymour).

--   N?u c?n t?o thêm class con m?i, c?u trúc s? nhu sau:

function LoudDog:new()
	newObj = {} -- t?o newObj
	self.__index = self
	return setmetatable(newObj, self)
end