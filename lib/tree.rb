class Tree
  require './node'
  require './merge_sort'
  attr_accessor :data, :root

  def initialize(data)
    @data = merge_sort(data.uniq)
    @root = build_tree(@data)
  end

  def build_tree (an_arry = nil)
    return [] if an_arry.nil? || an_arry.empty?
    return Node.new(an_arry[0]) if an_arry.size == 1
    return Node.new(an_arry[1], Node.new(an_arry[0]).object_id) if an_arry.size == 2

    root_idx = (an_arry.size / 2.0).round - 1
    lhs_root = an_arry.size == 2 ? Node.new(an_arry[0]) : build_tree(an_arry[0..root_idx - 1]).object_id
    rhs_root = an_arry.size > 2 ? build_tree(an_arry[root_idx + 1...an_arry.size]).object_id : []

    Node.new(an_arry[root_idx], lhs_root, rhs_root)
  end
end
