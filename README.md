## [Lua Learning](https://devforum.roblox.com/t/lua-learning-official-website/496330)
Tutorials I've written since I was in 9th grade.
- [Player Joined/Left Message](md.Lua%20Learning/PlayerJoinedOrLeftMessage.md)
- [Tables In Practice](md.Lua%20Learning/TablesInPractice.md)
- [Many Ways to Create a Rainbow Effect](md.Lua%20Learning/ManyWaysToCreateARainbowEffect.md)

## Uncommon/rare idioms and patterns
I spent an ungodly amount of time reading Luau code.
- Multiple assignment: `local variable1, variable2 = value1, value2`
- Short-circuit evaluation: `local something = value1 and value2 or value3`
- Leading underscore variable: `local _unused = value`
- Global environment table: `_G`
- `WaitForChild()` with a timeout
- `do end` block
- `repeat until` block
- `continue`
- `assert()`
- `next()`
- `select()`
- `:Once()`

## Shortcuts
| Hotkey | Action |
| --- | --- |
| `F5` | Start Game |
| `Shift + F5` | Stop Game |
| `Ctrl + P` | Search Object/Script |
| `Ctrl + Alt + P` | Insert Script |
| `Ctrl + Alt + O` | Open Output Window |
| `Ctrl + Shift + R` | Rename Variable/Object |
| `Ctrl + Shift + D` | Duplicate Line |
| `Ctrl + D` | Multi-Select Next Match |
| `Ctrl + Shift + [` | Collapse Current Fold |
| `Ctrl + Shift + E` | Collapse All Folds |
| `Ctrl + E` | Expand All Folds |
| `Ctrl + Plus (+)` | Zoom In |
| `Ctrl + Minus (-)` | Zoom Out |
| `Ctrl + 0` | Reset Zoom |

