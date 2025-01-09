grid = File.read("day-08.in").split("\n")

rows = grid.size
cols = grid.first.size

antennas = Hash.new { |h, k| h[k] = [] } # frequency => [positions]

for row in 0...rows
  for col in 0...cols
    next if grid[row][col] == "."

    antennas[grid[row][col]] << [row, col]
  end
end

part_1 = Set.new
part_2 = Set.new

antennas.each do |frequency, positions|
  next if positions.size == 1

  for i in 0...positions.size
    for j in (i+1)...positions.size
      p1 = positions[i]
      p2 = positions[j]

      row_delta = p2[0] - p1[0]
      col_delta = p2[1] - p1[1]

      n = 0
      loop do
        antinode_row = p1[0] - row_delta * n
        antinode_col = p1[1] - col_delta * n

        if antinode_row >= 0 && antinode_row < rows && antinode_col >= 0 && antinode_col < cols
          part_1 << [antinode_row, antinode_col] if n == 1
          part_2 << [antinode_row, antinode_col]
        else
          break
        end

        n += 1
      end

      n = 0
      loop do
        antinode_row = p2[0] + row_delta * n
        antinode_col = p2[1] + col_delta * n

        if antinode_row >= 0 && antinode_row < rows && antinode_col >= 0 && antinode_col < cols
          part_1 << [antinode_row, antinode_col] if n == 1
          part_2 << [antinode_row, antinode_col]
        else
          break
        end

        n += 1
      end
    end
  end
end

puts part_1.size
puts part_2.size
