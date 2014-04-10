module Protocol
module Otc
module Constants
# ----------------------------
MESSAGE_TYPES =
{
  1 => :Quote,
  2 => :QuoteUpdate,
  3 => :Inside,
  4 => :InsideUpdate,
  5 => :PriceLevel,
  6 => :PriceLevelUpdate,
  7 => :ReferencePrice,
  8 => :ReferencePriceUpdate,
  9 => :SecurityReference,
  11 => :StartOfSpin,
  12 => :EndOfSpin,
  13 => :MarketOpen,
  14 => :MarketClose,
  15 => :ExtendedSecurity,
  16 => :ExtendedSecurityNoCUSIP,
  17 => :Trade
}.freeze

TIERS = 
{
  0 => :NoTier,
  1 => :OTCQX_US_Prem,
  2 => :OTCQZ_US,
  5 => :OTCQX_Int_Prem,
  6 => :OTCQX_Int,
  10 => :OTCQB,
  11 => :OTCBB_Only,
  20 => :OTC_Pink_Cur,
  21 => :OTC_Pink_Ltd,
  22 => :OTC_Pink_NoInf,
  30 => :GreyMkt,
  50 => :OTC_Bonds
}.freeze

REPORTING_STATUSES = 
{
  "F" => :SECFiler,
  "B" => :Bank_Thrift,
  "I" => :Insurance,
  "R" => :FINRA,
  "G" => :Intl,
  "V" => :SECReporting,
  "A" => :Alternative,
  "O" => :Other,
  "N" => :None
}.freeze

SECY_ACTIONS = 
{
  1 => :Upd,
  2 => :Add,
  3 => :Del,
  4 => :Spn
}

SECY_STATUSES = 
{
  "A" => :Active,
  "S" => :Suspended,
  "H" => :Halted,
  "I" => :InternalHalt,
  "R" => :Revoked,
  "D" => :Deleted
}.freeze

ASSET_CLASSES = 
{
  0x01 => :Equity,
  0x02 => :FixInc
}.freeze

SPIN_TYPES = 
{
  1 => :Reference,
  2 => :MarketData,
  3 => :Opening
}.freeze
   

# ----------------------------
end
end
end
