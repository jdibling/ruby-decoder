require 'fields/attributes/basic'

module Fields
module Attributes
# -----------------------------------
class PeekAhead < BasicAttribute
  def evaluate field, decoder
    decoder.rewind += field.length
  end
  def to_s
    "Peek"
  end
end

def peek_ahead
  [PeekAhead.new]
end
# -----------------------------------
end
end

