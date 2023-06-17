require './lib/tree'
require './lib/merge_sort'

t = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30])

t.build_tree
t.depth_first_preorder { |node| puts node.data }