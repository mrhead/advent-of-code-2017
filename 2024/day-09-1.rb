# https://adventofcode.com/2024/day/9

disk_map = File.read("day-09.in").strip

disk_blocks = []
file_index = 0

disk_map.chars.map(&:to_i).each_with_index do |size, index|
  if index.even?
    disk_blocks += [file_index] * size
    file_index += 1
  else
    disk_blocks += [nil] * size
  end
end

j = disk_blocks.size - 1

for i in 0...disk_blocks.size
  next unless disk_blocks[i].nil?

  break if i == j

  loop do
    if disk_blocks[j].nil?
      j -= 1
      next
    end

    disk_blocks[i], disk_blocks[j] = disk_blocks[j], disk_blocks[i]

    break
  end
end

checksum = disk_blocks.compact.each_with_index.sum { |file_id, i| file_id * i.to_i }

puts checksum
