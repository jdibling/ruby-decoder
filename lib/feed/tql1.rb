require 'protocol/xmt/packet/decoder'
require 'protocol/xmt/gap_counter'

require 'protocol/tql1/field/msg_type'

require 'protocol/tql1/segment/decoder'

module Feed
module Tql1 
# ---------------
GapCounter = Protocol::Xmt::GapCounter

class Decoder
  def initialize
    cls = Class.new do
      include Protocol::Tql1::Segment::Decoder
    end
    @decoder = Protocol::Xmt::Packet::Decoder.new
    @decoder.seg_decoder=Protocol::Tql1::Segment::Decoder
  end

  def decode(packet=[])
    @decoder.decode packet
  end
end
# ---------------
end
end

