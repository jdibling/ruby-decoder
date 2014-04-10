require 'protocol/tdds-1.0/field/numeric'

include Protocol::Tdds10::Field

module Protocol
module Bbds10
module Field
# ------------------
BbdsNumericField = TddsNumericField

def BbdsNumeric(id, length, attributes={})
  TddsNumeric id, length, attributes
end
# ------------------
end
end
end


