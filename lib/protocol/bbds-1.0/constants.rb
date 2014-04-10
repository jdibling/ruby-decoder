module Protocol
module Bbds10
# ----------------------
module Constants
  MESSAGE_TYPES =
  {
    # ------------------------------
    :MarketParticipantQuoteUpdate =>  "Q1",
    # ------------------------------
    :StartOfDay =>                    "CI",
    :EndOfDay =>                      "CJ",
    :MarketSessionOpen =>             "CO",
    :MarketSessionClose =>            "CC",
    :EmergencyMarketHalt =>           "CA",
    :EmergencyMarketResume =>         "CB",
    :EndTransmissions =>              "CZ",
    :StartTestCycle =>                "CM",
    :EndTestCycle =>                  "CN",
    :LineIntegrity =>                 "CT",
    :SequenceReset =>                 "CL",
    # ------------------------------
    :GeneralAdmin =>                  "AA",
    :TradingAction =>                 "AH",
  }.freeze

  MESSAGE_TYPE_CODES = MESSAGE_TYPES.invert.freeze

  RETRAN_CODE =
  {
    "O" => :Original,
    "R" => :Retransmission,
    "T" => :TestCycle
  }.freeze 

  MARKET_CENTERS =
  {
    "U" => :OTCBB,
    "u" => :NonOTCBB,
    "Q" => :NasdaqOMX,
    "E" => :MarketIndependant
  }.freeze

  OTCBB_TYPES =
  {
    "I" => :IndicativeSecurityQuote,
    "K" => :RealTimeQuote,
    "L" => :IndicativeQuote
  }.freeze

  MARKET_PARTICIPANT_LOCATIONS =
  {
    "Z" => :MainOffice,
    "#" => :Ecn
  }.freeze

  MARKET_PARTICIPANT_STATUS =
  {
    "A" => :Active,
    "D" => :Deleted,
    "E" => :Excused,
    "W" => :Withdrawn,
    "S" => :Suspended
  }.freeze

  MARKET_PARTICIPANT_QUOTE_CONDITION =
  {
    "O" => :Open,
    "C" => :Closed
  }.freeze

  BID_OFFER_WANTED_INDICATOR =
  {
    "B" => :BidWanted,
    "N" => :NotApplicable,
    "O" => :OfferWanted,
    "W" => :BothWanted
  }.freeze

  UNSOLICITED_INDICATOR =
  { 
    "A" => :Ask,
    "B" => :Bid,
    "U" => :BidAndAsk,
    "" => :NotApplicable
  }.freeze

  INSIDE_APPENDAGE_INDICATOR =
  {
    1 => :NoInsideChange,
    2 => :NoInside,
    3 => :AppendageAttached
  }.freeze

  INSIDE_QUOTE_CONDITION =
  {
    "O" => :Open,
    "C" => :Closed
  }.freeze

  ACTION =
  {
    "H" => :Halt,
    "Q" => :QuotationResume,
    "T" => :TradingResume
  }.freeze

  REASON =
  {
    "T1" => :HaltNewsPending,
    "T2" => :HaltNewsDissemination,
    "T12" => :HaltFINRA,
    "H10" => :HaltSECTradingSuspension,
    "H11" => :HaltRegulatoryConcern,
    "H12" => :HaltSECRevocation,
    "U1" => :HaltForeignMarketRegulatory,
    "U2" => :HaltComponentOfListedSecurity,
    "U3" => :HaltExtraordinaryEvents,
    "O1" => :OperationsHalt_ContactOperations,
    "D" => :SecurityDeletionFromOTCBB,
    "T3" => :NewsAndResumptionTimes,
    "R4" => :IssuesReviewed_ToResume,
    "R9" => :HaltConcluded_ToResume,
    "C11" => :HaltConcluded_ToResume,
    "" => :ReasonNotAvailable
  }.freeze


end
# ----------------------
end
end


