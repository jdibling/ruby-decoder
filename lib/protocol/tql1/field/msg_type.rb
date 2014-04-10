require 'protocol/xmt/field/all'

require 'protocol/tql1/constants'

module Protocol
module Tql1
module Field
# ------------------
class MsgTypeField < Protocol::Xmt::Field::XmtBinaryField
  include Protocol::Tql1::Constants

  def decode(bytes=[])
    val = super
    MSG_TYPES[val]
  end
end

def MsgType(id, length, attributes={})
  MsgTypeField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end


