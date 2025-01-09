# https://adventofcode.com/2024/day/16
#
# This one was fun! I learned a lot and improved the speed of my initial
# solution by more than 100x.

grid = File.read("day-16.in").split("\n")

DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]] # north, east, south, west

for row in 1...grid.size
  for col in 1...grid.first.size
    if grid[row][col] == "S"
      start_row, start_col = row, col
    end

    if grid[row][col] == "E"
      end_row, end_col = row, col
    end
  end
end

starting_position = [start_row, start_col, 1] # direction 1 is east

queue = []
queue.push(starting_position)

scores = Hash.new(Float::INFINITY)
scores[starting_position] = 0

prev = Hash.new { |h, k| h[k] = Set.new }
seen = Set.new

while queue.any?
  row, col, direction = queue.sort_by! { |item| -scores[item] }.pop

  next if seen.include?([row, col, direction])

  seen.add([row, col, direction])

  { 0 => 1, 1 => 1001, -1 => 1001 }.each do |direction_change, score_change|
    next_direction = (direction + direction_change) % 4
    new_score = scores[[row, col, direction]] + score_change
    dr, dc = DIRECTIONS[next_direction]
    next_row, next_col = row + dr, col + dc

    if grid[next_row][next_col] != "#"
      if new_score < scores[[next_row, next_col, next_direction]]
        scores[[next_row, next_col, next_direction]] = new_score
        prev[[next_row, next_col, next_direction]].clear
        prev[[next_row, next_col, next_direction]] << [row, col, direction]
      elsif new_score == scores[[next_row, next_col, next_direction]]
        prev[[next_row, next_col, next_direction]] << [row, col, direction]
      end

      unless seen.include?([next_row, next_col, next_direction])
        queue.push([next_row, next_col, next_direction])
      end
    end
  end

  # there is probably only one direction to reach the end with minimal score,
  # so we can break early
  break if grid[row][col] == "E"
end

min_score = (0..3).map do |direction|
  scores[[end_row, end_col, direction]]
end.min

puts min_score # part 1

best_paths_tiles = Set.new
stack = []

# find direction to the end with min score
(0..3).map do |direction|
  if scores[[end_row, end_col, direction]] == min_score
    stack << [end_row, end_col, direction]
    break
  end
end

while stack.any?
  position = stack.pop
  best_paths_tiles.add([position[0], position[1]])

  prev[position].each do |prev_position|
    stack << prev_position
  end
end

puts best_paths_tiles.size # part 2
