# https://adventofcode.com/2024/day/17

a, b, c, *program = File.read("day-17.in").scan(/\d+/).map(&:to_i)

def combo(value, a, b, c)
  case value
  when 0..3
    value
  when 4
    a
  when 5
    b
  when 6
    c
  else
    raise "Invalid value: #{value}"
  end
end

def run_program(program, a, b, c)
  ip = 0 # instruction pointer
  output = []

  while ip < program.size
    instruction = program[ip]
    operand = program[ip + 1]

    case instruction
    when 0 # adv
      a /= 2 ** combo(operand, a, b, c)
    when 1 # bxl
      # b = b ^ operand
      b ^= operand
    when 2 # bst
      b = combo(operand, a, b, c) % 8
    when 3 # jnz
      if a != 0
        ip = operand
        next
      end
    when 4 # bxc
      b ^= c
    when 5 # out
      output << combo(operand, a, b, c) % 8
    when 6 # bdv
      b = a / (2 ** combo(operand, a, b, c))
    when 7 # cdv
      c = a / (2 ** combo(operand, a, b, c))
    end

    ip += 2
  end

  output
end

puts run_program(program, a, b, c).join(",") # part 1

# Part 2

# To achieve an output change at the end, a significant adjustment to register
# A is required. We begin by searching for a match starting from the end of the
# output. The process starts with register A initialized to zero, and we
# iterate in large steps. When a match is found, the step size is reduced by an
# order of magnitude, and the search continues with the next number
# (progressing from the end of the sequence).

initial_a = 0

(program.size - 1).downto(0) do |index|
  step = 10 ** (index - 2)
  step = 1 if step < 1

  loop do
    output = run_program(program, initial_a, b, c)

    # fail if the step is too big
    raise "Program output is longer than the program" if output.size > program.size

    if output[index..] == program[index..]
      if index == 0
        puts initial_a # part 2
        exit
      end

      initial_a -= step # go back one step and continue with the next number
      break
    end

    initial_a += step
  end
end
