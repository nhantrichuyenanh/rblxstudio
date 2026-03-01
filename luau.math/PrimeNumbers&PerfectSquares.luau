function Prime_Number(n)
	if n <= 1 then
		return false
	end
	for i = 2, math.floor(math.sqrt(n)) do
		if n % i == 0 then
			return false
		end
	end
	return true
end

function Perfect_Square(n)
	local root = math.floor(math.sqrt(n))
	return root * root == n
end

Primes = {}
PerfectSqaures = {}

for n = 1, 1000 do
	if Prime_Number(n) then
		table.insert(Primes, n)
	end
	if Perfect_Square(n) then
		table.insert(PerfectSqaures, n)
	end
end

print("Prime numbers:", Primes)
print("\nPerfect squares:", PerfectSqaures)