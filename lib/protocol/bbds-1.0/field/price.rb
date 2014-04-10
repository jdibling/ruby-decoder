require 'protocol/tdds-1.0/field/price'

include Protocol::Tdds10::Field

module Protocol
module Bbds10 
module Field
# ------------------
BbdsPriceField = TddsPriceField

def BbdsPrice(id, length, attributes={})
  TddsPrice id, length, attributes
end
# ------------------
end
end
end
