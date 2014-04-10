require 'format/hex_array'
require 'global/options'
require 'global/snake'

require 'fields/all'
require 'fields/attributes/all'

require 'protocol/binary/segment/decoder'

require 'protocol/tdds-1.0/constants'
require 'protocol/tdds-1.0/field/all'


module Protocol
module Tdds
module Packet
# ----------------
include Global::Options
include Fields
include Fields::Attributes
include Protocol::Binary::Segment::Decoder
include Protocol::Tdds10::Constants
include Protocol::Tdds10::Field

def initialize
  yield self if block_given?
end

def decode_packet_header(bytes=[])
  decode_fields [
    TddsAlpha(:MsgCatCode, 1),
    TddsAlpha(:MsgTypeCode, 1),
    TddsAlpha(:SessionId, 1),
    TddsAlpha(:RetradReq, 2),
    TddsNumeric(:Sequence, 8),
    TddsAlpha(:MarketCenter, 1),
    TddsDateTime(:DateTime, 7),
    LittleEndian(:Reserved, 1, hidden),
    Composite(:MessageType, [:MsgCatCode, :MsgTypeCode], lookup(MESSAGE_TYPE_CODES))
  ]
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

  decoded = pkt_hdr
  decoded[:Fields].merge! msg[:Fields] unless msg.nil?
  decoded[:Payload] +=  msg[:Payload] unless msg.nil?
  decoded
end

def decode_short_form_trade_report_message
  decode_fields [
    TddsAlpha(:Symbol, 5),
    TddsAlpha(:SaleCondition, 1, lookup(SALE_CONDITIONS)),
    TddsPrice(:TradePrice, 7),
    TddsNumeric(:ReportVolume, 6),
    TddsPriceChange(:PriceChangeIndicator, 1)
  ]
end

def decode_long_form_trade_report_message
  decode_fields [
    TddsAlpha(:Symbol, 11),
    TddsAlpha(:SaleCondition, 1, lookup(SALE_CONDITIONS)),
    TddsNumeric(:SellersSaleDays, 2),
    TddsPrice(:TradePrice, 11),
    TddsAlpha(:Currency, 3),
    TddsNumeric(:ReportVolume, 9),
    TddsPriceChange(:PriceChangeIndicator, 1)
  ]
end

def decode_trade_cancel_error_message
  decode_fields [
    # --- LABEL ---
    TddsNumeric(:OrigSequence, 8),
    TddsAlpha(:Symbol, 11),
    TddsAlpha(:Function, 1, lookup(FUNCTIONS)),
    # --- ORIGINAL TRADE INFO ---
    TddsAlpha(:OrigSaleCondition, 1, lookup(SALE_CONDITIONS)),
    TddsNumeric(:OrigSellersSaleDays, 2),
    TddsPrice(:OrigTradePrice, 11),
    TddsAlpha(:OrigCurrency, 3),
    TddsNumeric(:OrigReportVolume, 9),
    # --- TRADE SUMMARY INFO ---
    TddsPrice(:HighPrice, 11),
    TddsPrice(:LowPrice, 11),
    TddsPrice(:LastPrice, 11),
    TddsAlpha(:LastSaleMarketCenter, 1),
    TddsAlpha(:LastCurrency, 3),
    TddsNumeric(:TotalVolume, 11),
    TddsPriceChange(:PriceChangeIndicator, 1)
  ]
end
def decode_trade_correction_message
  decode_fields [
    # --- LABEL ---
    TddsNumeric(:OrigSequence, 8),
    TddsAlpha(:Symbol, 11),
    # --- ORIGINAL TRADE INFO ---
    TddsAlpha(:OrigSaleCondition, 1, lookup(SALE_CONDITIONS)),
    TddsNumeric(:OrigSellersSaleDays, 2),
    TddsPrice(:OrigTradePrice, 11),
    TddsAlpha(:OrigCurrency, 3),
    TddsNumeric(:OrigReportVolume, 9),
    # --- CORRECTED TRADE INFO ---
    TddsAlpha(:CorrSaleCondition, 1, lookup(SALE_CONDITIONS)),
    TddsNumeric(:CorrSellersSaleDays, 2),
    TddsPrice(:CorrTradePrice, 11),
    TddsAlpha(:CorrCurrency, 3),
    TddsNumeric(:CorrReportVolume, 9),
    # --- TRADE SUMMARY INFO ---
    TddsPrice(:HighPrice, 11),
    TddsPrice(:LowPrice, 11),
    TddsPrice(:LastPrice, 11),
    TddsAlpha(:LastSaleMarketCenter, 1),
    TddsAlpha(:LastCurrency, 3),
    TddsNumeric(:TotalVolume, 11),
    TddsPriceChange(:PriceChangeIndicator, 1)
  ]
end

def decode_general_admin_message
  decode_fields [
    TddsVariableText(:Text, 300)
  ]
end

def decode_closing_trade_summary_message
  decode_fields [
    TddsAlpha(:Symbol, 11),
    TddsPrice(:HighPrice, 11),
    TddsPrice(:LowPrice, 11),
    TddsAlpha(:ClosingPriceMarketCenter, 1),
    TddsPrice(:ClosingPrice, 11),
    LittleEndian(:Reserved, 1, hidden),
    TddsPrice(:NetChange, 11),
    TddsAlpha(:NetChangeDirection, 1),
    TddsAlpha(:Currency, 3),
    TddsNumeric(:TotalVolume, 11)
  ]
end

def decode_start_of_day_message
end

def decode_end_of_day_message
end

def decode_market_session_open_message
end

def decode_market_session_close_message
end

def decode_end_retran_requests_message
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

def decode_end_trade_reporting_message
end





# ----------------
end
end
end
