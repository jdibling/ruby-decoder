require 'protocol/xmt/constants'

module Protocol
module Tql1
module Constants
# ---------------
MSG_TYPES = Protocol::Xmt::Constants::MSG_TYPES.merge ({
  0x4A => :SymbolStatus,
  0x73 => :EquityTrade,
  0x74 => :EquityTradeCancelled,
  0x75 => :MocImbalance,
  0x76 => :StockStatus,
  0x77 => :EquityQuote
})
# ---------------
end
end
end
