# https://adventofcode.com/2024/day/19

patterns, designs = File.read("day-19.in").split("\n\n")

@patterns = patterns.split(", ")
designs = designs.split

def is_possible?(design, cache)
  return true  if design == ""
  return cache[design] if cache[design] != nil

  cache[design] = @patterns.any? do |pattern|
    design.start_with?(pattern) && is_possible?(design[pattern.size..], cache)
  end
end

part_1 = 0
cache = {}

designs.each do |design|
  part_1 += 1 if is_possible?(design, cache)
end

puts part_1

# part 2

def count_options(design, cache)
  return 1 if design == ""
  return cache[design] if cache[design] != nil

  total = 0

  @patterns.each do |pattern|
    if design.start_with?(pattern)
      total += count_options(design[pattern.size..], cache)
    end
  end

  cache[design] = total
end

part_2 = 0
cache = {}

designs.each do |design|
  part_2 += count_options(design, cache)
end

puts part_2
