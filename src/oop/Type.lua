local class = require "oop.lang.keyword.class"

---
---[Common Type System](https://learn.microsoft.com/en-us/dotnet/standard/base-types/common-type-system)
---
---[types](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types)
---
---@generic T:Object
---@class Type
---@field __index Type type it self
---@field __tostring fun(self:T):string
---@field _name string
---@field _type string
---@field _interfaces table
local Type = class("Type")

return Type
