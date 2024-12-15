test_string = <<~TEST
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
TEST

# grid = test_string.split("\n").map(&:chars)
grid = File.read("day-04-input.txt").split("\n").map(&:chars)

# Part 1

def top_to_right_diagonals(grid)
  columns = grid.first.size
  rows = grid.size

  diagonals = []

  # From the top row
  (0...columns).each do |start_column|
    column = start_column
    row = 0
    diagonal = ""

    while row < rows && column < columns
      diagonal << grid[row][column]

      row += 1
      column += 1
    end

    diagonals << diagonal
  end

  # From the left column, excluding the top-left corner
  (1...rows).each do |start_row|
    row = start_row
    column = 0
    diagonal = ""

    while row < rows && column < columns
      diagonal << grid[row][column]

      row += 1
      column += 1
    end

    diagonals << diagonal
  end

  diagonals
end

diagonals = top_to_right_diagonals(grid)
diagonals += top_to_right_diagonals(grid.map(&:reverse))
rows = grid.map(&:join)
columns = grid.transpose.map(&:join)

all_lines = diagonals + rows + columns

total = 0

all_lines.each do |line|
  total += line.scan("XMAS").count
  total += line.scan("SAMX").count # scan in the opposite direction
end

puts total

# Part 2

columns = grid.first.size
rows = grid.size

def is_xmas?(grid, row, column)
  top_left     = grid[row-1][column-1]
  top_right    = grid[row-1][column+1]
  bottom_left  = grid[row+1][column-1]
  bottom_right = grid[row+1][column+1]

  %w(MS SM).include?(top_left + bottom_right) && %w(MS SM).include?(top_right + bottom_left)
end

total = 0

(1...rows-1).each do |row|
  (1...columns-1).each do |column|
    next if grid[row][column] != "A"

    total += 1 if is_xmas?(grid, row, column)
  end
end

puts total
