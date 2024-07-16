local InterfaceValidator = require "oop.lang.interface.InterfaceValidator"
local ArgumentException = require "oop.exception.ArgumentException"
local ArgumentNilException = require "oop.exception.ArgumentNilException"

---@class InterfaceImplements
local InterfaceImplements = {}

local function IsValid(interfaces)
    if interfaces == nil then
        return false
    end

    if type(interfaces) ~= "table" then
        return false
    end

    for i = 1, #interfaces do
        if not InterfaceValidator.is(interfaces[i]) then
            return false
        end
    end

    return true
end

local function GetException(interfaces)
    if interfaces == nil then
        return ArgumentNilException:new("interfaces is nil")
    end

    if type(interfaces) ~= "table" then
        return ArgumentException:new("interfaces is not table")
    end

    local reason = ""
    for i = 1, #interfaces do
        if not InterfaceValidator.is(interfaces[i]) then
            reason = reason .. InterfaceValidator.GetException(interfaces[i]).message
        end
    end
    return ArgumentException:new("invalid implements parameters, reason: " .. reason)
end

function InterfaceImplements.implements(interface, interfaces)
    if not IsValid(interfaces) then
        error(tostring(GetException(interfaces)))
    end

    interface._interfaces = interfaces
end

return InterfaceImplements
