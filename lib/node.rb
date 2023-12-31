class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    @data <=> other.data
  end

  def compare(other)
    case self <=> other
    when - 1
      @right
    when 0
      0
    when 1
      @left
    end
  end
end
