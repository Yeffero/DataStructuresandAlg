# Stores data and references parent and child nodes
class Node
  attr_accessor :value, :left_child, :right_child, :parent
  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
    @parent = nil
  end
end

# Represents a binary tree data structure
class BinaryTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def build_tree(data)
    data.each do |value|
      if @root.nil? # Initialize root node
        @root = Node.new(value)
        next
      end
      node = Node.new(value)
      insert_node(node)
    end
  end

  def insert_node(new_node, current_node = @root)
    if new_node.value <= current_node.value
      if current_node.left_child.nil?
        current_node.left_child = new_node
        new_node.parent = current_node
      else
        insert_node(new_node, current_node.left_child) # Call insert_node again
      end                                              # with left child as
    elsif current_node.right_child.nil?                # temp new root
      current_node.right_child = new_node
      new_node.parent = current_node
    else
      insert_node(new_node, current_node.right_child)  # Same as above but right
    end
  end

  def breadth_first_search(value)
    current_node = @root
    pending_nodes = []
    pending_nodes << current_node.left_child unless current_node.left_child.nil?
    pending_nodes << current_node.right_child unless current_node.right_child.nil?

    until pending_nodes.empty?
      return current_node if current_node.value == value
      current_node = pending_nodes.shift
      pending_nodes << current_node.left_child unless current_node.left_child.nil?
      pending_nodes << current_node.right_child unless current_node.right_child.nil?
    end
    puts "#{value} could not be found"
    nil
  end

  def depth_first_search(value)
    current_node = @root
    pending_nodes = []
    loop do
      until current_node.left_child.nil?
        current_node = current_node.left_child
        pending_nodes << current_node.parent
      end

      loop do
        return current_node if current_node.value == value

        if !current_node.right_child.nil?
          current_node = current_node.right_child
          break
        else
          return puts "#{value} could not be found" if pending_nodes.empty?
          current_node = pending_nodes.pop
          next
        end
      end
    end
  end

  def dfs_rec(value, current_node = @root)
    return if current_node.nil?

    node = dfs_rec(value, current_node.left_child)
    return current_node if current_node.value == value
    return node unless node.nil?
    node = dfs_rec(value, current_node.right_child)
    node
  end
end



tree = BinaryTree.new
ary = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree.build_tree(ary.shuffle)

puts tree.breadth_first_search(5).value
puts '^ Should be 5'

puts tree.breadth_first_search(21)
puts '^ Should be nil'

puts tree.depth_first_search(5).value
puts '^ Should be 5'

puts tree.depth_first_search(21)
puts '^ Should be nil'

puts tree.dfs_rec(21)
puts '^ Should be nil'

puts tree.dfs_rec(3).value
puts '^ Should be 3'
