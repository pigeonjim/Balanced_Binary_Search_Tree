require './lib/tree'
require './lib/merge_sort'

t = Tree.new([3,4,2,8,3,6,9,2,200,16000,14,15,22,11])

puts merge_sort(t.data).join' '
puts
t.build_tree
puts t.insert(10)
