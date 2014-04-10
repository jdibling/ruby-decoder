require 'test/unit'

require 'global/string/to_hex_a'

require 'protocol/bbds-1.0/field/numeric'

include Protocol::Bbds10::Field

module Test
module Bbds10Fields
# ----------------------
class TestNumeric < Test::Unit::TestCase
  def test_baseline
    source = "12345".to_hex_a
    expected = 12345
    field = BbdsNumeric(:Test, source.size)
    actual = field.decode(source)
    assert_equal expected, actual
  end

  def test_non_numeric
    source = "abscdef".to_hex_a
    field = BbdsNumeric(:Test, source.size)
    assert_raise ArgumentError do
      actual = field.decode source
      assert false, "Non-numeric source should not decode"
    end
  end

  def test_string_padded
    source = " 12345 ".to_hex_a
    expected = 12345
    field = BbdsNumeric(:Test, source.size)
    assert_raise ArgumentError do
      actual = field.decode source
      assert false, "String-padded source should not decode"
    end
  end
end
# ----------------------
end
end
