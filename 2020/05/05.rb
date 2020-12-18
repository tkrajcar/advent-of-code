lines = File.readlines("input.txt")

# part the first
seat_ids = lines.map do |line|
  row = line[0..6].gsub("F","0").gsub("B","1")
  seat = line[-4..-1].gsub("L","0").gsub("R","1")
  row.to_i(2) * 8 + seat.to_i(2)
end

puts seat_ids.max

# part the second
puts (seat_ids.min..seat_ids.max).to_a.difference(seat_ids.sort)
