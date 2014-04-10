module Protocol
module Tdds10
# ----------------------
module Constants
  MESSAGE_TYPES =
  {
    :StartOfDay =>          "CI",
    :EndOfDay =>            "CJ",
    :MarketSessionOpen =>   "CO",
    :MarketSessionClose =>  "CC",
    :EndRetranRequests =>   "CK",
    :EndTransmissions =>    "CZ",
    # ----------------------------
    :StartTestCycle =>      "CM",
    :EndTestCycle =>        "CN",
    :LineIntegrity =>       "CT",
    :SequenceReset =>       "CL",
    :EndTradeReporting =>   "CX",
    # ----------------------------
    :ShortFormTradeReport => "T1",
    :LongFormTradeReport => "T2",
    :TradeCancelError =>    "T3",
    :TradeCorrection =>     "T4",
    # ----------------------------
    :GeneralAdmin =>        "AA",
    :ClosingTradeSummary => "A1"
  }.freeze

  MESSAGE_TYPE_CODES = MESSAGE_TYPES.invert.freeze

  PRICE_DENOMS = 
  {
    "B" => 100,
    "C" => 1000,
    "D" => 10000
  }.freeze

  FUNCTIONS =
  {
    "C" => :Cancel,
    "E" => :Error
  }.freeze

  SALE_CONDITIONS = 
  {
    "@" => :RegularTrade,
    "C" => :CashTrade,
    "I" => :OddLotTrade,
    "N" => :NextDay,
    "P" => :PriorReferencePrice,
    "R" => :Seller,
    "T" => :OutsideMarketHours,
    "U" => :OutsideMarketHoursAndReportedLate,
    "W" => :AveragePriceTrade,
    "Z" => :ReportedLate
  }.freeze
end
# ----------------------
end
end


