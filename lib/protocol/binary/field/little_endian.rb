require 'protocol/binary/field/basic'

module Protocol
module Binary
module Field
# ----------------
class LittleEndianField < BasicBinaryField
  def decode(bytes=[])
    raise ArgumentError, "#{id} field must be array but is #{bytes.class}" if !bytes.kind_of? Array
    raise ArgumentError, "#{id} field must have #{length} elements, but has #{bytes.size} (#{bytes.inspect}) [#{describe}]" if bytes.length != length

    bytes.reverse_each.inject(0) { |m, i| (m*0x100) + i }
  end
end 

def LittleEndian(id, length, attributes={})
  LittleEndianField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ----------------
end
end
end

