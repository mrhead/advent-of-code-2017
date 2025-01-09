input = "day-03-input.txt"

# Part 1

regexp = /mul\((\d+),(\d+)\)/

puts File.read(input).scan(regexp).map { |pair| pair.map(&:to_i) }.sum { |a, b| a * b }

# Part 2

total = 0

File.read(input).split("do()").each do |chunk|
  code = chunk.split("don't()").first

  total += code.scan(regexp).map { |pair| pair.map(&:to_i) }.sum { |a, b| a * b }
end

puts total
