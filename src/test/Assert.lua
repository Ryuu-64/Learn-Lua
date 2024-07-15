local Assert = {}

function Assert.Equals(expected, actual)
    if expected ~= actual then
        error("equals assert failed")
    end
end

function Assert.NotEquals(expected, actual)
    if expected == actual then
        error("not equals assert failed")
    end
end

return Assert
