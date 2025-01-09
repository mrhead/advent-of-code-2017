grid, directions = File.read("day-15.in").split("\n\n")

grid = grid.split("\n")
directions = directions.gsub("\n", "").chars

class Day15
  DELTAS = {
    "^" => [-1, 0],
    ">" => [0, 1],
    "v" => [1, 0],
    "<" => [0, -1]
  }

  attr_reader :grid, :directions
  attr_reader :rows, :cols, :row, :col
  attr_reader :animate

  def initialize(grid, directions, animate = false)
    @grid = grid
    @directions = directions
    @animate = animate

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
    debug if animate

    @directions.each do |d|
      move(grid, row, col, d)
      debug(d) if animate
    end

    part_1 = 0

    for row in 0...rows
      for col in 0...cols
        if grid[row][col] == "O"
          part_1 += row * 100 + col
        end
      end
    end

    puts part_1
  end

  def debug(direction = nil)
    puts "\e[H\e[2J"
    puts direction
    grid.each { |row| puts row }
    puts
    sleep 0.02
  end

  private

  def move(grid, row, col, direction, steps = 1)
    dr, dc = DELTAS[direction]

    next_row = row + dr
    next_col = col + dc

    return if next_row < 0 || next_row >= rows
    return if next_col < 0 || next_col >= cols

    moved = false

    case grid[next_row][next_col]
    when "."
      swap(row, col, next_row, next_col)
      moved = true
    when "O"
      if move(grid, next_row, next_col, direction, steps + 1)
        swap(row, col, next_row, next_col)
        moved = true
      end
    when "#"
      # no-op
    else
      raise "Invalid grid value: #{grid[next_row][next_col]}"
    end

    if moved && steps == 1
      @row = next_row
      @col = next_col
    end

    moved
  end

  def swap(row_1, col_1, row_2, col_2)
    grid[row_1][col_1], grid[row_2][col_2] = grid[row_2][col_2], grid[row_1][col_1]
  end
end

# Day15.new(grid, directions, true).run
Day15.new(grid, directions).run
