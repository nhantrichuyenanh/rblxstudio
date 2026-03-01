--[[
Phuong pháp quy n?p toán h?c có hai di?u ki?n sau:
1. Tru?ng h?p co b?n: M?nh d? du?c d? xu?t dúng so v?i giá tr? ban d?u (thu?ng là 0 ho?c 1).
2. Bu?c quy n?p: M?nh d? du?c d? xu?t dúng so v?i m?t giá tr? c? th? d?ng nghia v?i vi?c nó cung dúng cho giá tr? ti?p theo (k? ti?p).
Trong tru?ng hop này, ch?ng minh m?nh d? P = 1 + 2 + 3 + ... + n = [n * (n + 1)] / 2 dúng v?i ?n ?N*.
]]

--> Base Case
local Sum = 1  --> n = 1 (1)
local Expected_Sum = (1 * (1 + 1)) / 2 --> n = [n * (n + 1)] / 2 = 1
if Sum == Expected_Sum then --> (1) is correct.
	print("Base Case: True")
else
	print("Base Case: False")
end

--> Inductive Step
for k = 1, 10 do --> n = [1, 10] ?n ?N*.
	local Sum_k = (k * (k + 1)) / 2  --> n = k = 1
	local Sum_k1 = Sum_k + (k + 1)  --> n = k + 1 (2)
	local Expected_Sum_k1 = ((k + 1) * (k + 2)) / 2 --> n = k + 1 (3)
	local Results = {k}

	if Sum_k1 == Expected_Sum_k1 then --> (2) = (3)
		print("Inductive Step: True for n =", k)
	elseif Sum_k1 ~= Expected_Sum_k1 then
		print("Inductive Step: False for n =", k)
	end
end