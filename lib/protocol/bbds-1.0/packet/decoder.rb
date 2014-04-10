require 'format/hex_array'
require 'global/options'
require 'global/snake'

require 'fields/all'
require 'fields/attributes/all'

require 'protocol/binary/segment/decoder'

require 'protocol/bbds-1.0/constants'
require 'protocol/bbds-1.0/field/all'


module Protocol
module Bbds
module Packet
# ----------------
include Global::Options
include Fields
include Fields::Attributes
include Protocol::Binary::Segment::Decoder
include Protocol::Bbds10::Constants
include Protocol::Bbds10::Field

def initialize
  yield self if block_given?
end

def decode(msg_bytes=[])
  set_payload msg_bytes
  pkt_hdr = decode_packet_header msg_bytes
  msg_type = pkt_hdr[:Fields][:MessageType]
  handler = "decode_#{msg_type.to_s.snake}_message".to_sym
  handled = self.class.method_defined? handler
  msg = case handled
        when true
          self.method(handler).call
        when false
          {:Fields=>{:UnhandledMsgType=>msg_type, :UndefinedHandler=>handler}, :Payload=>[]}
        end

  appendage = case !msg.nil? && msg.include?(:Fields) && msg[:Fields].include?(:InsideAppendageIndicator)
              when true
                case msg[:Fields][:InsideAppendageIndicator]
                when :AppendageAttached
                  decode_inside_appendage
                else
                  nil
                end
              else
                nil
              end

  decoded = pkt_hdr
  decoded[:Fields].merge! msg[:Fields] unless msg.nil?
  decoded[:Payload] +=  msg[:Payload] unless msg.nil?
  decoded[:Fields].merge! appendage[:Fields] unless appendage.nil?
  decoded[:Payload] += appendage[:Payload] unless appendage.nil?

  decoded
end

# --------------------------------------------------------------------

def decode_packet_header(bytes=[])
  decode_fields [
    TddsAlpha(:MsgCatCode, 1),
    TddsAlpha(:MsgTypeCode, 1),
    TddsAlpha(:SessionId, 1),
    TddsAlpha(:RetranReq, 2, lookup(RETRAN_CODE, "VendorCode")),
    TddsNumeric(:Sequence, 8),
    TddsAlpha(:MarketCenter, 1),
    TddsDateTime(:DateTime, 7),
    LittleEndian(:Reserved, 1, hidden),
    Composite(:MessageType, [:MsgCatCode, :MsgTypeCode], lookup(MESSAGE_TYPE_CODES))
  ]
end

# --------------------------------------------------------------------

def decode_market_participant_quote_update_message
  decode_fields [
    BbdsAlpha(:Symbol, 11),
    BbdsAlpha(:OTCBBType, 1, lookup(OTCBB_TYPES)),
    BbdsAlpha(:MMID, 4),
    BbdsAlpha(:MMLocation, 1, lookup(MARKET_PARTICIPANT_LOCATIONS, "Other")),
    BbdsAlpha(:MMStatus, 1, lookup(MARKET_PARTICIPANT_STATUS)),
    BbdsAlpha(:MMQuoteCondition, 1, lookup(MARKET_PARTICIPANT_QUOTE_CONDITION)),
    LittleEndian(:Reserved, 1, hidden),
    BbdsAlpha(:BidOfferWanted, 1, lookup(BID_OFFER_WANTED_INDICATOR)),
    BbdsAlpha(:Unsolicited, 1, lookup(UNSOLICITED_INDICATOR)),
    BbdsPrice(:BidPrice, 13),
    BbdsNumeric(:BidSize, 7),
    BbdsPrice(:AskPrice, 13),
    BbdsNumeric(:AskSize, 7),
    BbdsAlpha(:Currency, 3),
    BbdsNumeric(:InsideAppendageIndicator, 1, lookup(INSIDE_APPENDAGE_INDICATOR))
  ]
end

# --------------------------------------------------------------------

def decode_inside_appendage
  decode_fields [
    BbdsAlpha(:QuoteCondition, 1, lookup(INSIDE_QUOTE_CONDITION)),
    BbdsPrice(:InsideBidPrice, 13),
    BbdsNumeric(:InsideBidSize, 7),
    BbdsPrice(:InsideAskPrice, 13),
    BbdsNumeric(:InsideAskSize, 7)
  ]
end


# --------------------------------------------------------------------

def decode_general_admin_message
  decode_fields [
    BbdsVariableText(:Text, 300)
  ]
end

# --------------------------------------------------------------------

def decode_trading_action_message
  decode_fields [
    BbdsAlpha(:Symbol, 11),
    BbdsAlpha(:TradingAction, 1, lookup(ACTION)),
    BbdsDateTime(:DateTime, 7),
    BbdsAlpha(:Reason, 6, lookup(REASON))
  ]
end

# --------------------------------------------------------------------

def decode_start_of_day_message
end

def decode_end_of_day_message
end

def decode_market_session_open_message
end

def decode_market_session_close_message
end

def decode_emergency_market_halt_message
end

def decode_emergency_market_resume_message
end

def decode_end_transmissions_message
end

def decode_start_test_cycle_message
end

def decode_end_test_cycle_message
end

def decode_line_integrity_message
end

def decode_sequence_reset_message
end






# ----------------
end
end
end
