# https://adventofcode.com/2024/day/11
#
# Inspired by: https://www.youtube.com/watch?v=fOqsRz2wPZg

stones = File.read("day-11.in").split(" ").map(&:to_i)

def count_stones(stones, n = 1)
  cache = {}

  stones.sum { |stone| expand_and_count(stone, n, cache) }
end

def expand_and_count(stone, n = 1, cache = {})
  return 1 if n == 0

  cache[[stone, n]] ||= expand(stone).sum { |s| expand_and_count(s, n - 1, cache) }
end

def expand(stone)
  return [1] if stone == 0

  if stone.to_s.size.even?
    return split(stone)
  end

  [stone * 2024]
end

def split(number)
  s = number.to_s

  [s[0...s.size/2].to_i, s[s.size/2..].to_i]
end

puts count_stones(stones, 25)
puts count_stones(stones, 75)
