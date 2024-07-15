---
--- when object is not define use this method
---
---@param class Type
---@return Object
local function instantiate(class)
    return setmetatable({}, class)
end

return instantiate
