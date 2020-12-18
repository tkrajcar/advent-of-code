# Solution to this one cribbed from https://github.com/mwlang/advent-of-code/blob/main/2020/07/solution.rb

RULES = {}

class Rule
  attr_accessor :name, :contains
  def initialize(name)
    @name = name.strip
    @contains = {}
  end

  def contains(color, quantity)
    @contains[color] = quantity
  end

  def contains?(color)
    @contains.keys.detect { |c| c.name == color.name || RULES[c.name].contains?(color) }
  end

  def bag_count
    @contains.map { |color, qty| qty * (1 + color.bag_count) }.reduce(0){ |sum, qty| sum + qty }
  end
end

# part the first
rules = File.readlines("input.txt").map{ |l| l.gsub(/\sbags?|\./,'') }

rules.each do |line|
  color, contents = line.split(" contain ")
  contents.chomp!
  RULES[color] ||= Rule.new(color)
  contents.split(/,\s?/).each do |held|
    next if held =~ /no other/
    _, qty, held_name = held.match(/^(\d+)(.*)$/).to_a
    held_name.strip!
    RULES[held_name] ||= Rule.new(held_name)
    RULES[color].contains RULES[held_name], qty.to_i
  end
end

puts RULES.values.select { |c| c.contains? RULES["shiny gold"] }.count

# part the second

puts RULES["shiny gold"].bag_count
