stones = File.read("day-11.in").split(" ").map(&:to_i)

def blink(stones, n = 1)
  new_stones = []

  stones.each do |stone|
    if stone == 0
      new_stones << 1
    elsif stone.to_s.size.even?
      stone = stone.to_s
      n1 = stone[0...stone.size/2]
      n2 = stone[stone.size/2..]
      new_stones << n1.to_i
      new_stones << n2.to_i
    else
      new_stones << stone * 2024
    end
  end

  if n == 1
    new_stones
  else
    new_stones = blink(new_stones, n - 1)
  end

  new_stones
end

puts blink(stones, 25).size
