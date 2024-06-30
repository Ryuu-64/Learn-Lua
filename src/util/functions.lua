local Functions = {}

function Functions:deepToString()
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

    return string.format("function(%s)", table.concat(params, ", "))
end

return Functions
