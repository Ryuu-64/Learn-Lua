--region  namespace
local function getVariableNameSpace()
    local info = debug.getinfo(1, "S")
    if info == nil then
        return nil
    end

    if info.source == nil then
        return nil
    end

    if info.source:sub(1, 1) ~= "@" then
        return nil
    end

    local source = info.source:sub(2)
    source = source:gsub("%.", "")
    source = source:gsub("\\", "/")
    source = source:match("(.+)/[^/]+$")
    source = source:gsub("/", "")
    return source
end

print(getVariableNameSpace())
--endregion
