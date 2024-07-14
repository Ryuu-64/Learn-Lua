local InterfaceValidator = require "oop.lang.interface.InterfaceValidator"

---@class InterfaceImplements
local InterfaceImplements = {}

local function ErrorIfNot(interfaces)
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
        if not InterfaceValidator.is(interfaces[i]) then
            error("not a interface")
        end
    end
end

--function InterfaceImplements.implements(name, interfaces)
--    ErrorIfNot(interfaces)
--    return interface(name, interfaces)
--end

function InterfaceImplements.implements(interface, interfaces)
    ErrorIfNot(interfaces)
    interface._interfaces = interfaces
end

return InterfaceImplements
