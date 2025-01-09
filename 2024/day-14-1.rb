WIDTH = 101
HEIGHT = 103

MAX_X = WIDTH - 1
MAX_Y =  HEIGHT - 1

SECONDS = 100

quadrants = Hash.new(0)

def quadrant(x, y)
  if x < MAX_X / 2 && y < MAX_Y / 2
    return 1
  end

  if x < MAX_X / 2 && y > MAX_Y / 2
    return 2
  end

  if x > MAX_X / 2 && y < MAX_Y / 2
    return 3
  end

  if x > MAX_X / 2 && y > MAX_Y / 2
    return 4
  end
end

File.readlines("day-14.in").each do |line|
  matches = line.match(/p=(?<x>\d+),(?<y>\d+) v=(?<v_x>-?\d+),(?<v_y>-?\d+)/)

  x = (matches[:x].to_i + matches[:v_x].to_i * SECONDS) % WIDTH
  y = (matches[:y].to_i + matches[:v_y].to_i * SECONDS) % HEIGHT

  if q = quadrant(x, y)
    quadrants[q] += 1
  end
end

puts quadrants.values.reduce(1) { |acc, value| acc * value }
