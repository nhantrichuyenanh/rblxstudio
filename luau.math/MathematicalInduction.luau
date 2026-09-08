--[[
Mathematical induction has two conditions:
- Base Case: The statement is shown to be true for the initial value (usually 0 or 1).
- Inductive Step: The statement is shown to be true for a particular value, which means it is also true for the next consecutive value.
In this case, prove that the statement

P(n): 1 + 2 + 3 + ... + n = [n(n + 1)] / 2[n(n + 1)] / 2

is true for all n ∈ N* (positive natural numbers).
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
