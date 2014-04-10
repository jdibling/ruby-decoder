require 'test/unit'

require 'global/string/to_hex_a'

require 'protocol/tdds-1.0/field/price'

include Protocol::Tdds10::Field

module Test
module Tdds10Fields
# ----------------------
class TestPrice < Test::Unit::TestCase
  def test_baseline
    source = "B123456".to_hex_a
    expected = 1234.56
    field = BbdsPrice(:Test, source.size)
    actual = field.decode(source)
    assert_equal expected, actual
  end

  def test_bad_denom
    source = "z123456".to_hex_a
    expected = 1234.56
    field = BbdsPrice(:Test, source.size)
    assert_raise ArgumentError do
      actual = field.decode(source)
      assert false, "Payload with bad denominator code should not decode."
    end
  end
end
# ----------------------
end
end

