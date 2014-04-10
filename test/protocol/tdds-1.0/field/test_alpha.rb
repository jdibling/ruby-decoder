require 'test/unit'

require 'global/string/to_hex_a'

require 'protocol/tdds-1.0/field/alpha'

include Protocol::Tdds10::Field

module Test
module Protocol
module Tdds10
module Field
# ----------------
class Alpha < Test::Unit::TestCase
  def test
    source = "ABCD".to_hex_a
    expected = "ABCD"

    field = BbdsAlphaField.new do |f|
      f.id = :Test
      f.length = source.size
    end

    actual = field.decode source
    assert_equal expected, actual

  end
end
# ----------------
end
end
end
end
