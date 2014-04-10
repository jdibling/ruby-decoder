require 'protocol/binary/field/basic'

module Protocol
module Binary
module Field
# ----------------
class AsciiStringField < BasicBinaryField

  def decode(bytes=[])
    raise ArgumentError, "#{id} field must be array but is #{bytes.class}" if !bytes.kind_of? Array
    raise ArgumentError, "#{id} field must have #{length} elements, but has #{bytes.size} (#{bytes.inspect}) [#{describe}]" if bytes.length != length

    decoded = bytes.reduce("") {|m,x| m + x.chr}
    
    raise ArgumentError, "#{id} payload must be printable, but has non-printable characters. Payload=[#{bytes.inspect}]" if decoded =~ /[^[:print:]]/ 

    decoded
  end
end 

def AsciiString(id, length, attributes={})
  AsciiStringField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ----------------
end
end
end



