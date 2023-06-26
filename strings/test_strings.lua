require ('busted.runner')()

require('strings')

describe("Strings.trim_right", function()

    it("nil string parsed as nil path", function ()
        local path = Path:parse(nil, '.')
        assert.are.equals(nil, path)
    end)
-- print(strings.trimRight('ab', nil))
-- print(strings.trimRight('ab', ''))
-- print(strings.trim_right('', '/'))
-- print(strings.trim_right('a/', '/'))
-- print(strings.trim_right('a////', '/'))
-- print(strings.trim_right("abc--", "-"))
--
-- print(strings.trim_left('', '/'))
-- print(strings.trim_left('/a', '/'))
-- print(strings.trim_left('///a', '/'))
-- print(strings.trim_left('--abc', '-'))

end)
