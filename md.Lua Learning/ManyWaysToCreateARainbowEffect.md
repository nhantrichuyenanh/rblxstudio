## ◎ Why are there many ways to create a rainbow effect?

When scripting something in Luau, or programming in any language, a particular task can often be approached in several different ways, with each approach relying on specific APIs or programming concepts.

However, some tasks can be accomplished in many different ways, like creating a rainbow effect. If you've learned about colors in school, you may know that **a rainbow is made up of a continuous spectrum of colors rather than a single color**.

To recreate that effect in Roblox or any program, the color has to continuously transition through that spectrum, which is why **time is involved in determining the progression and duration of the transition**, and why there are **many ways to represent and control the continuous progression of color** through the spectrum, whether by using a clock, interpolating between colors, or using mathematical functions.

This tutorial assumes you've already learned the basics of `Color3`.

---

## ◎ Practical examples (time-based approaches)

All (*) examples in this tutorial use `local Part = script.Parent`, but the same logic applies to any Instance with a color property.

##### ● Time-based hue
```
local CycleDuration = 5 -- a full rainbow cycle lasts 5 seconds

while task.wait() do
	Part.Color = Color3.fromHSV(tick() % CycleDuration / CycleDuration, 1, 1)
end

--[[
time() is the most suitable here, os.clock() and tick() measure different kinds of time.
Even though tick() isn't deprecated, Roblox recommends newer time APIs like time() for new code.

You can replace while task.wait() do with RunService.Heartbeat:Connect() and it will still work.
]]
```
##### ● `workspace.DistributedGameTime`
```
local HueSpeed = 1/5 -- a full rainbow cycle lasts 5 seconds

while task.wait() do
	Part.Color = Color3.fromHSV((workspace.DistributedGameTime * HueSpeed) % 1, 1, 1)
end
```
##### ● Fixed hue increment
> A full rainbow cycle lasts around 4.25 seconds for both versions, depending on the timing of task.wait().
```
-- Version A
local hue = 0

while task.wait() do
	Part.Color = Color3.fromHSV(hue, 1, 1)

	hue += 1/255
	if hue >= 1 then hue = 0 end
end
```

```
-- Version B
while task.wait() do
	for i = 1, 255 do
		Part.Color = Color3.fromHSV(i/255, 1, 1)
		task.wait()
	end
end
```
##### ● Multiplied hue increment
```
local Speed = 4 -- a full rainbow cycle lasts roughly 4.2 seconds

while true do
	for i = 0, 1, 0.001 * Speed do
		Part.Color = Color3.fromHSV(i, 1, 1)
		task.wait()
	end
end
```
##### ● Elapsed time-based hue increment
> A full rainbow cycle lasts 4 seconds for both versions.
```
-- Version A
local CycleDuration = 4
local hue = 0

game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	Part.Color = Color3.fromHSV(hue, 1, 1)

	hue = (hue + deltaTime / CycleDuration) % 1
end)
```

```
-- Version B
local CycleDuration = 4
local StartTime = tick()

game:GetService("RunService").Heartbeat:Connect(function()
	local t = (tick() - StartTime) / CycleDuration

	Part.Color = Color3.fromHSV(t % 1, 1, 1)
end)
```

---

## ◎ Less ideal examples (interpolation approaches)

If you watch any YouTube tutorials, read any DevForum posts, or ask popular LLMs like ChatGPT, the most common solution you will find is the **time-based hue**, with some minor variations. In the Toolbox, however, they tend to be RGB-based and much more verbose.

##### ○ Tweened color sequence
```
while task.wait(0.5) do
	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(255, 0, 0)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(255, 155, 0)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(255, 255, 0)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(0, 255, 0)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(0, 255, 255)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(0, 155, 255)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(255, 0, 255)}
	):Play()
	task.wait(0.5)

	game:GetService('TweenService'):Create(
		Part, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
		{Color = Color3.fromRGB(255, 0, 155)}
	):Play()
	task.wait(0.5)
end
```
##### ○ Tweened color sequence with a color table
```
local Colors = {
	Color3.fromRGB(255, 0, 0),     -- Red
	Color3.fromRGB(255, 128, 0),   -- Orange
	Color3.fromRGB(255, 255, 0),   -- Yellow
	Color3.fromRGB(0, 255, 0),     -- Green
	Color3.fromRGB(0, 0, 255),     -- Blue
	Color3.fromRGB(128, 0, 128),   -- Purple
}

while true do
	for i = 1, #Colors do
		local NextColor = Colors[i]
		
		local Tween = game:GetService("TweenService"):Create(Part, TweenInfo.new(
			2,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut
			), {Color = NextColor})
		
		Tween:Play()
		Tween.Completed:Wait()
	end
end
```
##### ○ Manual RGB interpolation
```
while true do
	Part.Color = Color3.new(255/255, 0/255, 0/255)

	for i = 0, 255, 10 do
		task.wait()
		Part.Color = Color3.new(255/255, i/255, 0/255)
	end
	for i = 255, 0, -10 do
		task.wait()
		Part.Color = Color3.new(i/255, 255/255, 0/255)
	end
	for i = 0, 255, 10 do
		task.wait()
		Part.Color = Color3.new(0/255, 255/255, i/255)
	end
	for i = 255, 0, -10 do
		task.wait()
		Part.Color = Color3.new(0/255, i/255, 255/255)
	end
	for i = 0, 255, 10 do
		task.wait()
		Part.Color = Color3.new(i/255, 0/255, 255/255)
	end
	for i = 255, 0, -10 do
		task.wait()
		Part.Color = Color3.new(255/255, 0/255, i/255)
	end
end
```

