require 'protocol/binary/gap_counter'
require 'protocol/binary/constants'

require 'protocol/tdds-1.0/packet/decoder'

module Feed
module Tdds
# -----------------

GapCounter = Protocol::Binary::GapCounter

class Decoder 
  include Protocol::Binary::Constants

  def proto_ver?
    "1.0"
  end

  def initialize
    decoder_cls = Class.new do
      include Protocol::Tdds::Packet
  #    include Field::Attributes
    end
    @decoder = decoder_cls.new
  end

  def decode(bytes=[])
    # TDDS packets are laied out as follows:
    #
    # [SOH] Hdr+Msg [US] Hdr+Msg [US] Msg+Hdr [ETX]
    #

    raise "Malformed Packet: First Byte expected SOH, but was #{bytes[0].to_s(16)}" if bytes[0] != SOH

    # split payload in to arrays of bytes, 1 element per message
    payloads = bytes[1...-1].chunk { |n| n == US } .reject {|k,v| k}.map {|k,v| v}
    messages = payloads.collect do |payload|
      @decoder.decode payload
    end

    [{:Fields=>{:SOH=>SOH, :PacketLength => bytes.size, :ETX => ETX}, :Payload=>bytes.extend(Format::HexArray), :Messages => messages}]

  end
end
# -----------------
end
end


