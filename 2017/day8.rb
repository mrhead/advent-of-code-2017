# http://adventofcode.com/2017/day/8/

def get_largest_register_value(instructions)
  registers = Hash.new(0)

  instructions.lines do |instruction|
    execute_instruction(instruction, registers)
  end

  registers.sort_by { |_key, value| value }.last[1]
end

def execute_instruction(instruction, registers)
  matches = instruction.match(/(?<register>\w+) (?<operation>\w+) (?<value>-?\d+) if (?<condition>.*)/)
  register, operation, value, condition = matches.values_at(:register, :operation, :value, :condition)

  if evaluate_condition(condition, registers)
    case operation
    when "inc"
      registers[register] += value.to_i
    when "dec"
      registers[register] -= value.to_i
    end
  end
end

ALLOWED_OPERATORS = %W(> < >= <= == !=)
def evaluate_condition(condition, registers)
  register, operator, value = condition.split

  raise "operator #{operator} is not allowed" unless ALLOWED_OPERATORS.include?(operator)

  registers[register].send(operator, value.to_i)
end


require "minitest/autorun"

class Test < MiniTest::Test
  def test_example_input
    instructions = <<~INSTRUCTIONS
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    INSTRUCTIONS

    assert_equal 1, get_largest_register_value(instructions)
  end
end
