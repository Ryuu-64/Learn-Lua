local keyword = require "oop.constant.keyword"
local Object = require "oop.Object"

---
---@class Exception:Object
---@field message string
---@field innerException Exception
local Exception = setmetatable({}, Object)
Exception.__index = Exception
Exception._name = "Exception"
Exception._type = keyword.class
Exception._interfaces = {}

function Exception:__tostring()
    return self._name ..
        "(message=" .. tostring(self.message) .. ", innerException=" .. tostring(self.innerException) .. ")"
end

function Exception:new(message, innerException)
    ---@type Exception
    local this = Object.new(self)
    this.message = message
    this.innerException = innerException
    return this
end

return Exception
