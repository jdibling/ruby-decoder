require 'test/unit'

require 'fields/attributes/all'

class MockDecoder
  attr_accessor :decoded, :iter, :rewind
  def initialize
    @decoded = {}
    @rewind = 0
    yield self if block_given?
  end
end

class MockField
  attr_accessor :id, :length
  def initialize 
    yield self if block_given?
  end
end

class MockOptions
  def sverb?
    return false
  end

end

class MockApp
  attr_reader :options, :decoder
  def initialize
    @options = MockOptions.new
    @decoder = MockDecoder.new
  end
end

module Global
module Options
  Decoder = ::MockDecoder
  App = ::MockApp
end
end

class TestExpectedValueFieldAttribute < Test::Unit::TestCase
  include Fields::Attributes

  def test_construct
    attributes = expected_value "X"
    assert_equal Array, attributes.class
    assert_equal 1, attributes.size
  end

  def test_evaluate
    decoder = MockDecoder.new do |d|
      d.decoded=({:Test=>"X"})
    end
    field = MockField.new do |f|
      f.id = :Test
    end

    attributes = expected_value "X"
    assert_nothing_raised do
      assert_equal true, attributes[0].evaluate(field, decoder)
    end
    assert_equal true, attributes[0].evaluate(field, decoder)
  end
end

class TestPeekAheadFieldAttribute < Test::Unit::TestCase
  include Fields::Attributes

  def test_construct
    attributes = peek_ahead
    assert_equal Array, attributes.class
    assert_equal 1, attributes.size
  end

  def test_evaluate
    decoder = MockDecoder.new do |d|
      d.iter = 0
    end
    field = MockField.new do |f|
      f.id = :Test
      f.length = 20
    end

    attributes = peek_ahead
    assert_nothing_raised do
      attributes[0].evaluate(field, decoder)
    end
    assert_equal 0, decoder.iter
  end
end

class TestLookupFieldAttribute < Test::Unit::TestCase
  attr_accessor :map

  include Fields::Attributes


  def test_construct
    attributes = lookup(map)
    assert_equal Array, attributes.class
    assert_equal 1, attributes.size
  end

  def test_evaluate
    @map = {"A" => :Foo}
    
    decoder = MockDecoder.new do |d|
      d.decoded= {:Test => "A"}
    end
    field = MockField.new do |f|
      f.id = :Test
      f.length = 1
    end

    attributes = lookup @map
    decoded = nil
    assert_nothing_raised do
      decoded = attributes[0].evaluate(field, decoder)
    end
    assert_equal :Foo, decoded
    assert_equal :Foo, decoder.decoded[field.id]
  end
end



