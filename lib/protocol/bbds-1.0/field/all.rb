require 'protocol/bbds-1.0/field/alpha'
require 'protocol/bbds-1.0/field/numeric'
require 'protocol/bbds-1.0/field/date_time'
require 'protocol/bbds-1.0/field/price'
require 'protocol/bbds-1.0/field/price_change'
require 'protocol/bbds-1.0/field/variable_text'

module Protocol
module Bbds10 
module Field
  include Protocol::Binary::Field
end
end
end

