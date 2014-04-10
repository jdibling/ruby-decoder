require 'test/unit'

require 'global/array/from_payload'

module Test
module Global
module Array
# ------------------
class FromPayload < Test::Unit::TestCase
  def test_terse
    source = "31343243394E32"
    expected = [0x31, 0x34, 0x32, 0x43, 0x39, 0x4e, 0x32]

    actual = ::Array.from_payload source

    assert_equal expected, actual
  end
  def test_sparse
    source = "31 34 32 43 39 4E 32"
    expected = [0x31, 0x34, 0x32, 0x43, 0x39, 0x4e, 0x32]

    actual = ::Array.from_payload source

    assert_equal expected, actual
  end

  def test_malformed_terse
    source = "31343243394E3Z"

    assert_raise RuntimeError do
      actual = ::Array.from_payload source
      assert false, "Array conversion of mal-formed source string should fail."
    end
  end
  
  def test_malformed_sparse
    source = "31 34 32 43 39 4E 3Z"

    assert_raise RuntimeError do
      actual = ::Array.from_payload source
      assert false, "Array conversion of mal-formed source string should fail."
    end
  end
end
# ------------------
end
end
end
