require("matcher_combinators.luassert")

local strings = require('srplib.strings')

describe("Strings.trim_right", function()

    it("Trim on nil string returns nil", function ()
        assert.are.equal(nil, strings.trim_right(nil, ' '))
    end)

    it("Trim nil", function ()
        assert.are.equal('a', strings.trim_right('a', nil))
    end)

    it("Trim empty string", function ()
        assert.are.equal('a', strings.trim_right('a', ''))
    end)

    it("Trim one space", function ()
        assert.are.equal('a', strings.trim_right('a ', ' '))
    end)

    it("Trim multiple spaces", function ()
        assert.are.equal('a', strings.trim_right('a    ', ' '))
    end)

    it("Trim a word", function ()
        assert.are.equal('car', strings.trim_right('carpet', 'pet'))
    end)

    it("Trim multiple words", function ()
        assert.are.equal('carpe', strings.trim_right('carpepetpet', 'pet'))
    end)
end)

describe("Strings.trim_left", function()

    it("Trim nil string returns nil", function ()
        assert.are.equal(nil, strings.trim_left(nil, ' '))
    end)

    it("Trim nil", function ()
        assert.are.equal('a', strings.trim_left('a', nil))
    end)

    it("Trim empty string", function ()
        assert.are.equal('a', strings.trim_left('a', ''))
    end)

    it("Trim one space", function ()
        assert.are.equal('a', strings.trim_left('a', ' '))
    end)

    it("Trim multiple spaces", function ()
        assert.are.equal('a', strings.trim_left('    a', ' '))
    end)

    it("Trim a word", function ()
        assert.are.equal('pet', strings.trim_left('carpet', 'car'))
    end)

    it("Trim multiple words", function ()
        assert.are.equal('capet', strings.trim_left('carcarcapet', 'car'))
    end)
end)

describe("strings.ends_with", function ()

    it("check with nil causes an error", function ()
        assert.has_error(function () strings.has_suffix('', nil) end)
    end)

    it("nil string does not end with something", function ()
        assert.are.equal(false, strings.has_suffix(nil, 'a'))
    end)

    it("nil string ends with nil", function ()
        assert.are.equal(true, strings.has_suffix(nil, nil))
    end)

    it("any string ends with empty string", function ()
        assert.are.equal(true, strings.has_suffix('a', ''))
    end)

    it("ends with char", function ()
        assert.are.equal(true, strings.has_suffix('carpet', 't'))
    end)

    it("ends with word", function ()
        assert.are.equal(true, strings.has_suffix('carpet', 'pet'))
    end)

    it("ends with the same word", function ()
        assert.are.equal(true, strings.has_suffix('pet', 'pet'))
    end)

    it("negative", function ()
        assert.are.equal(false, strings.has_suffix('pet', 'carpet'))
    end)
end)

describe("strings.has_prefix", function ()

    it("check with nil causes an error", function ()
        assert.has_error(function () strings.has_prefix('', nil) end)
    end)

    it("nil string does not start with something", function ()
        assert.are.equal(false, strings.has_prefix(nil, 'a'))
    end)

    it("nil string starts with nil", function ()
        assert.are.equal(true, strings.has_prefix(nil, nil))
    end)

    it("empty string", function ()
        assert.are.equal(true, strings.has_prefix('a', ''))
    end)

    it("ends with char", function ()
        assert.are.equal(true, strings.has_prefix('carpet', 'c'))
    end)

    it("ends with word", function ()
        assert.are.equal(true, strings.has_prefix('carpet', 'car'))
    end)

    it("ends with the same word", function ()
        assert.are.equal(true, strings.has_prefix('pet', 'pet'))
    end)

    it("negative", function ()
        assert.are.equal(false, strings.has_prefix('pet', 'petcar'))
    end)
end)
