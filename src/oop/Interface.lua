local Type = require "oop.constant.Type"

local Interface = {}

function Interface.is(interface)
    if interface._name == nil then
        return false
    end

    if interface._type ~= Type.INTERFACE then
        return false
    end

    if interface._interfaces == nil then
        return false
    end

    if type(interface._interfaces) ~= "table" then
        return false
    end

    return true
end

function Interface.implements(name, interfaces)
    if interfaces == nil then
        error("interfaces is nil")
    end

    if type(interfaces) ~= "table" then
        error("interfaces is not table")
    end

    if #interfaces == 0 then
        error("interfaces is empty")
    end

    for i = 1, #interfaces do
        if not Interface.is(interfaces[i]) then
            error("not a interface")
        end
    end

    local interface = {}
    interface._name = name
    interface._type = Type.INTERFACE
    interface._interfaces = interfaces
    return interface
end

return Interface
