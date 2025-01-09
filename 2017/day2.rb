def checksum(spreadsheet)
  spreadsheet.lines.map do |row|
    columns = row.split.map(&:to_i)

    min = columns.min
    max = columns.max

    max - min
  end.sum
end

require "minitest/autorun"

class Tests < MiniTest::Test
  def test_example_input
    input = <<~SPREADSHEET
      5 1 9 5
      7 5 3
      2 4 6 8
    SPREADSHEET

    assert_equal 18, checksum(input)
  end
end
