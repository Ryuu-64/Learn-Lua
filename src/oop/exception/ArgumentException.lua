local Exception = require "oop.exception.Exception"
local class = require "oop.lang.class.class"

---@class ArgumentException:Exception
---@field message string
local ArgumentException = class("ArgumentException", Exception)
return ArgumentException
