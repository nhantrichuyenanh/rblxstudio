function Exponential(x)
	return 2^x - 4
end

local x = 0 --> Initial guess.

while math.abs(Exponential(x)) > 0.01 do --> Iterate until a close-enough solution is found.
	x = x - Exponential(x) / (2^x * math.log(2))  --> Newton-Raphson method.
end
print("^ x = "..x)

function Sine_Integral(x)
	local Sum = 0
	for i = 1, 1000 do  --> Approximate the integral using a finite sum.
		Sum = Sum + math.sin(i * x) / i
	end
	return Sum * x
end

local x = 0  --> Initial guess.
while math.abs(Sine_Integral(x) - 1) > 0.01 do  --> Iterate until the integral value is close to 1.
	x = x + 0.01  --> Adjusted for x.
end
print("sinZ x =", x)