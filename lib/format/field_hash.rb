module Format
module DecodedFieldHashPrinter
# ---------------
module SVerbose
  def to_s
    [
      "Fields (#{self[:Fields].size}):",
      "#{self[:Fields].collect {|k,v| "\t#{k}<#{v}>"}.join("\n")}",
      "Attributes: (#{self[:Attributes].size}):",
      self[:Attributes].collect {|k,v| "\t#{k} = #{v}"}.join("\n"),
      "Payload: (#{self[:Payload].size} bytes): [#{self[:Payload].flatten.collect {|x| sprintf("%0.2X", x)}.join(' ')}]"
    ].join("\n")
  end
end

module Silent
  def to_s
  end
end
# ---------------
end
end

