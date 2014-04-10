class Array
  def self.from_payload str
    str.strip!

    return [] if str.empty?
    raise "Malformed Payload String: 2 or 3 characters per byte expected, #{str.size} given." if str.size < 2
    raise "Malformed Payload String: Non-hex characters provided in '#{str}'" if (str =~ /^[\h| ]+$/).nil?

    
    pattern = case (str.size >= 3 && str[2] == " ")
              when true
                "a3" * ((str.size/3)+1)
              when false
                "a2" * (str.size/2)
              end

    str.unpack(pattern).collect {|x| x.hex}
  end
end
