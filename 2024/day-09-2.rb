# https://adventofcode.com/2024/day/9

disk_map = File.read("day-09.in").strip

filesystem = []
file_id = 0
files = []

disk_map.chars.map(&:to_i).each_with_index do |n, i|
  if i.even?
    files << { id: file_id, location: filesystem.size, size: n }
    filesystem += [file_id] * n
    file_id += 1
  else
    filesystem += [nil] * n
  end
end

def find_free_space(filesystem, size, max_index)
  i = 0

  while i <= max_index-size
    unless filesystem[i].nil?
      i += 1
      next
    end

    if filesystem[i...i+size].all?(&:nil?)
      return i
    else
      i += 1
    end
  end

  nil
end

while files.any?
  file = files.pop

  if free_space_index = find_free_space(filesystem, file[:size], file[:location])
    file[:size].times do |n|
      filesystem[free_space_index + n] = file[:id]
      filesystem[file[:location] + n] = nil
    end
  end
end


puts filesystem.each_with_index.sum { |file, index| file.to_i * index }
