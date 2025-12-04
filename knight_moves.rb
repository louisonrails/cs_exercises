class Board
  attr_reader :min_position, :max_position

  def initialize
    @min_position = 0
    @max_position = 7
  end
end

class Knight
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    @position = [x, y]
    @board = Board.new
    @possible_moves = []
  end

  def valid_position?(position)
    x, y = position

    x.between?(@board.min_position, @board.max_position) &&
      y.between?(@board.min_position, @board.max_position)
  end

  def possible_positions
    x, y = @position

    deltas = [
      [1, 2],  [2, 1],   [-1, 2],  [-2, 1],
      [1, -2], [2, -1],  [-1, -2], [-2, -1]
    ]

    deltas.map { |delta_x, delta_y| [x + delta_x, y + delta_y] }
          .select { |new_position| valid_position?(new_position) }
  end
end

knight = Knight.new(0, 0)
p knight.possible_positions
knight2 = Knight.new(4, 4)
p knight2.possible_positions
