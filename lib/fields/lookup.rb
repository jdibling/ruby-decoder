require 'fields/basic_field'
module Fields
# ----------------------------
class LookupField < Fields::BasicField
  def initialize
    yield self if block_given?
  end

  def map=(map)
    @map = map
  end
  
  def wire_id=(wire)
    @wire_id = wire
  end

  def do_decode(decoder)
    wire_val = decoder.decoded[@wire_id]
    is_mapped = @map.include? wire_val
    raise "Unexpected value (#{wire_val}) not found in map #{@map.class}:#{@map}" unless is_mapped
    @map[wire_val]
  end
end

def Lookup(id, wire_id, map, attributes=[])
  Fields::LookupField.new do |f|
    f.id = id
    f.wire_id = wire_id
    f.map = map
    f.attributes = attributes
  end
end

# ---------------------------
end

