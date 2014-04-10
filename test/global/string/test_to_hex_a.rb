require 'test/unit'

require 'global/string/to_hex_a'

module Test
module Global
# -----------------
class TestStringToHexA < Test::Unit::TestCase
  def test_success
    source = "ABCD"
    expected = [0x41, 0x42, 0x43, 0x44]
    actual = source.to_hex_a
    assert_equal expected, actual
  end

  def test_fail
    source = "ABCD"
    expected = [0x41, 0x42, 0x43, 0x45]
    actual = source.to_hex_a
    assert_not_equal expected, actual
  end
end
# -----------------
end
end
