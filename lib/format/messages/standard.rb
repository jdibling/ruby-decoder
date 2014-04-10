require 'global/options'
require 'format/message/standard'

module Format
module Messages
module Standard
# ------------------
include Global::Options

def print_messages msg_array=[], indent=0
  tab = "\t" * indent
 
  rows = msg_array.collect do |msg|  
    row = "#{tab}#{Format::Message::Standard.print msg[:Fields]}" 
    row += Format::Field::Standard.delim + Format::Field::Standard.print(:Payload, msg[:Payload]) if payloads?

    rows = [row]
    rows += [print_messages(msg[:Messages], indent+1)] if msg.include?(:Messages)

    rows
  end

  rows.join("\n")
end
# ------------------
end
end
end
