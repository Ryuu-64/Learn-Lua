local keyword = require "oop.constant.keyword"
local ClassImplements = require "oop.lang.class.ClassImplements"
local InterfaceImplements = require "oop.lang.interface.InterfaceImplements"
local ArgumentException = require "oop.exception.ArgumentException"

local implements = {}

---@param type Type
function implements(type, interfaces)
    if type._type == keyword.class then
        return ClassImplements.implements(type, interfaces)
    end

    if type._type == keyword.interface then
        return InterfaceImplements.implements(type, interfaces)
    end

    error(tostring(ArgumentException:new("type invalid")))
end

return implements
