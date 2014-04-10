require 'protocol/binary/field/all'
require 'protocol/binary/field/ascii_string'

module Protocol
module Tdds10
module Field
# ------------------
class TddsAlphaField < Protocol::Binary::Field::AsciiStringField
  def decode(bytes=[])
    super.rstrip
  end
end

def TddsAlpha(id, length, attributes={})
  TddsAlphaField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end

