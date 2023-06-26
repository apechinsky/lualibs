strings = {}

function strings.trim_right(path, char)
    assert(char ~= '' and char ~= nil, "Trim char must not be nil or empty")

    local result = path
    while string.sub(result, #result, #result) == char do
        result = string.sub(result, 1, #result - 1)
    end
    return result
end

function strings.trim_left(path, char)
    assert(char ~= '' and char ~= nil, "Trim char must not be nil or empty")

    local result = path
    while string.sub(result, 1, 1) == char do
        result = string.sub(result, 2, #result)
    end
    return result
end

