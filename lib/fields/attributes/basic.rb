module Fields
module Attributes
# ---------------------
class BasicAttribute
  def initialize
    yield self if block_given?
  end

  def check field, decoder
    raise AttributeEvalError.new(self, field, nil), "Field ID #{field.id} not found in decoded fields <#{decoder.decoded.inspect}>."  if !decoder.decoded.include?(field.id)
  end
end

class AttributeEvalError < StandardError
  attr_reader :attribute, :field, :decoded
  def initialize(attribute, field, decoded)
    @attribute = attribute
    @field = field
    @decoded = decoded
  end

end
# ---------------------
end
end


