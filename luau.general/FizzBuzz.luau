local Result = {}

for i = 1, 100 do --> i ? [1, 100] ? O(1)
	if i % 3 == 0 and i % 5 == 0 then
		table.insert(Result, "FizzBuzz")
	elseif i % 3 == 0 then
		table.insert(Result, "Fizz")
	elseif i % 5 == 0 then
		table.insert(Result, "Buzz")
	elseif i % 7 == 0 then
		table.insert(Result, "Bazz")
	else
		table.insert(Result, i)
	end
end

print(Result)