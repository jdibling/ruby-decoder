Dir[File.dirname(__FILE__)+'/../feed/*.rb'].each do |handler_file|
  require_relative handler_file
end

module Decoder
  module Feeds
    def handlers
      Feed.constants.collect do |sym|
        mod = ["Feed", sym.to_s].inject(Object) { |memo, symbol| memo.const_get(symbol) }
        {
          :Protocol => sym,
          :Module => mod,
          :GapCounter => mod::GapCounter,
          :Name => sym.to_s.downcase,
          :Decoder => mod.const_get("Decoder")
        }
      end
    end
  end
end
