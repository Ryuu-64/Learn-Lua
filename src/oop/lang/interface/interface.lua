﻿local keyword = require "oop.constant.keyword"

---@param name string
---@return Type
local interface = function(name)
    local interface = {
        _name = name,
        _type = keyword.interface,
        _interfaces = {}
    }

    return interface
end

return interface
