# frozen_string_literal: true

class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_rec(@root, value)
  end

  def include?(value)
    search_rec(@root, value)
  end

  def delete(value)
    @root = delete_rec(@root, value)
  end

  def inorder(&block)
    inorder_rec(@root, &block)
  end

  # Recursive Helpers

  def insert_rec(node, value)
    return Node.new(value) if node.nil?

    if value < node.value
      node.left = insert_rec(node.left, value)
    elsif value > node.value
      node.right = insert_rec(node.right, value)
    end

    node
  end

  def search_rec(node, value)
    return false if node.nil?
    return true if node.value == value

    value < node.value ? search_rec(node.left, value) : search_rec(node.right, value)
  end

  def delete_rec(node, value)
    return nil if node.nil?

    if value < node.value
      node.left = delete_rec(node.left, value)
    elsif value > node.value
      node.right = delete_rec(node.right, value)
    else
      node = delete_node(node)
    end

    node
  end

  def inorder_rec(node, &block)
    return if node.nil?

    inorder_rec(node.left, &block)
    block.call(node.value)
    inorder_rec(node.right, &block)
  end

  def delete_node(node)
    return nil if node.left.nil? && node.right.nil?

    return node.left if node.right.nil?

    return node.right if node.left.nil?

    successor_value = min_value(node.right)
    node.value = successor_value
    node.right = delete_rec(node.right, successor_value)

    node
  end

  def min_value(node)
    node = node.left until node.left.nil?
    node.value
  end
end

tree = BinarySearchTree.new
tree.insert(8)
tree.insert(3)
tree.insert(10)
tree.insert(1)
tree.insert(6)

puts "Tree contains 6? #{tree.include?(6)}"
puts 'Inorder traversal:'
tree.inorder { |v| puts v }

tree.delete(3)
puts 'After deleting 3:'
tree.inorder { |v| puts v }
