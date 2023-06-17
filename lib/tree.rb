class Tree
  require './lib/node'
  require './lib/merge_sort'
  attr_accessor :data, :root

  def initialize(data)
    @data = merge_sort(data.uniq)
    @root = build_tree(@data)
  end

  def build_tree(an_arry = nil)
    return [] if an_arry.nil? || an_arry.empty?
    return Node.new(an_arry[0]) if an_arry.size == 1
    return Node.new(an_arry[1], Node.new(an_arry[0]).object_id) if an_arry.size == 2

    root_idx = (an_arry.size / 2.0).round - 1
    lhs_root = an_arry.size == 2 ? Node.new(an_arry[0]) : build_tree(an_arry[0..root_idx - 1]).object_id
    rhs_root = an_arry.size > 2 ? build_tree(an_arry[root_idx + 1...an_arry.size]).object_id : []
    Node.new(an_arry[root_idx], lhs_root, rhs_root)
  end

  def insert(value)
    return if @root.data == value

    new_node = Node.new(value)
    next_addrs = @root.compare(new_node)
    until next_addrs.nil?
      parent_node = ObjectSpace._id2ref(next_addrs)
      return if parent_node.data == value

      next_addrs = parent_node.compare(new_node)
    end
    (parent_node <=> new_node) == 1 ? (parent_node.left = new_node.object_id) : (parent_node.right = new_node.object_id)
  end

  def delete(value)
    return if @root.data == value

    bye_node = find(value)
    return if bye_node.data.nil?

    parent_node = get_parent(value)
    if bye_node.left.nil? && bye_node.right.nil?
      parent_node.left == bye_node.object_id ? parent_node.left = nil : parent_node.right = nil
    elsif bye_node.left.nil? && !bye_node.right.nil?
      parent_node.left == bye_node.object_id ? parent_node.left = bye_node.right : parent_node.right = bye_node.right
    elsif !bye_node.left.nil? && bye_node.right.nil?
      parent_node.left == bye_node.object_id ? parent_node.left = bye_node.left : parent_node.right = bye_node.left
    else
      del_with_2_child(bye_node)
    end
  end

  def del_with_2_child(bye_node)
    parent_node = get_parent(bye_node.data)
    replacement = get_lowest_RHS_Node(bye_node)
    lowest_parent = get_parent(replacement.data)
    replacement.right = bye_node.right
    replacement.left = bye_node.left
    parent_node.right == bye_node.object_id ? parent_node.right = replacement.object_id : parent_node.left =replacement.object_id
    lowest_parent.left = nil
  end

  def get_lowest_RHS_Node(a_node)
    next_addrs =  a_node.right
    until ObjectSpace._id2ref(next_addrs).left.nil?
      next_addrs = ObjectSpace._id2ref(next_addrs).left
    end
    ObjectSpace._id2ref(next_addrs)
  end

    def get_parent(value)
    return if @root.data == value

    child_node = Node.new(value)
    next_addrs = @root.object_id
    parent_addrs = @root
    until (ObjectSpace._id2ref(next_addrs) <=> child_node).zero?
      parent_addrs = next_addrs
      next_addrs = ObjectSpace._id2ref(next_addrs).compare(child_node)
      return Node.new if next_addrs.nil?
    end
    ObjectSpace._id2ref(parent_addrs)
  end

  def find(value)
    return Node.new if @root.data == value

    new_node = Node.new(value)
    next_addrs = @root.object_id
    until (ObjectSpace._id2ref(next_addrs) <=> new_node).zero?
      next_addrs = ObjectSpace._id2ref(next_addrs).compare(new_node)
      return Node.new if next_addrs.nil?

    end
    ObjectSpace._id2ref(next_addrs)
  end

  def level_order
    level_ary = [@root]
    until level_ary.empty?
      current_node = level_ary[0]
      yield current_node
      level_ary.push(ObjectSpace._id2ref(current_node.left)) unless current_node.left.nil?
      level_ary.push(ObjectSpace._id2ref(current_node.right)) unless current_node.right.nil?
      level_ary.delete_at(0)
    end
  end

  def level_order_recur(a_node = @root, &block)
    block.call(a_node)
    level_order_recur(ObjectSpace._id2ref(a_node.left), &block) unless a_node.left.nil?
    level_order_recur(ObjectSpace._id2ref(a_node.right), &block) unless a_node.right.nil?
  end
end
