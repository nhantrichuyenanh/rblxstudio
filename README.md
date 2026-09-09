## [Lua Learning](https://devforum.roblox.com/t/lua-learning-official-website/496330)
- [Player Joined/Left Message](md/PlayerJoinedOrLeftMessage.md)
- [Tables In Practice](md/TablesInPractice.md)
- [Many Ways to Create a Rainbow Effect]

## Uncommon/rare idioms and patterns
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
    - [OpenTextChatService - Open-Source Implementation of TextChatService](https://devforum.roblox.com/t/opentextchatservice-open-source-implementation-of-textchatservice/3605944)
    - [Client CoreScripts GitHub Repository & Semi-Comprehensive Overview](https://devforum.roblox.com/t/client-corescripts-github-repository-semi-comprehensive-overview/296518)
    - [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide)
    - [Roblox Code Samples](https://create.roblox.com/store/models?creatorName=Roblox%20Code%20Samples)
    - [RoProxy.com - A free, rotating proxy for Roblox APIs](https://devforum.roblox.com/t/roproxycom-a-free-rotating-proxy-for-roblox-apis/1508367)
    - [`“Pls Donate” gamepass fetch method [OPEN-SOURCE]`](https://devforum.roblox.com/t/pls-donate-gamepass-fetch-method-open-source/4545260)
    - [Your Name Color in Chat — History and How It Works](https://devforum.roblox.com/t/your-name-color-in-chat-%E2%80%94-history-and-how-it-works/2702247)
    - [A guide to decorate your posts in forum!](https://devforum.roblox.com/t/a-guide-to-decorate-your-posts-in-forum/1762987)
 
## AI Assistant
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
