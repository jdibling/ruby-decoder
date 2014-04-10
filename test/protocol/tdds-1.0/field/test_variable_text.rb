require 'test/unit'

require 'global/string/to_hex_a'

require 'protocol/tdds-1.0/field/variable_text'

include Protocol::Tdds10::Field

module Test
module Tdds10Field
# ------------------------
class TestVaribaleTextField < Test::Unit::TestCase
  def test_baseline
    source = "FOOBAR".to_hex_a
    expected = "FOOBAR"
    field = BbdsVariableText(:Test, source.size)
    actual = field.decode source
    assert_equal expected, actual
  end

  def test_too_long
    source = ("*"*500).to_hex_a
    field = BbdsVariableText(:Test, 300)
    assert_raise TddsVariableTextTooLongError do
      field.decode source
    end
  end
end
# ------------------------
end
end

