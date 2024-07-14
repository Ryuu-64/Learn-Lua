local keyword = require "oop.constant.keyword"
local MetadataTable = require "oop.lang.runtime.MetadataTable"
local Object = require "oop.Object"

local class = function(name, baseClass)
    --region create class
    local class = {}
    class.__index = class
    class._name = name
    class._type = keyword.class
    class._interfaces = {}
    MetadataTable.AddType(class, name)
    --endregion

    --region description
    if baseClass == nil then
        baseClass = Object
    end
    setmetatable(class, baseClass)
    if baseClass.__tostring ~= nil then
        class.__tostring = baseClass.__tostring
    end
    MetadataTable.AddParent(class, baseClass)
    --endregion

    return class
end

return class