## Bookmarks 
- DevForum:
    - [Data structures](https://create.roblox.com/docs/luau#data-structures)
    - [Coding concept - abstraction](https://create.roblox.com/docs/en-us/tutorials/fundamentals/coding-6/coding-concept-abstraction)
    - [Coding concept - algorithms](https://create.roblox.com/docs/en-us/tutorials/fundamentals/coding-6/coding-concept-algorithms)
    - [OpenTextChatService - Open-Source Implementation of TextChatService](https://devforum.roblox.com/t/opentextchatservice-open-source-implementation-of-textchatservice/3605944)
    - [Client CoreScripts GitHub Repository & Semi-Comprehensive Overview](https://devforum.roblox.com/t/client-corescripts-github-repository-semi-comprehensive-overview/296518)
    - [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide)
    - [Roblox Code Samples](https://create.roblox.com/store/models?creatorName=Roblox%20Code%20Samples)
    - [RoProxy.com - A free, rotating proxy for Roblox APIs](https://devforum.roblox.com/t/roproxycom-a-free-rotating-proxy-for-roblox-apis/1508367)
    - [`“Pls Donate” gamepass fetch method [OPEN-SOURCE]`](https://devforum.roblox.com/t/pls-donate-gamepass-fetch-method-open-source/4545260)
    - [Your Name Color in Chat — History and How It Works](https://devforum.roblox.com/t/your-name-color-in-chat-%E2%80%94-history-and-how-it-works/2702247)
    - [A guide to decorate your posts in forum!](https://devforum.roblox.com/t/a-guide-to-decorate-your-posts-in-forum/1762987)

## Creations
- [Testing Tools](https://www.roblox.com/games/6107155983/Testing-Tools)
- [Chillax](https://www.roblox.com/games/2689231458/Chillax)
- [roux land](https://www.roblox.com/games/6129595366/roux-land)
- [Coolin'](https://www.roblox.com/games/5376010497/Coolin)
- [Éclaircie](https://www.roblox.com/games/1696139323/claircie)
- [Test 101](https://www.roblox.com/games/6354289354/Test-101)
- [`[WB] my cringey game`](https://www.roblox.com/games/4806434866/my-cringey-game)

## [AI Assistant](https://create.roblox.com/docs/assistant)
```
Search for every SoundId that references any of the provided moderated asset IDs. Report every match with its full instance path. Report them to me and do not modify anything.
```
```
Review all Instance.new() call and verify that the final property assignment sets Instance.Parent, with Parent assigned only after all other properties. Report any violations with the script path and relevant code; do not modify anything.
```
```
Review all Scripts for opportunities to consolidate duplicate logic into a ModuleScript. Only suggest consolidation when three or more scripts use the exact same logic 1:1; do not code or modify anything, and include the script paths and duplicated logic.
```
```
Review all Scripts for pairs vs ipairs usage. Identify cases where the other iterator is more correct based on the table’s structure and intended behavior, and explain why; do not modify anything.
```
```
Review all Scripts for expensive operations inside loops, Heartbeat, Stepped, and RenderStepped. Report only cases that could meaningfully affect performance, with the script path and reason.
```
```
Review all Scripts for connections to events that may never be disconnected or cleaned up, especially temporary connections, character connections, and connections created repeatedly. Report the likely leak risk and script path; do not modify anything.
```
```
Review all Scripts and identify unnecessary abstractions or overhead, unnecessary defensive programming, and unnecessary single-use helper functions that could be simplified or inlined without changing behavior. Report only clear, meaningful cases, with the full script path, relevant code, and a concise explanation of why the pattern is unnecessary. Do not modify anything.
```
```
Review the entire DataModel for deprecated, legacy, or superseded APIs, classes, properties, and objects. Read the current official Roblox documentation before making any recommendations. Identify which deprecated/legacy systems should be preserved because replacing them could break behavior or compatibility, which are safe to modernize, and which should be monitored for future changes. Pay particular attention to legacy physics/movement objects such as BodyMovers. Report the full Instance/script path, relevant API/object, current documentation status, recommended action, and reason. Do not modify anything.
```

## Why?
- Programming/CS: Because it taught me client-server communication (`RemoteEvent`), modular programming (`ModuleScript`), object-oriented programming (`metatable`), event-driven programming (`RBXScriptSignal`), resource management (`RBXScriptConnection`/`:Disconnect()`), data persistence (`DataStoreService`), and concurrency (`task` library).
- Software engineering: Because it taught me [code organization](https://www.youtube.com/watch?v=waVoVpspazI "TheMyzta"), [code review](https://www.youtube.com/watch?v=wiZ4OQN43ns "Paul1Rb"), [type annotation](https://www.youtube.com/watch?v=gowHu-r-zXg "Crusherfire"), [debugging](https://www.youtube.com/watch?v=yOmPc2g8tbY "Roblox Learn"), and [version control](https://www.youtube.com/watch?v=IJDg6tRJmHo "Leif").
- Video game development: Because it taught me world building (`workspace`, `Lighting`), [gameplay systems](https://www.youtube.com/@DevBuildStudios/videos "DevBuild"), [UI development](https://www.youtube.com/playlist?list=PLQ1Qd31Hmi3Xnlu8u9hCYClLurMQYJIrz "BrawlDev"), input handling (`UserInputService`, `ContextActionService`), and [playtesting](https://www.youtube.com/watch?v=XpQaWyaMn_Y "Roblox Studio in a Minute").

It's what sparked my interest in programming.

## Philosophy
This is an addendum to my [Tables In Practice](md.Lua%20Learning/TablesInPractice.md). I've spent much of my junior high and high school years scripting using Luau, and I've noticed that programming is less concerned with individual instructions and more concerned with the design of systems, abstractions, and their interactions.
```
local Coin = workspace.Coin

Coin.Touched:Connect(function()
    Coin.Transparency = 1
    task.wait(3)
    Coin.Transparency = 0
end)
```
The code above directly specifies what happens when an event occurs. As programs become larger, directly managing every object and operation becomes increasingly difficult. Responsibility can instead be moved into the systems being created. For example, an object can manage its own resources.
```
local Coin = {}
Coin.__index = Coin

function Coin.new(position)
    local self = setmetatable({}, Coin)

    local coin = Instance.new("Part")
    coin.Name = "Coin"
    coin.Shape = Enum.PartType.Cylinder
    coin.Size = Vector3.new(0.6, 8, 4)
    coin.BrickColor = BrickColor.new("Gold")
    coin.Anchored = true
    coin.Position = position
    coin.Parent = workspace

    self.Instance = coin

    return self
end

function Coin:Destroy()
    self.Instance:Destroy()
end
```
Similar principles can be applied to event connections, resources, state, and other parts of a system. Instead of specifying every individual action, the programmer defines the relationships, responsibilities, and rules under which the system operates.

The programming language itself also reflects this principle.
> In a high-level language, you can often simply declare a variable or use an object without needing to describe how it is constructed internally.

> In a lower-level language, more of those mechanisms are exposed, so the programmer is more often responsible for defining the structures and abstractions that make those operations possible.
