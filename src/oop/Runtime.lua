local MetadataTable = require "oop.MetadataTable"
local Runtime = {}

function Runtime.inherit(baseClass, derivedClassName)
    if type(derivedClassName) ~= "string" then
        error("invalid class name:" .. tostring(derivedClassName))
    end

    local derivedClass = setmetatable({}, baseClass)
    derivedClass.__index = derivedClass
    derivedClass:SetClassName(derivedClassName)
    MetadataTable.AddClass(derivedClass, derivedClassName)
    MetadataTable.AddInherit(derivedClass, baseClass)
    return derivedClass
end

return Runtime
