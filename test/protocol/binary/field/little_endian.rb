require 'test/unit'

require 'protocol/binary/field/little_endian'

module Test
module Protocol
module Binary
module Field
# --------------------
class TestDecodeLittleEndianField < Test::Unit::TestCase
  @@TESTS = 
    [
      [[0x01], 0x01],
      [[0x01, 0x02],  0x0201],
      [[0x01, 0x02, 0x03, 0x04], 0x04030201]
    ]

  def test
    @@TESTS.each do |test|
      payload = test[0]
      expected = test[1]

      field = ::Protocol::Binary::Field::LittleEndianField.new do |f|
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

