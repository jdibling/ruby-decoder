require 'protocol/binary/field/all'

module Protocol
module Xmt
module Field
# ------------------
class XmtBinaryField < Protocol::Binary::Field::LittleEndianField
end

def XmtBinary(id, length, attributes={})
  XmtBinaryField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end

