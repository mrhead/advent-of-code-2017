# https://adventofcode.com/2024/day/7
#
# Additional excercise: build repeated permutations manually

operators = [:+, :*]

equations = File.read("day-07.in").split("\n")

total = 0

equations.each do |equation|
  test_value, numbers = equation.split(": ")
  test_value = test_value.to_i
  numbers = numbers.split.map(&:to_i)

  configurations = operators.repeated_permutation(numbers.size - 1)

  configurations.each do |configuration|
    # build expression
    expression = []
    configuration.each_with_index do |operator, i|
      expression << numbers[i]
      expression << operator
    end
    expression << numbers.last

    # evalue expression
    result = expression.shift
    while expression.any?
      operator = expression.shift
      number = expression.shift

      case operator
      when :+
        result += number
      when :*
        result *= number
      end
    end

    next if result > test_value

    if result == test_value
      total += test_value
      break
    end
  end
end

puts total
