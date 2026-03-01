function Perfect_Number(n)
	local sum_of_divisors = 0
	for i = 1, n - 1 do
		if n % i == 0 then
			sum_of_divisors += i
		end
	end
	return sum_of_divisors == n
end

function Search_Perfect_Numbers(lim)
	local perfect_numbers = {}
	for n = 2, lim - 1 do
		if Perfect_Number(n) then
			table.insert(perfect_numbers, n)
		end
	end
	return perfect_numbers
end

local limit = 10000
print(Search_Perfect_Numbers(limit))