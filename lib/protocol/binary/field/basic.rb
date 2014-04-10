require 'fields/basic_field'

module Protocol
module Binary
module Field 
# ---------------------------
class BasicBinaryField < Fields::BasicField
  attr_reader :length

  def length=(length)
    @length = length
  end

  def do_decode(decoder)
    decode(decoder.payload[decoder.iter...decoder.iter+@length])
  end 
 
  def describe
    super + "Length: #{length} Bytes"
  end
end
# ---------------------------
end
end
end

