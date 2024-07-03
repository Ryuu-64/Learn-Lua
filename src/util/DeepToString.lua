local DeepToString = {}

local DEFAULT_INDENT = 4

local function FunctionDeepToString(self, formatString)
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

    return string.format(formatString, table.concat(params, ", "))
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

local function TableDeepToString(self, indent, isIndentSelf, existMembers)
    local string = ""

    if isIndentSelf then
        string = string .. string.rep(" ", indent)
    end

    table.insert(existMembers, { field = "self", value = self })

    local selfToString = tostring(self)
    -- tostring(self) maybe nil when override __tostring
    if selfToString == nil then
        selfToString = "nil"
    end
    string = string .. "(" .. selfToString .. ")" .. ":\n"

    local members = GetSortedTableMembers(self)
    for i = 1, #members do
        local member = members[i]
        local field = member.field
        local value = member.value
        local valueType = type(value)
        string = string .. string.rep(" ", indent) .. tostring(field)
        if valueType == "table" and value ~= self then
            local existMember = TryGetExistMember(existMembers, value)
            if existMember == nil then
                table.insert(existMembers, { field = field, value = value })
                string = string .. TableDeepToString(value, indent + DEFAULT_INDENT, false, existMembers)
            else
                string = ":" .. tostring(value) .. "(nested:" .. tostring(existMember.field) .. ")\n"
            end
        elseif valueType == "function" then
            string = string .. ":function" .. FunctionDeepToString(value, "(%s)") .. "\n"
        else
            string = string .. ":"
            if field == "__index" and self == value then
                string = string .. "(__index is table it self)"
            else
                string = string .. tostring(value)
            end
            string = string .. "\n"
        end
    end

    --region metatable
    local getSelfMetatable = getmetatable(self)
    if getSelfMetatable ~= nil and getSelfMetatable ~= self then
        string = string .. string.rep(" ", indent) .. "metatable:"
        string = string .. TableDeepToString(getSelfMetatable, indent + DEFAULT_INDENT, false, existMembers)
    end
    --endregion

    return string
end
--endregion

function DeepToString.of(self)
    if self == nil then
        return "nil"
    end

    local selfType = type(self)
    if selfType == "table" then
        return TableDeepToString(self, DEFAULT_INDENT, false, {})
    end

    if selfType == "function" then
        return FunctionDeepToString(self, "function(%s)")
    end
end

return DeepToString
