module Fields
# --------------------
class BasicField
  attr_reader :id, :attributes, :length
  attr_accessor :decoded

  def to_s
    describe
  end

  def length
    0
  end

  def initialize
    yield self if block_given?
  end

  def id=(id)
    @id = id
  end

  def attributes=(attributes={})
    @attributes = attributes
  end

  def describe
    "Class: #{self.class}, Id:#{id}, Attributes#{attributes}"
  end
end

#---------------------
end
