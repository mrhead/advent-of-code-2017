# https://adventofcode.com/2024/day/7
#
# Inspired by: https://github.com/jonathanpaulson/AdventOfCode/blob/master/2024/7.py
#
# This version is ~ 15 times faster than the one with all operator permutations.

equations = File.read("day-07.in").split("\n")

def is_valid?(value, numbers, part_2 = false)
  return value == numbers.first if numbers.size == 1
  return false if value < numbers.first

  n1, n2, *rest = numbers

  is_valid?(value, [n1 + n2] + rest, part_2) ||
    is_valid?(value, [n1 * n2] + rest, part_2) ||
    part_2 && is_valid?(value, [(n1.to_s + n2.to_s).to_i] + rest, part_2)
end

part_1 = 0
part_2 = 0

equations.each do |equation|
  value, numbers = equation.split(": ")
  value = value.to_i
  numbers = numbers.split.map(&:to_i)

  part_1 += value if is_valid?(value, numbers)
  part_2 += value if is_valid?(value, numbers, true)
end

puts part_1
puts part_2
