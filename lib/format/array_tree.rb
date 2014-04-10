include 'format/hash_tree'

module Format
module ArrayTree
# --------------------------------
include HashTree
def array_tree(array=[], level=0)
  tab = "\t"*level
  array.each_index do |i|
    item = case
           when array[i].is_a?(Hash)
             "(Hash)"
           when array[i].is_a?(Array)
             "(Array)"
           else
             array[i].to_s
          end
          
    p = "#{tab}[#{i}] : #{item}"
    puts p
    hash_tree(array[i],level+1) if array[i].is_a?(Hash)
    array_tree(array[i], level+1) if array[i].is_a?(Array)
  end
end
# -----------------------------------
end
end

