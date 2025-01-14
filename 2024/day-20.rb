grid = File.read("day-20.in").split

rows = grid.size
cols = grid.first.size

for row in 1...rows
  for col in 1...cols
    if grid[row][col] == "S"
      start = [row, col]
    end
  end
end

directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]

queue = [start]
distances = {} # position => distance
possible_shortcuts = {} # position => distance
current_distance = 0

while queue.any?
  row, col = queue.pop

  next if distances[[row, col]]
  distances[[row, col]] = current_distance
  current_distance += 1

  directions.each do |dr, dc|
    next_row = row + dr
    next_col = col + dc

    if (grid[next_row][next_col] == "." || grid[next_row][next_col] == "E") && distances[[next_row, next_col]].nil?
      queue << [next_row, next_col]
    end

    if grid[next_row][next_col] == "#" && next_row > 0 && next_row < rows - 1 && next_col > 0 && next_col < cols - 1
      possible_shortcuts[[next_row, next_col]] ||= current_distance
    end
  end

  break if grid[row][col] == "E"
end

part_1 = 0

possible_shortcuts.each do |position, shortcut_distance|
  row, col = position

  directions.each do |dr, dc|
    next_row = row + dr
    next_col = col + dc
    next_distance = distances[[next_row, next_col]]

    next unless next_distance

    if next_distance > shortcut_distance + 1
      saved_time = next_distance - shortcut_distance - 1

      if saved_time >= 100
        part_1 += 1
      end
    end
  end
end

puts part_1
