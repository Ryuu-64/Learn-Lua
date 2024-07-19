local keyword = require "oop.lang.keyword"
local ClassImplements = require "oop.lang.class.ClassImplements"
local InterfaceImplements = require "oop.lang.interface.InterfaceImplements"
local ArgumentException = require "oop.exception.ArgumentException"

---
---@param type Type
---@param interfaces table<Interface>
---@return void
local implements = function(type, interfaces)
    if type._type == keyword.class then
        ClassImplements.implements(type, interfaces)
        return
    end

    if type._type == keyword.interface then
        InterfaceImplements.implements(type, interfaces)
        return
    end

    error(tostring(ArgumentException:new("type invalid")))
end

return implements
