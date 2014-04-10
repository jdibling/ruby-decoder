require 'protocol/tdds-1.0/field/alpha'

include Protocol::Tdds10::Field

module Protocol
module Bbds10
module Field
# ------------------
BbdsAlphaField = TddsAlphaField

def BbdsAlpha(id, length, attributes={})
  TddsAlpha(id, length, attributes)
end
# ------------------
end
end
end

