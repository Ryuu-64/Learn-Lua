local keyword = require "oop.constant.keyword"
local ArgumentException = require "oop.exception.ArgumentException"

---@class InterfaceValidator
local InterfaceValidator = {}

function InterfaceValidator.is(interface)
    if interface == nil then
        return false
    end

    if interface._name == nil then
        return false
    end

    if interface._type ~= keyword.interface then
        return false
    end

    if interface._interfaces == nil then
        return false
    end

    if type(interface._interfaces) ~= "table" then
        return false
    end

    for i = 1, #interface._interfaces do
        if not InterfaceValidator.is(interface._interfaces[i]) then
            return false
        end
    end

    return true
end

function InterfaceValidator.GetException(interface)
    if interface == nil then
        return ArgumentException:new("interface is nil")
    end

    if interface._name == nil then
        return ArgumentException:new("interface._name is nil")
    end

    if interface._type ~= keyword.interface then
        return ArgumentException:new("interface._type is not 'interface'")
    end

    --region _interfaces

    if interface._interfaces == nil then
        return ArgumentException:new("interface._interfaces is nil")
    end

    if type(interface._interfaces) ~= "table" then
        return ArgumentException:new("interface._interfaces is not a table")
    end

    local reason = ""
    for i = 1, #interface._interfaces do
        local currInterface = interface._interfaces[i]
        local exception = InterfaceValidator.GetException(currInterface)
        if exception ~= nil then
            reason = reason ..
                "interface._interfaces[" ..
                i .. "] (" .. currInterface._name .. ") is not a valid interface: " .. exception.message .. "\n"
        end
    end

    if reason ~= nil then
        return ArgumentException:new(reason)
    end
    --endregion

    return nil
end

return InterfaceValidator
