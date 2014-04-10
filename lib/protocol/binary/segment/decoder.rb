require 'global/options'
require 'format/field_hash'
require 'format/hex_array'

require 'fields/attributes/all'

module Protocol
module Binary
module Segment 
module Decoder
# ---------------------
include Global::Options

attr_reader :payload, :decoded

def iter
  @iter
end

def rewind=(count)
  @rewind = count
  $stderr.puts "[#{object_id}]: Set rewind to #{rewind}" if sverb?
end

def rewind
  @rewind = 0 if @rewind.nil?
  $stderr.puts "[#{object_id}]: Accessing rewind (#{@rewind})" if sverb?
  @rewind
end

def parse_options(argv)
end

def set_payload(bytes)
  @payload = bytes
  @payload.extend(Format::PayloadArray) if verb?
  @iter = 0
end

def decode_fields(fields=[])
  @rewind = 0
  if sverb? then
    $stderr.puts "*"*80
    decode_len = fields.reduce(0) {|t,f| t + f.length}
    $stderr.puts "[#{object_id}] : Decoding #{fields.size} fields. Iter=#{@iter}, Decode Length=#{decode_len}\n"
    $stderr.puts fields.collect {|field| "\tID=#{field.id}, Len=#{field.length}, Attributes(#{field.attributes.size})=#{field.attributes}"}.join("\n")
    bytes = " #{payload.to_s} "
    bytes[@iter*2] = '<'
    bytes[(@iter + decode_len)*2] = '>'
    $stderr.puts "[#{object_id}]: Payload: [#{@iter}/#{decode_len}] #{bytes}"
    $stderr.puts "-"*80
  end

  decoded_payload = []
  @decoded = {}

    fields.each do |field|
      # Decode each field in the range
      begin
        @decoded[field.id] =  field.do_decode(self)
      rescue StandardError => e
        $stderr.puts e
        byte_range = payload[@iter...@iter+field.length]
        payload.extend(Format::PayloadArray)
        full_payload = (payload[0...@iter].extend(Format::PayloadArray).to_s) + "<" + (payload[@iter...@iter+field.length].extend(Format::PayloadArray).to_s) + ">" + (payload[@iter+field.length..payload.size].extend(Format::PayloadArray).to_s)
        
        $stderr.puts "Full Payload=#{full_payload}"
        exit
      end

      # Evaluate field attributes
      begin
        field.attributes.each do |attr|
          attr.evaluate field, self
        end
      rescue Fields::Attributes::AttributeEvalError => e
        $stderr.puts "*** ERROR EVALUATING FIELD ATTRIBUTES ***"
        $stderr.puts "#{e} : Attribute=#{e.attribute}, Field=#{e.field}, Decoded=#{e.decoded}"
        $stderr.puts "Payload: #{payload.to_s}"
        $stderr.puts "#{fields.size} Fields: \n#{fields.collect {|field| "\t[#{field.class}] : ID=#{field.id}, Len=#{field.length}, Attributes(#{field.attributes.size})=#{field.attributes}"}.join("\n")}"
        $stderr.puts "Aborting."
        exit 
      end

      # Update pointers
      @iter += field.length

      # Update payload
      decoded_payload << payload[@iter...@iter+field.length]
      
      # Verbose output
      byte_range = payload[@iter...@iter+field.length] if sverb?
      $stderr.puts "\t#{field.id}<#{@decoded[field.id]}>, Len:#{field.length}, Bytes: (#{byte_range.to_a.size}) #{byte_range.to_a.extend(Format::HexArray)}, Attributes: #{field.attributes}" if sverb?
    end
    
  $stderr.puts "^"*80 if sverb?

  @iter = (@iter - @rewind)          
  $stderr.puts "[#{object_id}] : Finished decoding.  Iter=#{@iter}, rewound=#{@rewind}" if sverb?
  $stderr.puts "=" if sverb?

  decoded_hash = {
    :Fields => @decoded,
    #:Attributes => decoded_attributes,
    :Payload => decoded_payload.flatten
  }
  decoded_hash.extend(Format::DecodedFieldHashPrinter::SVerbose) if sverb?
  decoded_hash
end
# ---------------------
end
end
end
end


