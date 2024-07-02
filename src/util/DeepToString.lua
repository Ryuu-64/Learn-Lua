local DeepToString = {}

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

    return a.field < b.field
end

local function GetSortedTableMembers(self)
    local members = {}
    for k, v in pairs(self) do
        table.insert(members, { field = k, value = v })
    end

    table.sort(members, TableMemberSorter)
    return members
end

local function TableDeepToString(self, indent, isIndentSelf, existingElements)
    if self == nil then
        return "nil"
    end

    local string = ""

    if isIndentSelf then
        string = string .. string.rep(" ", indent)
    end

    string = string .. "(" .. tostring(self) .. ")" .. ":\n"

    local members = GetSortedTableMembers(self)
    for i = 1, #members do
        local member = members[i]
        local field = member.field
        local value = member.value
        local valueType = type(value)
        if valueType == "table" and value ~= self then
            local isExisting = false
            --region existingElements
            for j = 1, #existingElements do
                local existingElement = existingElements[j]
                if value == existingElement then
                    isExisting = true
                    break
                end
            end
            --endregion

            string = string .. string.rep(" ", indent) .. field
            string = string .. TableDeepToString(value, indent * 2, false)
        elseif valueType == "function" then
            string = string .. string.rep(" ", indent) ..
                "function:" .. field .. FunctionDeepToString(value, "(%s)") .. "\n"
        else
            string = string .. string.rep(" ", indent) .. field .. ":"
            if field == "__index" and self == value then
                string = string .. "(__index is table it self)"
            else
                string = string .. tostring(value)
            end
            string = string .. "\n"
        end
    end

    --region __index string
    if type(self.__index) ~= "nil" and self.__index ~= self then
        string = string .. string.rep(" ", indent) .. "__index:"
        string = string .. TableDeepToString(self.__index, indent * 2, false)
    end
    --endregion

    return string
end
--endregion

function DeepToString.of(self)
    if self == nil then
        return nil
    end

    if type(self) == "table" then
        return TableDeepToString(self, 4, false, {})
    end

    if type(self) == "function" then
        return FunctionDeepToString(self, "function(%s)")
    end
end

return DeepToString
