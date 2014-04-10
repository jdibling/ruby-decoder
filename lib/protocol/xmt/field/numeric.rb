require 'protocol/binary/field/ascii_string'

module Protocol
module Xmt
module Field
# ------------------
class XmtNumericField < Protocol::Binary::Field::AsciiStringField
  def decode(bytes=[])
    decoded = super
    raise ArgumentError, "#{id} payload must be a numeric string, but has non-numeric characters. Payload=[#{bytes.inspect}]" if decoded =~ /[^[:digit:]]/ 
    decoded.to_i
  end
end

def XmtNumeric(id, length, attributes={})
  XmtNumericField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end

# ------------------
end
end
end


