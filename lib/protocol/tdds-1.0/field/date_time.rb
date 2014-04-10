require 'protocol/tdds-1.0/field/alpha'

module Protocol
module Tdds10
module Field
# ------------------
class TddsDateTimeField < TddsAlphaField
  def decode(bytes=[])
    str = super
    adj = 48
    
    year = str[0..1].to_i + 2000
    month = str[2].ord - adj
    day = str[3].ord - adj
    hour = str[4].ord - adj
    min = str[5].ord - adj
    sec = str[6].ord - adj

    time = Time.mktime(year, month, day, hour, min, sec)
    time.strftime("%Y/%m/%d %H:%M:%S")
  end
end

def TddsDateTime(id, length, attributes={})
  TddsDateTimeField.new do |f|
    f.id = id
    f.length = length
    f.attributes = attributes
  end
end
# ------------------
end
end
end
