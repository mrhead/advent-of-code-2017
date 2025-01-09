# https://adventofcode.com/2024/day/18

coordinates = File.read("day-18.in").split("\n").map { |line| line.split(",").map(&:to_i) }

MAX_X = 70
MAX_Y = 70
nanoseconds = 1024

START_POSITION = [0, 0]
END_POSITION = [MAX_X, MAX_Y]

DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

# part 1

queue = []
queue << START_POSITION
seen = Set.new
scores = Hash.new(Float::INFINITY)
scores[START_POSITION] = 0

min_score = nil
corrupted = coordinates[...nanoseconds].to_set

while queue.any?
  x, y = queue.sort_by! { |position| -scores[position] }.pop

  next if seen.include?([x, y])
  seen.add([x, y])

  if [x, y] == END_POSITION
    min_score = scores[[x, y]]
    break
  end

  DIRECTIONS.each do |dx, dy|
    next_x, next_y = x + dx, y + dy
    next_score = scores[[x, y]] + 1

    next if next_x < 0 || next_x > MAX_X || next_y < 0 || next_y > MAX_Y
    next if corrupted.include?([next_x, next_y])

    scores[[next_x, next_y]] = [scores[[next_x, next_y]], next_score].min
    queue.push([next_x, next_y])
  end
end

puts min_score

# part 2

def can_exit?(corrupted)
  queue = [START_POSITION]
  seen = Set.new

  while queue.any?
    x, y = queue.pop

    seen.add([x, y])

    return true if [x, y] == END_POSITION

    DIRECTIONS.each do |dx, dy|
      next_x, next_y = x + dx, y + dy

      next if next_x < 0 || next_x > MAX_X || next_y < 0 || next_y > MAX_Y
      next if corrupted.include?([next_x, next_y])

      queue.push([next_x, next_y]) unless seen.include?([next_x, next_y])
    end
  end

  false
end

# binary search
min = nanoseconds
max = coordinates.size - 1

while min != max
  middle = (min + max) / 2

  if can_exit?(coordinates[..middle].to_set)
    min = middle + 1
  else
    max = middle
  end
end

puts coordinates[min].join(",")
