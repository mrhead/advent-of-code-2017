# http://adventofcode.com/2017/day/6

def reallocate(banks)
  banks = banks.dup
  max_blocks = banks.max
  bank_with_max_blocks = banks.find_index(max_blocks)

  block_for_reallocation = banks[bank_with_max_blocks]
  banks[bank_with_max_blocks] = 0

  current_bank = bank_with_max_blocks + 1

  loop do
    if current_bank >= banks.size
      current_bank = 0
    end
    banks[current_bank] += 1
    current_bank += 1
    block_for_reallocation -= 1
    break if block_for_reallocation == 0
  end

  banks
end

def count_cycles(banks)
  seen_configurations = {}
  count = 0

  loop do
    banks = reallocate(banks)

    count += 1
    break if seen_configurations[banks]
    seen_configurations[banks] = true
  end

  count
end

require "minitest/autorun"

class Tests < MiniTest::Test
  def test_reallocation
    assert_equal [2, 4, 1, 2], reallocate([0, 2, 7, 0])
  end

  def test_count_cycles
    assert_equal 5, count_cycles([0, 2, 7, 0])
  end
end
