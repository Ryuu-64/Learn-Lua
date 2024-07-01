local Functions = {}

function Functions:DeepToString()
    local info = debug.getinfo(self, "uS")
    local param_length = info.nparams
    local is_var_arg = info.isvararg
    local params = {}
    for i = 1, param_length do
        table.insert(params, "param" .. i)
    end
    if is_var_arg then
        table.insert(params, "...")
    end

    return string.format("(%s)", table.concat(params, ", "))
end

return Functions
