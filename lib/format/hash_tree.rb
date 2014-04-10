require 'format/array_tree.rb'

module Format
module HashTree
# -----------------
include ArrayTree

def hash_tree(hash={}, level=0)
  tab = "\t"*level
  hash.each do |k,v|
    p = "#{tab}#{k} => (#{v.class}) #{v.to_s unless v.is_a?(Hash) || v.is_a?(Array)}"
    puts p
    hash_tree(v,level+1) if v.is_a?(Hash)
    array_tree(v, level+1) if v.is_a?(Array)
  end
end
# -----------------
end
end

