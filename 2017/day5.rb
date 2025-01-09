# http://adventofcode.com/2017/day/5

def count_steps(instructions)
  instructions = instructions.split.map(&:to_i)

  counter = 0
  current_position = 0

  loop do
    instructions[current_position] += 1
    current_position += instructions[current_position] - 1

    counter += 1
    break if current_position < 0 || current_position >= instructions.size
  end

  counter
end

require "minitest/autorun"

class Tests < MiniTest::Test
  def test_step_count
    assert_equal 5, count_steps("0 3 0 1 -3")
  end
end
