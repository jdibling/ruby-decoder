require_relative 'tql1'

module Feed
  module Vql1

    include Feed::Tql1

    class Decoder < Feed::Tql1::Decoder
    end
  end
end

