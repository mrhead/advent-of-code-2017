input = "day-02-input.txt"

def increasing_or_decreasing?(report)
  report == report.sort || report == report.sort.reverse
end

def is_safe?(report)
  return false unless increasing_or_decreasing?(report)

  report.each_cons(2).all? { |a, b| 1 <= (a - b).abs && (a - b).abs <= 3 }
end

def is_safe_with_removing_a_level?(report)
  (0..report.size).each do |i|
    dup = report.dup
    dup.delete_at(i)

    return true if is_safe?(dup)
  end

  false
end

count = 0

File.readlines(input).each do |line|
  report = line.split.map(&:to_i)

  count += 1 if is_safe_with_removing_a_level?(report)
end

puts  count
