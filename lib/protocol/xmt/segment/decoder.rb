require 'fields/attributes/all'

require 'protocol/binary/segment/decoder'

require 'protocol/xmt/constants'
require 'protocol/xmt/field/all'

module Protocol
module Xmt
module Segment
module Decoder
# --------------
include Protocol::Binary::Segment::Decoder
include Protocol::Xmt::Constants
include Protocol::Xmt::Field
include Fields::Attributes

def peek_msg_type
   peek = decode_fields [
    XmtBinary(:MsgLength, 2, peek_ahead),
    MsgType(:MsgType, 1, peek_ahead)
  ]
  peek[:Fields][:MsgType]
end

def decode_adm_header
  case is_adm?(peek_msg_type)
  when true
    decode_fields [
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:AdminId, 1),
      XmtBinary(:HbInterval, 2)
    ]
  when false
    nil
  end
end

def decode_packet_header
    hdr_fields = decode_fields [
        XmtBinary(:StartOfFrame, 1, expected_value(STX)),
        XmtString(:ProtocolName, 1, expected_value("X")),
        XmtNumeric(:ProtocolVer, 1),
        XmtBinary(:PacketLength, 2),
        XmtBinary(:SessionId, 4),
        XmtString(:AckReq, 1),
        XmtBinary(:NumBody, 1)
    ] 
  hdr_fields
end

def decode_Heartbeat_message
  hb_fields = decode_fields [
    XmtString(:SourceId, 1),
    XmtBinary(:StreamId, 2),
    XmtBinary(:Sequence0, 1),
    XmtBinary(:Sequence, 4)
  ]
  puts "decoded heartbeat: #{hb_fields}" if sverb?
  hb_fields
end
# --------------
end
end
end
end

