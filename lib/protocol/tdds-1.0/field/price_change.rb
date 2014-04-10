require 'errors/field'

require 'format/payload_array'

require 'protocol/tdds-1.0/field/alpha'

module Protocol
module Tdds10
module Field
# ------------------
class TddsPriceChangeField < TddsAlphaField
  def decode(bytes=[])
    encoded = super.to_i(16)
    raise FieldError, "TddsPriceChangeField payload should be 1 byte, but is actually #{bytes.size}: <#{bytes}>" unless bytes.size == 1
    raise FieldDecodingError, "Unexpected TddsPriceChangeField value: <#{encoded}>" unless encoded.between?(0,7)

    flags = []
    flags << "LAST" unless 0 == (encoded & 0b0000_0001)
    flags << "LOW"  unless 0 == (encoded & 0b0000_0010)
    flags << "HIGH" unless 0 == (encoded & 0b0000_0100)
    flags << "NONE" if encoded == 0
    flags.join(' ')
  end
end

def TddsPriceChange(id, length, attributes={})
  TddsPriceChangeField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end
