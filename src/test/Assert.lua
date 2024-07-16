local Assert = {}

function Assert.Equal(expected, actual)
    assert(expected == actual, "equal assert failed")
end

function Assert.NotEqual(expected, actual)
    assert(expected ~= actual, "not equal assert failed")
end

function Assert.True(condition)
    assert(condition, "true assert failed")
end

return Assert
