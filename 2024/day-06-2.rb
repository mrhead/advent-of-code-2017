# running time: 15 seconds

grid = File.read("day-06.in").split("\n").map(&:chars)

DIRECTIONS = %w(^ > v <)
DIRECTION_DELTAS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

rows = grid.size
cols = grid.first.size

current_row = nil
current_col = nil
direction = nil

# find starting position
(0...rows).each do |row|
  (0...cols).each do |col|
    if DIRECTIONS.include?(grid[row][col])
      current_row = row
      current_col = col
      direction = DIRECTIONS.index(grid[row][col])
      break
    end
  end

  break if direction
end

initial_position = [current_row, current_col]

# travel the path

seen = Set.new

def predict_path(grid, current_row, current_col, direction)
  seen = Set.new
  seen_d = Set.new
  has_loop = false

  rows = grid.size
  cols = grid.first.size

  loop do
    if seen_d.include?([current_row, current_col, direction])
      has_loop = true
      break
    end

    seen.add([current_row, current_col])
    seen_d.add([current_row, current_col, direction])

    row_delta, col_delta = DIRECTION_DELTAS[direction]

    next_row = current_row + row_delta
    next_col = current_col + col_delta

    break if next_row < 0 || next_row >= rows
    break if next_col < 0 || next_col >= cols

    if grid[next_row][next_col] == "#"
      direction = (direction + 1) % 4
      next
    end

    current_row = next_row
    current_col = next_col
  end

  return { seen: seen, has_loop: has_loop }
end

path = predict_path(grid, current_row, current_col, direction)[:seen]

ans = 0

path.each do |row, col|
  next if initial_position == [row, col]

  grid[row][col] = "#"

  if predict_path(grid, current_row, current_col, direction)[:has_loop]
    ans += 1
  end

  grid[row][col] = "."
end

puts ans
