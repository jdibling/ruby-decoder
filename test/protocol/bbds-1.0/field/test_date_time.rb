require 'test/unit'

require 'global/array/from_payload'

require 'protocol/bbds-1.0/field/date_time'
  
include Protocol::Bbds10::Field

module Test
module Protocol
module Bbds10
module Field

class DateTime < Test::Unit::TestCase
  def test
    source = Array.from_payload "31343243394E32"
    expected = "2014/02/19 09:30:02"

    field = BbdsDateTimeField.new do |f|
      f.id = :Test
      f.length = source.size
    end

    actual = field.decode source
    assert_equal expected, actual
  end
end

end
end
end
end

