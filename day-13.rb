machines = []

File.read("day-13.in").split("\n\n").each do |machine|
  h = {}

  matches = machine.match(/Button A: X\+(\d+), Y\+(\d+)/)
  h[:a_x] = matches[1].to_i
  h[:a_y] = matches[2].to_i

  matches = machine.match(/Button B: X\+(\d+), Y\+(\d+)/)
  h[:b_x] = matches[1].to_i
  h[:b_y] = matches[2].to_i

  matches = machine.match(/X=(\d+), Y=(\d+)/)
  h[:x] = matches[1].to_i
  h[:y] = matches[2].to_i

  machines << h
end

tokens = 0

machines.each do |m|
  for i in 0..100 do
    for j in 0..100 do
      if m[:a_x] * i + m[:b_x] * j == m[:x] && m[:a_y] * i + m[:b_y] * j == m[:y]
        tokens += i * 3 + j
      end
    end
  end
end

puts tokens
