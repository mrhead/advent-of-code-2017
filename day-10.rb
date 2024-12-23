grid = File.read("day-10.in").split("\n").map { |line| line.chars.map(&:to_i) }

rows = grid.size
cols = grid.first.size

def examine_position(grid, row, col, top_positions = Set.new, trail_counter = [0])
  rows = grid.size
  cols = grid.first.size
  current_position = grid[row][col]

  [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |dr, dc|
    next_row = row + dr
    next_col = col + dc

    if next_row >= 0 && next_row < rows && next_col >= 0 && next_col < cols
      if grid[next_row][next_col] == current_position + 1
        if grid[next_row][next_col] == 9
          top_positions.add([next_row, next_col])
          trail_counter[0] += 1
        else
          examine_position(grid, next_row, next_col, top_positions, trail_counter)
        end
      end
    end
  end

  [top_positions.size, trail_counter[0]]
end

part_1 = 0
part_2 = 0

for i in 0...rows
  for j in 0...cols
    if grid[i][j] == 0
      score, rating = examine_position(grid, i, j)
      part_1 += score
      part_2 += rating
    end
  end
end

puts part_1
puts part_2
