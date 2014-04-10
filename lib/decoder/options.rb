# =============================================
#	Options Parser
#
require 'zlib'
require_relative '../trollop/trollop'

require_relative 'handlers'

module Decoder

  class Options
    include Decoder::Feeds

    attr_reader :payloads, :input, :verbose, :quiet, :decoder, :output, :packet_count, :gap_counter, :feed_name, :super_verbose, :show_hidden

    def initialize(argv)
      parse(argv)
      puts self.to_s if verbose
    end

    def to_s
      lines = []
      lines << "Payloads: #{@payloads}"
      lines << "Input File: #{@input.inspect}"
      lines << "Output File: #{output.inspect}"
      lines << "Verbose: #{@verbose}"
      lines << "Decoder: #{@decoder}"
      lines << "Stopping after #{packet_count} packets" if !packet_count.nil?
      lines << "SHowing hidden fields" if @show_hidden
      lines.join("\n")
    end

  private
    
    def help_banner
      lines = []
      lines << "Stream Decoder"
      lines << nil
      lines << "usage: #{File.basename(__FILE__)} [global-options] decoder [decoder-options]"
      lines << nil
      lines << "*** Decoders ***"
      lines << nil
      lines << handlers.collect{|h| h[:Name]}.join(',')
      lines << nil
      lines << "*** Global Options ***"
      lines << nil

      lines.join("\n")
    end

    def parse(argv)
      # parse global options
      handler_names = handlers.collect {|h| h[:Name]}
      h_banner = help_banner
      global_parser = Trollop::Parser.new do
        banner h_banner
        opt :verbose, "(Don't) be verbose.", :short => "v", default: false
        opt :super_verbose, "Be super verbose.", :short => "V", default: false
        opt :payloads, "(Don't) print payloads.", default: false
        opt :input, "Input source. May be a file or redirected input.", :type => :io, :short => "i", :default => $stdin
        opt :output, "Output file.  May be a file or a redirected output.", :short => "o", :default => "<stdout>"       
        opt :packet_count, "Decode (n) packets and quit.", :short => "n", :type => :integer, :default => nil
        opt :decompress_gzip, "Decompress gzipped input.", :short => "z", default: false 
        opt :compress_gzip, "Compress gzipped output.", :short => "Z", default: false
        opt :quiet, "(Don't) be quiet.", :short => "q", default: false
        opt :hidden_fields, "Show hidden fields", default: false 
        stop_on_unknown
      end

      options = Trollop::with_standard_exception_handling global_parser do
        global_parser.parse(argv)
      end
    
      @input = case options[:decompress_gzip]
        when true
          Zlib::GzipReader.new(options[:input])
        when false
          options[:input]
        end

      # Trollop assumes all IO arguments are for input.  This is a workaround
      out = if options[:output] =~ /^<?stdout>?$/i
        $stdout
      else
        File.new(options[:output], "w")
      end
      @output = case options[:compress_gzip] 
        when true
          Zlib::GzipWriter.new(out)
        when false
          out
        end
      @verbose = options[:verbose] || options[:super_verbose]
      @super_verbose = options[:super_verbose]
      @quiet = options[:quiet]
      @packet_count = options[:packet_count]
      @payloads = options[:payloads] || @verbose
      @show_hidden = options[:hidden_fields] || @verbose

      # check various options for validity
      begin
         raise ArgumentError, "Can't be --verbose and --quiet at the same time." if @verbose && @quiet
      rescue Exception => e
        $stderr.puts e.message
        $stderr.puts "Try --help for more info"
        exit
      end

      # parse decoder
      decoder_parser = Trollop::Parser.new do
        banner h_banner
      end

      begin
        handler = Trollop::with_standard_exception_handling decoder_parser do
          decoder_name = argv.shift
          raise(ArgumentError, "Decoder not specified") if decoder_name.nil? || decoder_name.empty?
          matching_handlers = handlers.select{|handler| handler[:Name] == decoder_name.downcase}
          raise ArgumentError, "Unknown decoder '#{decoder_name}'.  Must be one of: #{handlers.collect{|handler| handler[:Name]}.join(', ')}" if matching_handlers.empty?
          raise ArgumentError, "Multiple decoder matches: #{matching_handlers.collect{|m| m[:Name]}.join(', ')} -- select one." if matching_handlers.count > 1
          matching_handlers[0]
        end
      rescue Exception => e
        $stderr.puts e.message
        $stderr.puts "Try --help for more info."
        exit
      end

      @decoder = handler[:Decoder].new do |decoder|
        dec.parse_options if argv
      end
      @gap_counter = handler[:GapCounter].new
      @feed_name = handler[:Name]

    end
  end
end
