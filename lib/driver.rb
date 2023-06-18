require './lib/tree'
require './lib/merge_sort'

def print_out(t)
  puts "\nlevel order traverse"
  t. level_order_recur { |node| print "#{node.data}, " }
  puts "\ndepth pre traverse"
  t.depth_first_pre { |node| print "#{node}, " }
  puts "\ndepth post traverse"
  t.depth_first_post { |node| print "#{node}, " }
  puts "\ndepth inline traverse"
  t.depth_first_inline { |node| print "#{node}, " }
end

ary = Array.new(20){ rand(1...100) }
t = Tree.new(ary)
puts "\nBalanced? #{t.balanced}"
print_out(t)
300.times { t.insert(rand(1..100)) }
puts "\nBalanced? #{t.balanced}"
t.rebalance
puts "\nBalanced? #{t.balanced}"
print_out(t)
