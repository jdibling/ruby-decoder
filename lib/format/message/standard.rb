require 'format/field/standard'

module Format
module Message
module Standard

include Format::Field::Standard
# --------------------
def self.print field_hash={}
  field_hash.collect {|id, value| Format::Field::Standard.print id, value}.join Format::Field::Standard::delim
end
# --------------------
end
end
end
