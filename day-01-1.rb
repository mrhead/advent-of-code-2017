input = "day-01-input.txt"

# Part 1

list_1 = []
list_2 = []

File.readlines(input).each do |line|
  values = line.split

  list_1 << values[0].to_i
  list_2 << values[1].to_i
end

list_1.sort!
list_2.sort!

total_distance = list_1.zip(list_2).reduce(0) { |sum, (x, y)| sum + (x - y).abs }

puts total_distance

# Part 2

