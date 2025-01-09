grid = File.read("day-06.in").split("\n").map(&:chars)

moves = %w(^ > v <)
direction_deltas = [[-1, 0], [0, 1], [1, 0], [0, -1]]

rows = grid.size
cols = grid.first.size

current_row = nil
current_col = nil
direction = nil

# find starting position
(0...rows).each do |row|
  (0...cols).each do |col|
    if moves.include?(grid[row][col])
      current_row = row
      current_col = col
      direction = moves.index(grid[row][col])
    end
  end

  break if direction
end

seen = Set.new

# follow the path
loop do
  seen << [current_row, current_col]

  row_delta, col_delta = direction_deltas[direction]

  next_row = current_row + row_delta
  next_col = current_col + col_delta

  break if next_row < 0 || next_row >= rows
  break if next_col < 0 || next_col >= cols

  if grid[next_row][next_col] == "#"
    direction = (direction + 1) % 4 # turn right
    next
  end

  current_row = next_row
  current_col = next_col
end

puts seen.size
