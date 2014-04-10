require 'global/options'

require 'fields/attributes/basic'

module Fields
module Attributes
# --------------------
class Hidden < BasicAttribute
  include Global::Options

  def evaluate field, decoder
    decoder.decoded.delete field.id unless show_hidden?
  end

  def to_s
    "Hidden"
  end
end

def hidden
  [Hidden.new]
end

# --------------------
end
end

