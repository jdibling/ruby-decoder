require 'global/options'
require 'protocol/binary/constants'
require 'protocol/xmt/segment/decoder'

module Protocol
module Xmt
module Packet 
# -----------------
class Decoder
  include Global::Options
  
  attr_reader :seg_decoder

  def initialize
    yield self if block_given?
  end

  def seg_decoder=(seg_dec)
    seg_decoder_class = Class.new do
      include seg_dec
      include Protocol::Xmt::Segment::Decoder
    end
    @seg_decoder=seg_decoder_class.new
  end
  
  def decode(bytes)
    seg_decoder.set_payload bytes
  
    packet_hdr = seg_decoder.decode_packet_header

    # Get the one and only adm header if this is an adm packet
    adm_hdr = seg_decoder.decode_adm_header
    # process each message
    messages = packet_hdr[:Fields][:NumBody].times.collect do
      msg_type = case adm_hdr.nil?
                 when false
                   adm_hdr[:Fields][:MsgType]
                 when true
                   seg_decoder.peek_msg_type
                 end
      # decode the bus message header, if this is a bus message
      send_sym  = "decode_#{msg_type}_message".to_sym
      seg_decoder.send(send_sym)
    end

    # if this is an adm packet, append the adm header to the first decoded message
    unless adm_hdr.nil? 
      messages = messages.insert(0, adm_hdr)
    end

    packet_hdr[:Messages] = messages
    [packet_hdr]
  end
end
# -----------------
end
end
end


