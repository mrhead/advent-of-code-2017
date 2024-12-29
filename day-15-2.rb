grid, directions = File.read("day-15.in").split("\n\n")

grid = grid.split("\n")
directions = directions.gsub("\n", "").chars

# scale up the grid
new_grid = []

grid.each do |row|
  new_line = ""

  row.chars.each do |char|
    case char
    when "#"
      new_line << "##"
    when "O"
      new_line << "[]"
    when "."
      new_line << ".."
    when "@"
      new_line << "@."
    end
  end

  new_grid << new_line
end

grid = new_grid

class Day15
  DELTAS = {
    "^" => [-1, 0],
    ">" => [0, 1],
    "v" => [1, 0],
    "<" => [0, -1]
  }

  attr_reader :grid, :directions
  attr_reader :rows, :cols, :row, :col
  attr_reader :debug

  def initialize(grid, directions, debug = false)
    @grid = grid
    @directions = directions
    @debug = debug

    @rows = grid.size
    @cols = grid.first.size

    for r in 0...rows
      for c in 0...cols
        if grid[r][c] == "@"
          @row = r
          @col = c
        end
      end
    end
  end

  def run
    print_grid if debug

    @directions.each do |direction|
      move(row, col, direction) if can_move?(row, col, direction)
      print_grid(direction) if debug
    end

    part_2 = 0

    for row in 1...rows
      for col in 2...cols-1
        if grid[row][col] == "["
          part_2 += row * 100 + col
        end
      end
    end

    puts part_2
  end

  private

  def print_grid(direction = nil)
    puts direction
    grid.each { |row| puts row }
    puts
  end

  def can_move?(row, col, direction)
    dr, dc = DELTAS[direction]

    next_row = row + dr
    next_col = col + dc

    case grid[row][col]
    when "@"
      can_move?(next_row, next_col, direction)
    when "."
      true
    when "#"
      false
    when "["
      case direction
      when "<", ">"
        return can_move?(next_row, next_col, direction)
      when "^", "v"
        return can_move?(next_row, next_col, direction) && can_move?(next_row, next_col + 1, direction)
      end
    when "]"
      case direction
      when "<", ">"
        return can_move?(next_row, next_col, direction)
      when "^", "v"
        return can_move?(next_row, next_col, direction) && can_move?(next_row, next_col - 1, direction)
      end
    end
  end

  def move(row, col, direction, robot = true)
    dr, dc = DELTAS[direction]

    next_row = row + dr
    next_col = col + dc

    vertical = %w(^ v).include?(direction)

    case grid[next_row][next_col]
    when "["
      move(next_row, next_col, direction, false)
      move(next_row, next_col + 1, direction, false) if vertical
    when "]"
      move(next_row, next_col, direction, false)
      move(next_row, next_col - 1, direction, false) if vertical
    end

    swap(row, col, next_row, next_col)

    if robot
      @row = next_row
      @col = next_col
    end
  end

  def swap(row_1, col_1, row_2, col_2)
    grid[row_1][col_1], grid[row_2][col_2] = grid[row_2][col_2], grid[row_1][col_1]
  end
end

# Day15.new(grid, directions, true).run
Day15.new(grid, directions).run
