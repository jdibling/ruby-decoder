require 'protocol/tdds-1.0/constants'
require 'protocol/tdds-1.0/field/alpha'

module Protocol
module Tdds10
module Field
# ------------------
class TddsPriceField < TddsAlphaField
  include ::Protocol::Tdds10::Constants
  def decode(bytes=[])
    encoded = super

    denom_code = encoded[0]
    denom = PRICE_DENOMS[denom_code]
    raise ArgumentError, "Field [#{id}] Malformed Payload (#{bytes.extend(Format::PayloadArray)}): Unknown price denominator code in byte 0 (#{denom_code})" unless PRICE_DENOMS.include?(denom_code)
    numer = encoded[1..-1].to_i
    numer.to_f / denom
  end
end

def TddsPrice(id, length, attributes={})
  TddsPriceField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end
