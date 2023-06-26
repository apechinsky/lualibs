--
-- General purpose path library.
--
-- The path may represent a path in a tree-like structure:
--  * filesystem path
--  * classpath
--  * url path
--  * etc.
--
-- Goal of this library is to decouple path operaitons such as parent,
-- child, sibling, relativize, etc. from a specializations of path application.
--
-- Specialized libraries may reuse path to implement specifics.
--

Path = {}

function Path:new(segments, separator)
    self.__index = self
    local instance = setmetatable({}, self)

    instance.segments = segments
    instance.separator = separator

    return instance
end

function Path:parse(string, separator)
    if string == nil then
        return nil
    end

    local segments = {}

    local previousStartIndex = 1

    repeat
        local startIndex, endIndex = string:find(separator, previousStartIndex, true)

        local segmentEndIndex = startIndex == nil and #string or startIndex - 1
        local segment = string:sub(previousStartIndex, segmentEndIndex)

        if segment ~= '' then
            table.insert(segments, segment)
        end
        previousStartIndex = startIndex ~= nil and endIndex + 1

    until startIndex == nil

    return Path:new(segments, separator)
end

function Path:size()
    return #self.segments
end

function Path:is_empty()
    return self:size() == 0
end

function Path:cloneTable(source)
    return { table.unpack(source) }
end

function Path:clone()
    local segments = Path:cloneTable(self.segments)
    return Path:new(segments, self.separator)
end

function Path:subpath(startIndex, endIndex)
    assert(startIndex >= 1,
        string.format("startIndex must be in range [%d, %d], got: %d",
            1, self:size(), startIndex))

    assert(endIndex <= self:size(),
        string.format("endIndex must be in range [%d, %d], got: %d",
            1, self:size(), endIndex))

    assert(endIndex >= startIndex,
        string.format("endIndex must be %d out of bounds [%d, %d]",
            endIndex, 1, self:size()))

    local segments = { table.unpack(self.segments, startIndex, endIndex) }
    return Path:new(segments, self.separator)
end

function Path:parent()
    if #self.segments == 0 then
        return nil
    else
        local segments = { table.unpack(self.segments, 1, #self.segments - 1) }
        return Path:new(segments, self.separator)
    end
end

function Path:child(segment)
    local segments = { table.unpack(self.segments) }
    table.insert(segments, segment)
    return Path:new(segments, self.separator)
end

function Path:sibling(segment)
    if #self.segments == 0 then
        return self
    else
        local segments = { table.unpack(self:parent().segments) }
        table.insert(segments, segment)
        return Path:new(segments, self.separator)
    end
end

function Path:tostring()
    return table.concat(self.segments, self.separator)
end

function Path:relative(base)
    local i = 1
    while self.segments[i] == base.segments[i] and i <= self:size() and i <= base:size() do
        i = i + 1
    end
    local common = i - 1

    -- print("common=" .. common .. ' #base=' .. #base)

    local r = { table.unpack(base.segments, common + 1, base:size()) }

    -- print("r1 = " .. tos(r) .. " size: " .. #r)

    for _ = 1, base:size() - common do
        table.insert(r, '..')
    end

    -- print("r2 = " .. tos(r) .. " size: " .. #r)

    for j = 1, self:size() - common do
        table.insert(r, self.segments[common + j])
    end

    -- print("r3 = " .. tos(r) .. " size: " .. #r)

    return Path:new(r, self.separator)

end


