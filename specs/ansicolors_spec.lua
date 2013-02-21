local ansicolors = require 'ansicolors'

local c27 = string.char(27)

describe('ansicolors', function()

  it('should add resets if no options given', function()
    assert_equal(ansicolors('foo'), c27 .. '[0m' .. 'foo' .. c27 .. '[0m' )
  end)

  it('should throw an error on invalid options', function()
    assert_error(function() ansicolors('%{blah}foo') end)
  end)

  it('should add red color to text', function()
    assert_equal(ansicolors('%{red}foo'), c27 .. '[0m' .. c27 .. '[31mfoo' .. c27 .. '[0m')
  end)

  it('should add red underlined text', function()
    assert_equal(ansicolors('%{red underline}foo'),  c27 .. '[0m' .. c27 .. '[31m' .. c27 .. '[4mfoo' .. c27 .. '[0m')
  end)

  it('should with heterogeneous attributes', function()
    assert_equal(ansicolors('%{bright white}*%{bright red}BEEP%{bright white}*'),  c27 .. '[0m' .. c27 .. '[1m' .. c27 .. '[37m*' .. c27 .. '[1m' .. c27 .. '[31mBEEP' .. c27 .. '[1m' .. c27 .. '[37m*' .. c27 .. '[0m')
  end)

  describe('noReset', function ()
    it('should do nothing if no options given', function()
      assert_equal(ansicolors.noReset('foo'), 'foo' )
    end)

    it('should throw an error on invalid options', function()
      assert_error(function() ansicolors.noReset('%{blah}foo') end)
    end)

    it('should add red color to text', function()
      assert_equal(ansicolors.noReset('%{red}foo'), c27 .. '[31mfoo')
    end)

    it('should add red underlined text', function()
      assert_equal(ansicolors.noReset('%{red underline}foo'), c27 .. '[31m' .. c27 .. '[4mfoo')
    end)

    it('should with heterogeneous attributes', function()
      assert_equal(ansicolors.noReset('%{bright white}*%{bright red}BEEP%{bright white}*'),  c27 .. '[1m' .. c27 .. '[37m*' .. c27 .. '[1m' .. c27 .. '[31mBEEP' .. c27 .. '[1m' .. c27 .. '[37m*')
    end)

  end)

  describe('support detection', function()

    it('should return a plain text string on systems with no package.config', function()
      local prevConfig = package.config
      package.config = "\\"
      local colors = dofile 'ansicolors.lua'

      assert_equal(colors('%{red underline}foo'), 'foo')

      io.popen = prevIoPopen
    end)

  end)

  describe('under Windows', function()

    describe('without ANSICON', function()
      it('should return a plain text string', function()
        package.config = "\\"
        local colors = dofile 'ansicolors.lua'
        assert_equal(colors('%{red}foo'), 'foo')
      end)
    end)

    describe('with ANSICON', function()
      it('should add ANSI escapes to text', function()
        package.config = "\\"
        os.getenv = function () return true end
        local colors = dofile 'ansicolors.lua'
        assert_equal(colors('%{red}foo'), c27 .. '[0m' .. c27 .. '[31mfoo' .. c27 .. '[0m')
      end)
    end)
  end)

end)
