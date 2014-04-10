require 'protocol/tdds-1.0/field/variable_text'

include Protocol::Tdds10::Field

module Protocol
module Bbds10
module Field
# ---------------------------
BbdsVariableTextTooLongError = TddsVariableTextTooLongError
BbdsVariableTextField = TddsVariableTextField

def BbdsVariableText(id, length, attributes={})
  TddsVariableText id, length, attributes
end
# ---------------------------
end
end
end
