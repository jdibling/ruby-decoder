module Format
module Field
module Standard
# -------------------

def self.print id, value
  case id
  when :Payload
    "#{id}<#{print_payload value}>"
  else
    "#{id}<#{value}>"
  end    
end

def self.delim
  " "
end

def self.print_payload payload=[]
  payload.collect {|x| sprintf "%0.2X", x}.join("")
end

# -------------------
end
end
end
