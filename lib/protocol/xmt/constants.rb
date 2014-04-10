require 'protocol/binary/constants'

module Protocol
module Xmt
# -----------------

module Constants
  include Protocol::Binary::Constants

  MSG_TYPES = {
    0x30 => :Heartbeat,
    0x31 => :LoginReq,
    0x32 => :LoginResp,
    0x33 => :Logout,
    0x34 => :Ack,
    0x35 => :ReplayReq,
    0x36 => :SequenceJump,
    0x37 => :Reserved,
    0x38 => :Operation,
    0x39 => :Reject
  }.freeze

  ADM_MSG_TYPES = MSG_TYPES.collect { |k,v| v}.freeze

  def is_adm?(msg_type)
    ADM_MSG_TYPES.include?(msg_type)
  end
  
  def get_msg_type(val)
    MSG_TYPES[val.to_i]
  end
end

# -----------------
end
end
