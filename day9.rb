# http://adventofcode.com/2017/day/9

def count_score(input)
  score = 0
  opened_groups = 0
  is_garbage = false
  ignore_next_character = false

  input.chars.each do |character|
    if is_garbage
      if ignore_next_character
        ignore_next_character = false
        next
      end

      case character
      when ">"
        is_garbage = false
      when "!"
        ignore_next_character = true
      end
    else
      case character
      when "<"
        is_garbage = true
      when "{"
        opened_groups += 1
      when "}"
        score += opened_groups
        opened_groups -= 1
      end
    end
  end

  score
end

require "minitest/autorun"

class Test < MiniTest::Test
  def test_count_groups
    assert_equal 1, count_score("{}")
    assert_equal 6, count_score("{{{}}}")
    assert_equal 5, count_score("{{},{}}")
    assert_equal 16, count_score("{{{},{},{{}}}}")
    assert_equal 1, count_score("{<a>,<a>,<a>,<a>}")
    assert_equal 9, count_score("{{<ab>},{<ab>},{<ab>},{<ab>}}")
    assert_equal 9, count_score("{{<!!>},{<!!>},{<!!>},{<!!>}}")
    assert_equal 3, count_score("{{<a!>},{<a!>},{<a!>},{<ab>}}")
  end
end
