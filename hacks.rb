#!/usr/bin/env ruby
require 'csv'

source = [
  "99|110384",
  "100|10385",
  "101|10385",
  "102|10386",
  "103|10386",
  "104|10387"
].join("\n")

source = CSV.parse(source, :col_sep => "|")

hh = source.inject({}) do |memo, row|
  sku = row[0]
  prod = row[1]

  memo[prod] = [] unless memo.include?(prod)
  memo[prod] << sku
  memo
end

puts hh
   

