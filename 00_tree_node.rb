class PolyTreeNode
  attr_reader :children, :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    @parent.children.delete(self) if @parent
    @parent = parent
    unless parent == nil || parent.children.include?(self)
      parent.children << self
    end
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "That is not my child!" unless @children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    return nil if @children.empty?
    result_node = nil
    @children.each do |child|
      result_node = child.dfs(target_value)
      break if result_node
    end
    result_node
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each {|child| queue << child }
    end
    nil
  end

  def inspect
    @value.inspect
  end
end
