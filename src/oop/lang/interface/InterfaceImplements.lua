local InterfaceValidator = require "oop.lang.interface.InterfaceValidator"
local ArgumentException = require "oop.exception.ArgumentException"
local ArgumentNilException = require "oop.exception.ArgumentNilException"

---@class InterfaceImplements
local InterfaceImplements = {}

local function Validate(interfaces)
    if interfaces == nil then
        return false
    end

    if type(interfaces) ~= "table" then
        return false
    end

    if #interfaces == 0 then
        return false
    end

    for i = 1, #interfaces do
        if not InterfaceValidator.is(interfaces[i]) then
            return false
        end
    end

    return true
end

local function InvalidReason(interfaces)
    if interfaces == nil then
        return ArgumentNilException:new("interfaces is nil")
    end

    if type(interfaces) ~= "table" then
        return ArgumentException:new("interfaces is not table")
    end

    if #interfaces == 0 then
        return ArgumentException:new("interfaces is empty")
    end

    local reason = ""
    for i = 1, #interfaces do
        if not InterfaceValidator.is(interfaces[i]) then
            reason = reason .. InterfaceValidator.reason(interfaces[i]).message
        end
    end
    return ArgumentException:new(reason)
end

function InterfaceImplements.implements(interface, interfaces)
    if not Validate(interfaces) then
        error(tostring(ArgumentException:new("implements failed", InvalidReason(interfaces))))
    end

    interface._interfaces = interfaces
end

return InterfaceImplements
