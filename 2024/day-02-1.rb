input = "day-02-input.txt"

def is_safe?(report)
  report.each_cons(2).all? { |a, b| 1 <= a - b && a - b <= 3 } ||
    report.each_cons(2).all? { |a, b| 1 <= b - a && b - a <= 3 }
end

count = 0

File.readlines(input).each do |line|
  report = line.split.map(&:to_i)

  count += 1 if is_safe?(report)
end

puts  count
