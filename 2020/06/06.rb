groups = File.readlines("input.txt","\n\n")

# part the first
counts = groups.map do |group|
  group.gsub("\n","").split("").uniq.count
end

puts counts.sum

# part the second
counts = groups.map do |group|
  people = group.split("\n")
  group_data = Hash.new(0)
  people.each do |person|
    questions = person.split("")
    questions.each { |q| group_data[q] += 1 }
  end

  group_data.filter { |k| group_data[k] == people.count }.count
end

puts counts.sum
