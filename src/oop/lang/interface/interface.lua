local keyword = require "oop.constant.keyword"

local interface = function(name, interfaces)
    local interface = {}
    interface._name = name
    interface._type = keyword.interface
    if interfaces == nil then
        interfaces = {}
    end
    interface._interfaces = interfaces
    return interface
end

return interface
