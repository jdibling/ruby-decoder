require 'fields/attributes/basic'

module Fields
module Attributes
# -------------------------
class LookUp < BasicAttribute
  def initialize(map={}, default_label=nil)
    @map = map
    @default_label = default_label
  end

  def evaluate field, decoder
    check field, decoder

    wire = decoder.decoded[field.id]
    raise AttributeEvalError.new(self, field, wire), "Wire value (#{wire.class}) <#{wire}> not found in map <#{@map}>" if (!@map.include?(wire) && @default_label.nil?)
    decoded = @map[wire]

    decoder.decoded[field.id] = case decoded.nil?
                                when false
                                  decoded
                                when true
                                  "#{@default_label}:(#{wire.class})[#{wire}]"
                                end
    decoder.decoded[field.id]
  end
end

def lookup(map, default_label=nil)
  [LookUp.new(map, default_label)]
end

# -------------------------
end
end
