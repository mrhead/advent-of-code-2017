input = "day-01-input.txt"

values = []
counts = Hash.new(0)

File.readlines(input).each do |line|
  v1, v2 = line.split

  values << v1.to_i
  counts[v2.to_i] += 1
end

# pp values
# pp counts

total = values.reduce(0) do |sum, value|
  sum += value * counts[value]
end

puts total
