require 'test/unit'

require 'protocol/binary/field/ascii_string'

module Test
module Protocol
module Binary
module Field
# --------------------
class TestDecodeAsciiStringField < Test::Unit::TestCase
  @@TESTS = 
    [
      [[0x61, 0x62, 0x63, 0x64, 0x65], "abcde"]
    ]

  def test
    @@TESTS.each do |test|
      payload = test[0]
      expected = test[1]

      field = ::Protocol::Binary::Field::AsciiStringField.new do |f|
        f.id = :Test
        f.length = payload.size
      end

      actual = field.decode payload
      assert_equal expected, actual
    end
  end
end
# --------------------
end
end
end
end


