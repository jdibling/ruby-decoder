module Protocol
module Xmt
# -------------------

class GapCounter
  attr_reader :expected

  def initialize
    @expected = Hash.new(Hash.new(nil))
    yield self if block_given?
  end

  def gaps current
    source = current.source
    stream = current.stream

    return [] if !@expected.include?(source)
    return [] if @expected[source].nil?
    return [] if !@expected[source].include?(stream)

    expected_seq = @expected[source][stream]

    (Sequence.new(source, stream, expected_seq)...Sequence.new(source, stream, current.seq)).to_a
  end

  def expected=(current)
    source = current.source
    stream = current.stream
    seq = current.seq

    @expected[source][stream] = seq
  end
end

# -------------------
end
end
