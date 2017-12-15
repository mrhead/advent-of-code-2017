# http://adventofcode.com/2017/day/3

def distance(position)
  return 0 if position == 1

  square_size = Math.sqrt(position).ceil

  if square_size.even?
    square_size += 1
  end

  max_distance = square_size - 1
  min_distance = (square_size / 2).floor

  max_number_in_square = square_size ** 2
  min_number_in_square = ((square_size - 2) ** 2) + 1

  current_distance = max_distance
  distance_direction = -1

  (max_number_in_square).downto(min_number_in_square) do |n|
    return current_distance if n == position

    current_distance += distance_direction

    if current_distance == min_distance
      distance_direction = 1
    end

    if current_distance == max_distance
      distance_direction = -1
    end
  end
end

require 'minitest/autorun'

class Tests < MiniTest::Unit::TestCase
  def test_example_input
    assert_equal 0, distance(1)
    assert_equal 1, distance(2)
    assert_equal 2, distance(3)
    assert_equal 1, distance(4)
    assert_equal 2, distance(9)
    assert_equal 2, distance(11)
    assert_equal 4, distance(25)
    assert_equal 5, distance(44)
    assert_equal 6, distance(49)
    assert_equal 31, distance(1024)
  end
end
