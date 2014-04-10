module Protocol
module Xmt
# ---------------------

class Sequence
  include Enumerable
  include Comparable

  attr_reader :source, :stream, :seq
  def initialize(source, stream, seq)
    @source = source
    @stream = stream
    @seq = seq
  end

  def <=>(other)
    source <=> other.source if source != other.source
    stream <=> other.stream if stream != other.stream
    seq <=> seq
  end
end

# ---------------------
end
end

