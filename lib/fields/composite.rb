require 'fields/basic_field'

module Fields
# -------------------------------------
class CompositeField < Fields::BasicField
  attr_reader :composed_from
  def initialize
    yield self if block_given?
  end

  def composed_from=(fields=[])
    @composed_from = fields
  end

  def do_decode(decoder)
    @composed_from.map {|id| decoder.decoded[id] }.join
  end


end

def Composite(id, composed_from=[], attributes=[])
  Fields::CompositeField.new do |f|
    f.id = id
    f.composed_from = composed_from
    f.attributes = attributes
  end    
end
# -------------------------------------
end
