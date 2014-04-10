decoder 
========

'decoder' is a network protocol decoder, a la a WireShark dissector.  But 'decoder' doesn't use or rely on WireShark.  Instead, it takes a raw stream of bytes and emits decoded packets.  This is written entirely in Ruby, and requires Ruby 1.9.3 for now, although I may be able to make it compatible with 1.8.7 eventually.

The motivation behind writing 'decoder' is my everyday life as a software engineer for a market data (stock/options/commodities markets) provider.  In that job, I write new feed handlers and maintain existing feed handlers for various financial exchanges throughout the world.  I also help a great deal with support in troubleshooting problems.  Very often I need to examine captured packets or live market streams, but reading a raw binary stream gives me a headache.  So I started writing a decoder.

'decoder' began life as a little utility for one specific exchange, OTC Markets (Pink Sheets).  I wrote this Alpha version of 'decoder' out of necessity.  We were having problems that were very hard to track down without examining raw packets, and because of the nature of this feed it is especially headache-inducing to decode this feed exclusively within grey matter.


The Alpha version of 'decoder' proved extremely useful, and I was able to quickly prove that the problem we were having was not because of our code, but because of gaps on the line -- this was a problem either with our data provider or with the exchange itself.

The Alpha version then grew in to a Beta version, which was not specific to OTC Markets, but instead was an entire suite of decoders for many different exchanges.  The Beta version uses a dynamic method to discover which feeds it is caable of decoding, and can be invoked by naming that feed along with the source of the stream.  For example:

  zless /capture/OTC.cap.txt.gx | ./decoder otc
  
This version grew in functionality over time, and I began to discover some of the limitations imposed by my original design.  I also became more proficient at Ruby programming during this excercise, and saw that many of the things that I was doing were not very Rubyist.  One of the deficiencies I found with the Beta version was it was harder than it should be to write a new decoder.  After thinking about how to solve this problem, along with quite a bit of reading and scouring of stackoverflow and various blogs, I came upon the genesis of an idea to improve the Beta version.  Thus this later iteration was born.

This is still very much a work in progress, and most of the basic functionality is still lacking.  As I progress, I will continue pushing commits and making updates to this readme.

I hope you enjoy watching my progress and find some value in the finished product!

=== TODO LIST ===

D01: Packets with more than one message:  messages are all printed on same line
D02: Packet:  payload should include entire frame
D03: TQL1:  add some further processing for fields
D04: Implement sequencing
D05: Implement gap counting
D06: Implement attribute evaluation
D07: Implement statistic gathering
D08: Implement testing


