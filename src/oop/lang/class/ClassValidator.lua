local keyword = require "oop.constant.keyword"

local ClassValidator = {}

function ClassValidator.Is(class)
    if class._name == nil then
        return false
    end

    if class._type ~= keyword.class then
        return false
    end

    if type(class._interfaces) ~= "table" then
        return false
    end

    return true
end

function ClassValidator.CanExtend(name, baseClass)
    if not ClassValidator.Is(baseClass) then
        return false, "Invalid base class, parameter must be Class"
    end

    if name == "Object" and baseClass ~= {} then
        return false, "Invalid runtime inherit, Object parent must be DummyClass"
    end

    if name ~= "Object" and baseClass == {} then
        return false, "Invalid runtime inherit, Class parent can't be DummyClass"
    end

    if type(name) ~= "string" then
        return false, "Invalid class name:" .. tostring(name)
    end

    if MetadataTable.HasTypeForName(name) then
        return false, "Class already exist, class name:" .. name
    end

    return true
end

return ClassValidator
