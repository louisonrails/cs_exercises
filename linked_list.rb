class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)

    # FIXED: need return here or it keeps running
    if @head.nil?
      @head = new_node
      return
    end

    tail.next_node = new_node
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def size
    count = 0
    current = @head

    until current.nil?
      count += 1
      current = current.next_node
    end

    count
  end

  def tail
    return nil if @head.nil?

    current = @head

    current = current.next_node until current.next_node.nil?
    current
  end

  def at(index)
    current = @head
    i = 0

    while current
      return current if i == index

      current = current.next_node
      i += 1
    end

    nil
  end

  def pop
    return nil if @head.nil?
    return @head = nil if @head.next_node.nil?

    prev = at(size - 2)
    prev.next_node = nil
  end

  def contains?(value)
    current = @head

    until current.nil?
      return true if current.value == value

      current = current.next_node
    end

    false
  end

  def find(value)
    current = @head
    i = 0

    until current.nil?
      return i if current.value == value

      current = current.next_node
      i += 1
    end

    nil
  end

  def to_s
    current = @head
    str = ''

    until current.nil?
      str << "( #{current.value} ) -> "
      current = current.next_node
    end

    str << 'nil'
  end
end

# Test
list = LinkedList.new
list.append(10)
list.append(20)
list.prepend(5)

puts list
puts list.size
puts list.head.value
puts list.tail.value
puts list.at(1).value
puts list.contains?(20)
puts list.find(10)

list.pop
puts list
