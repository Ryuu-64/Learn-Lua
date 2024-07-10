local Trim = {}

function Trim.of(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

return Trim
