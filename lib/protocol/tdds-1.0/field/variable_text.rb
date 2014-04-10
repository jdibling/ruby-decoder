require 'format/payload_array'

require 'fields/basic_field'

module Protocol
module Tdds10
module Field
# ---------------------------

class TddsVariableTextTooLongError < StandardError
  attr_reader :max_len, :actual_len, :field_id, :bytes
  def initialize field_id, max_len, actual_len, bytes
    @field_id = field_id
    @bytes = bytes
    @bytes.extend(Format::PayloadArray)
    @max_len = max_len
    @actual_len = actual_len
    super("#{@field_id} field must be <= #{@max_length} bytes, but is #{@actual_len} bytes: #{@bytes}.")
  end
end

class TddsVariableTextField < Fields::BasicField
  attr_reader :max_length

  def max_length=(max_length)
    @max_length = max_length
  end

  def do_decode(decoder)
    decode decoder.payload[decoder.iter...-1].to_a
  end

  def decode(bytes=[])
    raise TddsVariableTextTooLongError.new(id, @max_length, bytes.size, bytes) if bytes.size > @max_length
    decoded = bytes.reduce("") {|m,x| m + x.chr}
    raise ArgumentError, "#{id} payload must be printable, but has non-printable characters. Payload=[#{bytes.inspect}]" if decoded =~ /[^[:print:]]/ 
    decoded.strip
  end
end

def TddsVariableText(id, max_length, attributes={})
  TddsVariableTextField.new do |f|
    f.id = id
    f.max_length = max_length
    f.attributes = attributes
  end
end
# ---------------------------
end
end
end
