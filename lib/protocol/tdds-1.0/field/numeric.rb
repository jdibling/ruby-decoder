require 'protocol/binary/field/all'
require 'format/payload_array'

module Protocol
module Tdds10
module Field
# ------------------
class TddsNumericField < Protocol::Binary::Field::AsciiStringField
  def decode(bytes=[])
    decoded = super
    raise ArgumentError, "#{id} payload must be a numeric string, but has non-numeric characters. Payload=[#{bytes.extend(Format::PayloadArray).to_s}]" if decoded =~ /[^[:digit:]]/ 
    decoded.to_i
  end
end

def TddsNumeric(id, length, attributes={})
  TddsNumericField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end


