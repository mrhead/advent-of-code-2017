class Day12
  def initialize
    @grid = File.read("day-12.in").split("\n")
    @rows = @grid.size
    @cols = @grid.first.size
    @examined = Set.new
    @regions = []
  end

  def out_of_bounds?(row, col)
    row < 0 || row > @rows - 1 || col < 0 || col > @cols - 1
  end

  def equal?(plot_a, plot_b)
    return false if out_of_bounds?(*plot_a) || out_of_bounds?(*plot_b)

    row_a, col_a = plot_a
    row_b, col_b = plot_b

    @grid[row_a][col_a] == @grid[row_b][col_b]
  end

  def count_corners(row, col)
    outer_corner_checks = [
      [[row, col-1], [row-1, col]], # top-left
      [[row+1, col], [row, col+1]], # bottom-right
      [[row, col+1], [row-1, col]], # top-right
      [[row+1, col], [row, col-1]]  # bottom-left
    ]

    inner_corner_checks = [
      [[row, col-1], [row-1, col-1], [row-1, col]], # top-left
      [[row-1, col], [row-1, col+1], [row, col+1]], # top-right
      [[row, col+1], [row+1, col+1], [row+1, col]], # bottom-right
      [[row+1, col], [row+1, col-1], [row, col-1]]  # bottom-left
    ]

    corners = outer_corner_checks.count do |check|
      !equal?(check[0], [row, col]) && !equal?(check[1], [row, col])
    end

    corners += inner_corner_checks.count do |check|
      equal?(check[0], [row, col]) && !equal?(check[1], [row, col]) && equal?(check[2], [row, col])
    end

    corners
  end

  def examine(row, col, region = { area: 0, perimeter: 0, corners: 0, plant: @grid[row][col] })
    @examined.add([row, col])

    neighbors = 0

    [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |dr, dc|
      next_row = row + dr
      next_col = col + dc

      next if next_row < 0 || next_row >= @rows
      next if next_col < 0 || next_col >= @cols

      next unless equal?([row, col], [next_row, next_col])

      neighbors += 1

      unless @examined.include?([next_row, next_col])
        examine(next_row, next_col, region)
      end
    end

    region[:area] += 1
    region[:corners] += count_corners(row, col)
    region[:perimeter] += 4 - neighbors

    region
  end

  def run
    for row in 0...@rows
      for col in 0...@cols
        next if @examined.include?([row, col])

        @regions << examine(row, col)
      end
    end

    part_1 = @regions.sum { |region| region[:area] * region[:perimeter] }
    part_2 = @regions.sum { |region| region[:area] * region[:corners] }

    puts part_1
    puts part_2
  end
end

Day12.new.run
