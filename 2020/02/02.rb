lines = File.readlines("input.txt")

puts "part the first"
valid = lines.filter do |line|
  lower, upper, letter, _, input = line.chomp.split(/-| |:/)
  lower.to_i <= input.count(letter) && upper.to_i >= input.count(letter)
end

puts valid.count

puts "part the second"
valid = lines.filter do |line|
  lower, upper, letter, _, input = line.chomp.split(/-| |:/)
  (input[upper.to_i - 1] == letter) ^ (input[lower.to_i - 1] == letter)
end

puts valid.count
