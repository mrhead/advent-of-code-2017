test_rules = <<~TEST
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13
TEST

test_updates = <<~TEST
  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
TEST

ordering_rules = Hash.new

# rules = test_rules
rules = File.read("day-05-rules.txt")

rules.split("\n").each do |rule|
  first, second = rule.split("|").map(&:to_i)

  ordering_rules[first] ||= []
  ordering_rules[first] << second
end

# updates = test_updates.split("\n").map { |u| u.split(",").map(&:to_i) }
updates = File.read("day-05-udpates.txt").split("\n").map { |u| u.split(",").map(&:to_i) }

# Part 1

def correct_update?(ordering_rules, update)
  previous_pages = []

  update.each do |page|
    return false if ordering_rules[page] && (ordering_rules[page] & previous_pages).any?
    previous_pages << page
  end

  true
end

part_1 = 0
part_2 = 0

updates.each do |update|
  if correct_update?(ordering_rules, update)
    part_1 += update[update.size/2]
  else
    corrected_update = update.sort do |a, b|
      if ordering_rules[a] && ordering_rules[a].include?(b)
        -1
      elsif ordering_rules[b] && ordering_rules[b].include?(a)
        1
      else
        0
      end
    end

    part_2 += corrected_update[corrected_update.size/2]
  end
end

puts part_1
puts part_2