---

## ◎ Technical examples (mathematical approaches)

Throwback to the very first sentence of this tutorial: _“When scripting something in Luau, or programming in any language, [...]”_ Programmers have come up with all sorts of mathematical ways to create a rainbow effect. **They're pretty interesting to know about, even if you don't plan to use any of them.**
##### ⦿ Triangular Wave Hue
> I found this in Toolbox.
```
function ZigZag(x)
	return math.acos(math.cos(x * math.pi)) / math.pi
end

local t = 0

while task.wait(0.03) do
	Part.Color = Color3.fromHSV(ZigZag(t), 1, 1)
	t += .01
end
```
> Repeatedly moves the hue from 0 to 1 and back again, creating a repeating back-and-forth color cycle.
##### ⦿ Sinebow
```
https://basecase.org/env/on-rainbows
```

```
local function Sinebow(h)
	h = h + 1/2
	h = h * -1

	local r = math.sin(math.pi * h)
	local g = math.sin(math.pi * (h + 1 / 3))
	local b = math.sin(math.pi * (h + 2 / 3))

	return Color3.new(r * r, g * g, b * b)
end

game:GetService("RunService").Heartbeat:Connect(function()
	local hue = (os.clock() % 5) / 5
	Part.Color = Sinebow(hue)
end)
```
> Uses three sine waves with different phase offsets to generate the red, green, and blue components of each color.
##### ⦿ Piecewise linear RGB (6-segment rainbow)
```
https://www.icode.com/create-rgb-rainbow-gradient-with-programming-code/
```

```
local function Rainbow(x)
	local r = math.floor(x / 256)          -- 0-5
	local c = x % 256

	local red, green, blue

	if r == 0 then
		red, green, blue = 255, c, 0       -- red to yellow transition
	elseif r == 1 then
		red, green, blue = 255 - c, 255, 0 -- yellow to green transition
	elseif r == 2 then
		red, green, blue = 0, 255, c       -- green to cyan transition
	elseif r == 3 then
		red, green, blue = 0, 255 - c, 255 -- cyan to blue transition
	elseif r == 4 then
		red, green, blue = c, 0, 255       -- blue to magenta transition
	elseif r == 5 then
		red, green, blue = 255, 0, 255 - c -- magenta to red transition
	end

	return Color3.fromRGB(red, green, blue)
end

local Speed = 4
local x = 0 -- Accepts values 0 through 1535 and returns the one of 1536 colors in rainbow.

game:GetService("RunService").Heartbeat:Connect(function()
	Part.Color = Rainbow(x)

	x = (x + Speed) % 1536
end)
```
> Splits the color cycle into six linear RGB transitions, gradually changing one or two color channels at a time.
##### ⦿ Phase-shifted sinusoidal RGB
> `*` The only and last example that doesn't use Part. Use it on any Instance that has a Text property.
```
https://krazydad.com/tutorials/makecolors.php
```

```
local TextLabel = script.Parent

local function ColorText(str: string, phase: number?)
	phase = phase or 0

	local center = 128
	local width = 127
	local frequency = math.pi * 2 / #str

	local result = {}

	for i = 0, #str - 1 do
		local red = math.sin(frequency * i + 2 + phase) * width + center
		local green = math.sin(frequency * i + 0 + phase) * width + center
		local blue = math.sin(frequency * i + 4 + phase) * width + center

		table.insert(result, {
			char = string.sub(str, i + 1, i + 1),
			color = Color3.fromRGB(red, green, blue),
		})
	end

	return result
end

local function RainbowText(str: string, phase: number?): string
	local chars = ColorText(str, phase)
	local parts = {}

	for _, entry in chars do
		local hex = entry.color:ToHex()
		table.insert(parts, string.format('<font color="#%s">%s</font>', hex, entry.char))
	end

	return table.concat(parts)
end

TextLabel.RichText = true
TextLabel.Text = RainbowText(TextLabel.Text)
```
> Uses three phase-shifted sine waves to control the red, green, and blue channels independently, producing a smooth rainbow across the text.

---

## ◎ In my opinion

**Just use the first example.** Like I said before, the most common solution is the time-based hue. Even though you might never use any other examples, **it never hurts to learn for fun**, right?
