WIDTH = 101
HEIGHT = 103

robots = []

File.readlines("day-14.in").each do |line|
  matches = line.match(/p=(?<x>\d+),(?<y>\d+) v=(?<v_x>-?\d+),(?<v_y>-?\d+)/)

  robots << {
    x: matches[:x].to_i,
    y: matches[:y].to_i,
    v_x: matches[:v_x].to_i,
    v_y: matches[:v_y].to_i
  }
end

10_000.times do |n|
  set = Set.new

  robots.each do |robot|
    robot[:x] = (robot[:x] + robot[:v_x]) % WIDTH
    robot[:y] = (robot[:y] + robot[:v_y]) % HEIGHT

    set.add([robot[:x], robot[:y]])
  end

  if set.size == robots.size
    # Each robot is in a unique position. Solution stolen from reddit.
    puts "n: #{n+1}"
    break
  end
end

# Print the map.
grid = Array.new(HEIGHT) { |_i| Array.new(WIDTH, " ") }

robots.each do |robot|
  grid[robot[:y]][robot[:x]] = "X"
end

grid.each do |row|
  puts row.join
end
