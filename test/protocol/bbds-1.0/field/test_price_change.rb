require 'test/unit'

require 'global/string/to_hex_a'

require 'protocol/bbds-1.0/field/price_change'

include Protocol::Bbds10::Field

module Test
module Bbds10Fields
# ----------------------
class TestPriceChange < Test::Unit::TestCase
  def test_baseline
    source = "1".to_hex_a
    expected = "LAST"
    field = BbdsPriceChange(:Test, source.size)
    actual = field.decode source
    assert_equal expected, actual
  end

  def test_all_legit  
    field = BbdsPriceChange(:Test, 1)
    [
      [0b0001, "LAST"],
      [0b0010, "LOW"],
      [0b0100, "HIGH"],

      [0b0101, "LAST HIGH"],
      [0b0110, "LOW HIGH"],
      [0b0111, "LAST LOW HIGH"],

      [0b0011, "LAST LOW"],
      [0,     "NONE"]
    ].each do |test|
      source = test[0].to_s(16).to_hex_a
      expected = test[1]
      actual = field.decode(source)
      assert_equal expected, actual
    end
  end
  
  def test_invalid
    field = BbdsPriceChange(:Test, 1)
    (8..15).each do |val|
      source = val.to_s(16).to_hex_a
      assert_raise FieldDecodingError do
        field.decode source
      end
    end
  end
end
# ----------------------
end
end


