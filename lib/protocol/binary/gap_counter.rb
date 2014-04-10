module Protocol
module Binary
# -------------------
class GapCounter
  attr_reader :expected

  def initialize
    @expected = nil
  end

  def gaps current
    return [] if @expected.nil? 
    (@expected...current).collect {|gap| gap }
  end

  def expected=(expected)
    @expected = expected
  end
end
# -------------------
end
end
