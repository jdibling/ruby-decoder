require 'protocol/tdds-1.0/field/date_time'

include Protocol::Tdds10::Field

module Protocol
module Bbds10 
module Field
# ------------------
BbdsDateTimeField = TddsDateTimeField 

def BbdsDateTime(id, length, attributes={})
  TddsDateTime id, length, attributes
end
# ------------------
end
end
end
