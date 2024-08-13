# Shapeshifter

Luau library built for Roblox which allows you to convert mesh files into `EditableMesh` instances. Only supports `Wavefront OBJ` currently.

```lua
local shapeshifter = require(...)
local file = [[
...
]]

local editableImage = shapeshifter.generateEditableMesh(file, "WavefrontOBJ")
```
