require 'decoder/options'
require 'decoder/graceful_quit'
require 'global/array/from_payload'
require 'format/hex_array'
require 'format/payload_array'
require 'format/messages/standard'

module Decoder
  class App
    include Global::Options
    def initialize(argv)
      @@options = Decoder::Options.new(argv)
    end
    
    def self.verbose?
      @@options.verbose
    end
    
    def self.super_verbose?
      @@options.super_verbose
    end

    def self.payloads?
      @@options.payloads
    end

    def self.show_hidden?
      @@options.show_hidden
    end
  
    include Format::Messages::Standard

    def run
      GracefulQuit.enable

			$stderr.puts "*** Raw Stream Decoder ***" unless @@options.quiet
			$stderr.puts "Feed type: #{@@options.feed_name}" unless @@options.quiet
      $stderr.puts @@options if @@options.verbose

      packet_count = 0
      byte_count = 0

      start_time = Time.now

      @@options.input.each_line do |line|
        begin
          # handle early termination methods
          if GracefulQuit.check then
            $stderr.puts "Interrupted.  Shutting down."
            break
          end

          break if !@@options.packet_count.nil? && packet_count > @@options.packet_count

          # process the packet
          bytes = Array.from_payload line
          next if bytes.empty?
          decoded_messages = @@options.decoder.decode bytes 
          packet_count += 1
          byte_count += bytes.size

          # print each packet
          puts print_messages decoded_messages
        rescue RuntimeError => e
          $stderr.puts e.message
        end
      end

      stop_time = Time.now

      # output stream
      @@options.output.close

      # report statistics
      duration = stop_time - start_time
      speed = {
        :Packets => (packet_count/duration).to_i,
        :Bytes => (byte_count/duration).to_i
      }
      $stderr.puts "Elapsed time: #{duration.round 2} seconds."
      $stderr.puts "Processed #{packet_count} packets (#{speed[:Packets]} packets/second)"
      $stderr.puts "Processed #{byte_count} bytes (#{speed[:Bytes]} bytes/second)"

    end
  end   
end
