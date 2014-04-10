require 'protocol/tql1/constants'
require 'protocol/tql1/field/all'

module Protocol
module Tql1
module Segment
# -----------------
module Decoder
  include Protocol::Xmt::Segment::Decoder
  include Protocol::Tql1::Constants
  include Protocol::Tql1::Field

  def decode_SymbolStatus_message
    decode_fields [
      # header
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:MsgVersion, 1),
      XmtString(:SourceId, 1),
      XmtBinary(:StreamId, 2),
      XmtBinary(:Sequence0, 1),
      XmtBinary(:Sequence, 4),
      # payload
      XmtString(:Symbol, 9),
      XmtBinary(:StockGroup, 1),
      XmtString(:Cusip, 12),
      XmtBinary(:BoardLot, 2),
      XmtString(:Currency, 1),
      XmtBinary(:FaceValue, 8),
      XmtBinary(:LastSale, 8)
    ]
  end

  def decode_EquityTrade_message
    decode_fields [
      # header
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:MsgVersion, 1),
      XmtString(:SourceId, 1),
      XmtBinary(:StreamId, 2),
      XmtBinary(:Sequence0, 1),
      XmtBinary(:Sequence, 4),
      # payload
      XmtString(:Symbol, 9),
      XmtBinary(:Price, 8),
      XmtBinary(:Volume, 4),
      XmtBinary(:BuyBrokerNumber, 2),
      XmtBinary(:SellBrokerNumber, 2),
      XmtBinary(:Bypass, 1),
      XmtBinary(:TradeTimeStamp, 4),
      XmtString(:SettlementTerms, 1),
      XmtString(:CrossType, 1),
      XmtBinary(:LastSalePrice, 8),
      XmtString(:OpeningTrade, 1)
    ]
  end
  def decode_EquityTradeCancelled_message
    decode_fields [
      # header
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:MsgVersion, 1),
      XmtString(:SourceId, 1),
      XmtBinary(:StreamId, 2),
      XmtBinary(:Sequence0, 1),
      XmtBinary(:Sequence, 4),
      # payload
      XmtString(:Symbol, 9),
      XmtBinary(:Volume, 4),
      XmtBinary(:Price, 8),
      XmtBinary(:BuyBrokerNumber, 2),
      XmtBinary(:SellBrokerNumber, 2),
      XmtBinary(:TradeTimeStamp, 4),
      XmtBinary(:LastSalePrice, 8)
    ]
  end

  def decode_MocImbalance_message
    decode_fields [
      # header
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:MsgVersion, 1),
      XmtString(:SourceId, 1),
      XmtBinary(:StreamId, 2),
      XmtBinary(:Sequence0, 1),
      XmtBinary(:Sequence, 4),
      # payload
      XmtString(:Symbol, 9),
      XmtString(:ImbalanceSide, 1),
      XmtBinary(:ImbalanceVolume, 4)
    ]
  end

  def decode_StockStatus_message
    decode_fields [
      # header
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:MsgVersion, 1),
      XmtString(:SourceId, 1),
      XmtBinary(:StreamId, 2),
      XmtBinary(:Sequence0, 1),
      XmtBinary(:Sequence, 4),
      # payload
      XmtString(:Symbol, 9),
      XmtString(:Comment, 40),
      XmtString(:StockState, 2),
      XmtBinary(:TradeSystemTimeStamp, 8),
      XmtBinary(:CalculatedClosingPrice, 4),
      XmtBinary(:Vwap, 4),
      XmtBinary(:ResumeTradeTime, 4)
    ]
  end

  def decode_EquityQuote_message
    decode_fields [
      # header
      XmtBinary(:MsgLength, 2),
      MsgType(:MsgType, 1),
      XmtBinary(:MsgVersion, 1),
      XmtString(:SourceId, 1),
      XmtBinary(:StreamId, 2),
      XmtBinary(:Sequence0, 1),
      XmtBinary(:Sequence, 4),
      # payload
      XmtString(:Symbol, 9),
      XmtBinary(:BidPrice, 8),
      XmtBinary(:BidSize, 4),
      XmtBinary(:AskPrice, 8),
      XmtBinary(:AskSize, 4)
    ]
  end
end

# -----------------
end
end
end

