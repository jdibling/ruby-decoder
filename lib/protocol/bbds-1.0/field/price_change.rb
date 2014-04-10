require 'protocol/tdds-1.0/field/price_change'

include Protocol::Tdds10::Field

module Protocol
module Bbds10 
module Field
# ------------------
BbdsPriceChangeField = TddsPriceChangeField

def BbdsPriceChange(id, length, attributes={})
  TddsPriceChange id, length, attributes
end
# ------------------
end
end
end
