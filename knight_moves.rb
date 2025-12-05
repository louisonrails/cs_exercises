class Knight
  MOVES = [
    [1, 2], [2, 1], [-1, 2], [-2, 1],
    [1, -2], [2, -1], [-1, -2], [-2, -1]
  ]

  def self.valid_position?(position)
    x, y = position
    x.between?(0, 7) && y.between?(0, 7)
  end

  def self.possible_moves(position)
    x, y = position
    MOVES.map { |delta_x, delta_y| [x + delta_x, y + delta_y] }
         .select { |new_position| valid_position?(new_position) }
  end

  def knight_moves(start_position, target_position)
    queue = [start_position]
    visited = { start_position => true }
    parents = {}

    until queue.empty?
      current = queue.shift

      break if current == target_position

      Knight.possible_moves(current).each do |move|
        next if visited[move]

        visited[move] = true
        parents[move] = current
        queue << move
      end
    end

    path = [target_position]
    path << parents[path.last] until path.last == start_position
    path.reverse
  end
end

knight = Knight.new
p knight.knight_moves([0, 0], [3, 3])
