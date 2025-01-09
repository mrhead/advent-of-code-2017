# http://adventofcode.com/2017/day/4
#
def passphrase_valid?(passphrase)
  words = passphrase.split

  words.count == words.uniq.count
end

def count_valid_passphrases(input)
  input.lines.inject(0) do |count, passphrase|
    if passphrase_valid?(passphrase)
      count += 1
    end

    count
  end
end

require 'minitest/autorun'

class Tests < MiniTest::Test
  def test_passphrase_validation
    assert passphrase_valid?("aa bb cc")
    assert passphrase_valid?("aa bb cc aaa")

    refute passphrase_valid?("aa bb aa")
  end

  def test_valid_passphrase_counter
    passphrases = <<~PASSPHRASES
      aa bb cc
      aa bb dd
      aa bb aa
    PASSPHRASES

    assert_equal 2, count_valid_passphrases(passphrases)
  end
end
