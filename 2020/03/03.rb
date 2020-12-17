$lines = File.readlines("input.txt")

puts "part the first"
i = -3
trees = $lines.filter do |line|
  line = line.chomp * $lines.count
  i += 3
  line[i] == "#"
end

puts trees.count

puts "part the second"

def count_trees(move_right, move_down = 1)
  i = move_right * -1
  lines_to_consider = $lines.each_slice(move_down).map(&:first)
  trees_found = lines_to_consider.filter do |line|
    line = line.chomp * $lines.count
    i += move_right
    line[i] == "#"
  end
  trees_found.count
end

results = [
  count_trees(1),
  count_trees(3),
  count_trees(5),
  count_trees(7),
  count_trees(1, 2)]

puts results.reduce(:*)
