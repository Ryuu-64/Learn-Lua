local DeepToString = {}

local DEFAULT_INDENT_COUNT = 2

local function FunctionDeepToString(self)
    local info = debug.getinfo(self, "uS")
    local paramLength = info.nparams
    local isVarArg = info.isvararg
    local params = {}
    for i = 1, paramLength do
        table.insert(params, "param" .. i)
    end
    if isVarArg then
        table.insert(params, "...")
    end

    --return string.format(formatString, table.concat(params, ", "))
    return string.format("function(%s)", table.concat(params, ", "))
end

--region table
local function GetTypePriority(value)
    local valueType = type(value)
    if valueType == "userdata" then
        return 4
    end

    if valueType == "function" then
        return 3
    end

    if valueType == "table" then
        return 2
    end

    return 1
end

local function TableMemberSorter(a, b)
    local priorityA = GetTypePriority(a.value)
    local priorityB = GetTypePriority(b.value)

    if priorityA ~= priorityB then
        return priorityA < priorityB
    end

    if type(a.field) == "userdata" or type(b.field) == "userdata" then
        return false
    else
        return a.field < b.field
    end
end

--- tostring(self) maybe nil when override __tostring
local function SafeToString(self)
    local selfToString = tostring(self)
    if selfToString == nil then
        return "nil"
    end

    return selfToString
end

local function YamlSafeToString(self)
    local selfToString = SafeToString(self)
    selfToString = string.gsub(selfToString, "table: ", "table:")
    return selfToString
end

--- @param self table
local function GetSortedTableMembers(self)
    local members = {}
    for k, v in pairs(self) do
        local kToString = tostring(k)
        if kToString == nil then
            kToString = "nil"
        end
        local vToString = tostring(v)
        if vToString == nil then
            vToString = "nil"
        end
        table.insert(members, { field = k, value = v })
    end

    table.sort(members, TableMemberSorter)
    return members
end

local function TryGetExistMember(table, variable)
    for i = 1, #table do
        local member = table[i]
        if variable == member.value then
            return member
        end
    end

    return nil
end

local function InternalTableDeepToString(field, value, indent, existMembers, TableDeepToString)
    local existMember = TryGetExistMember(existMembers, value)
    if existMember == nil then
        table.insert(existMembers, { field = field, value = value })
        return TableDeepToString(value, indent + DEFAULT_INDENT_COUNT, false, existMembers)
    else
        return ": " .. YamlSafeToString(value) .. " <nested:" .. tostring(existMember.field) .. ">\n"
    end
end

local function InternalOtherDeepToString(self, field, value)
    local string = ": "
    if field == "__index" and self == value then
        string = string .. "<self reference>"
    else
        string = string .. tostring(value)
    end
    string = string .. "\n"
    return string
end

local function MetaTableDeepToString(self, indent, existMembers, TableDeepToString)
    local deepToString = ""
    local getSelfMetatable = getmetatable(self)
    if getSelfMetatable ~= nil and getSelfMetatable ~= self then
        deepToString = deepToString .. string.rep(" ", indent) .. "metatable:"
        deepToString = deepToString .. TableDeepToString(
            getSelfMetatable, indent + DEFAULT_INDENT_COUNT, false, existMembers
        )
    end
    return deepToString
end

local function TableDeepToString(self, indent, isIndentSelf, existMembers)
    table.insert(existMembers, { field = "self", value = self })

    local childString = ""
    --region member
    local members = GetSortedTableMembers(self)
    for i = 1, #members do
        local member = members[i]
        local field = member.field
        local value = member.value
        local valueType = type(value)
        childString = childString .. string.rep(" ", indent) .. tostring(field)
        if valueType == "table" and value ~= self then
            childString = childString ..
                InternalTableDeepToString(field, value, indent, existMembers, TableDeepToString)
        elseif valueType == "function" then
            childString = childString .. ": " .. FunctionDeepToString(value) .. "\n"
        else
            childString = childString .. InternalOtherDeepToString(self, field, value)
        end
    end
    --endregion

    --region metatable
    childString = childString .. MetaTableDeepToString(self, indent, existMembers, TableDeepToString)
    --endregion

    local selfToString = ""
    --region self
    if isIndentSelf then
        selfToString = selfToString .. string.rep(" ", indent)
    end
    selfToString = selfToString .. "(" .. YamlSafeToString(self) .. ")"
    if childString ~= "" then
        selfToString = selfToString .. ":"
    end
    selfToString = selfToString .. "\n"
    --endregion

    return selfToString .. childString
end
--endregion

function DeepToString.of(self)
    if self == nil then
        return "nil"
    end

    local selfType = type(self)
    if selfType == "table" then
        return TableDeepToString(self, DEFAULT_INDENT_COUNT, false, {})
    end

    if selfType == "function" then
        return FunctionDeepToString(self)
    end

    return tostring(self)
end

return DeepToString
