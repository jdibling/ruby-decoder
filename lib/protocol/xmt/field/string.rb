require 'protocol/binary/field/all'

module Protocol
module Xmt
module Field
# ------------------
class XmtStringField < Protocol::Binary::Field::AsciiStringField
  def decode(bytes=[])
    super.rstrip
  end
end

def XmtString(id, length, attributes={}) 
  XmtStringField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end

# ------------------
end
end
end


