require './lib/tree'
require './lib/merge_sort'

t = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])

t.build_tree
#t.delete(5)
12.times {|i| t.delete(i)}
print t.depth_first_inline
puts t.balanced
t.rebalance
puts t.root.data
puts
