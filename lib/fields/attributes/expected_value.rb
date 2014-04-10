require 'fields/attributes/basic'

module Fields
module Attributes
# -----------------------------------
class ExpectedValue < BasicAttribute
  def initialize value
    @expected = value
  end

  def evaluate field, decoder
    raise AttributeEvalError.new(self, field, nil), "Field ID #{field.id} not found in decoded fields <#{decoder.decoded}>."  if !decoder.decoded.include?(field.id)
    actual = decoder.decoded[field.id]
    raise AttributeEvalError.new(self, field, actual), "Decoded Field ID '#{field.id}' is nil." if actual.nil?
    raise AttributeEvalError.new(self, field, actual), "Field ID '#{field.id}' was expected to be (#{@expected.class}) <#{@expected}>, but actually was (#{actual.class}) <#{actual}>"  if actual != @expected
    true
  end

  def to_s
    "Expected:#{@expected}"
  end
end

def expected_value(value)
  expected = ExpectedValue.new(value)
  [expected]
end
    
# -----------------------------------
end
end

