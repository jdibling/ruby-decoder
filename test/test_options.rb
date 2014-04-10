#!/usr/bin/env ruby
# encoding: utf-8

=begin
require 'test/unit'
require_relative '../lib/decoder/options'
require_relative '../lib/decoder/handlers'

class TestOptions < Test::Unit::TestCase
  include Decoder::Feeds

  def test_verbose_on
    opts = Decoder::Options.new("-v otc".split(' '))
    assert_equal true, opts.verbose
  end

  def test_otc_decoder
    opts = Decoder::Options.new(["otc"])
    assert_equal opts.decoder[:Name], "otc"
  end

  def test_all_decoders
    handlers.each do |handler|
      opts = Decoder::Options.new([handler[:Name]])
      assert_equal opts.decoder[:Name], handler[:Name]
    end
  end

  def test_verbose_off_by_default
    opts = Decoder::Options.new([handlers[0][:Name]])
    assert_equal opts.verbose, false
  end


  private

  def default
    {
      :Decoder=> Feed.handlers[0]
    }
  end


end
=end

