require_relative '00_tree_node'

VALID_MOVES = [
  [1, 2],
  [2, 1],
  [-1, 2],
  [2, -1],
  [1, -2],
  [-2, 1],
  [-1, -2],
  [-2,-1]
]

class KnightPathFinder
  attr_accessor :start_position, :move_tree, :end_pos, :root

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @root = PolyTreeNode.new(start_pos)
    build_move_tree
  end

  def find_path(end_pos)
    target = self.root.dfs(end_pos)
    target ? trace_path_back(target).reverse : nil
  end

  def self.valid_moves(pos)
    x, y = pos
    valid_moves = VALID_MOVES.map { |dx, dy| [dx += x, dy += y] }
    valid_moves.select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def build_move_tree
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |next_pos|
        next_node = PolyTreeNode.new(next_pos)
        current_node.add_child(next_node)
        queue << next_node
      end
    end
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos)
      .reject { |position| @visited_positions.include?(position) }
      .each { |new_pos| @visited_positions << new_pos }
  end


  def trace_path_back(destination)
    return [] unless destination.parent
    [destination] + trace_path_back(destination.parent)
  end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 7])
p kpf.find_path([8, 8])
