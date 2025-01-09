# http://adventofcode.com/2017/day/7

def get_bottom_program(input)
  bottom_programs = {}
  child_programs = []

  input.lines.each do |line|
    next unless line.match?("->")

    parent = line.match(/(.*) \(.*/)[1]
    bottom_programs[parent] = true

    children = line.match(/-> (.*)/)[1].split(", ")
    children.each { |child| child_programs << child }
  end

  child_programs.each { |child| bottom_programs[child] = false }

  bottom_programs.find{ |k, v| v }[0]
end

require "minitest/autorun"

class Test < MiniTest::Test
  def test_example_input
    input = <<~INPUT
      pbga (66)
      xhth (57)
      ebii (61)
      havc (66)
      ktlj (57)
      fwft (72) -> ktlj, cntj, xhth
      qoyq (66)
      padx (45) -> pbga, havc, qoyq
      tknk (41) -> ugml, padx, fwft
      jptl (61)
      ugml (68) -> gyxo, ebii, jptl
      gyxo (61)
      cntj (57)
    INPUT

    assert_equal "tknk", get_bottom_program(input)
  end
end
