require 'protocol/tdds-1.0/field/alpha'
require 'protocol/tdds-1.0/field/numeric'
require 'protocol/tdds-1.0/field/date_time'
require 'protocol/tdds-1.0/field/price'
require 'protocol/tdds-1.0/field/price_change'
require 'protocol/tdds-1.0/field/variable_text'

module Protocol
module Tdds10
module Field
  include Protocol::Binary::Field
end
end
end


