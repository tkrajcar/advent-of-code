lines = File.readlines("input.txt").map(&:to_i)

puts "part the first"
catch(:answer_found) do
  lines.each do |curr|
    lines.each do |adder|
      if curr + adder == 2020
        puts curr * adder
        throw :answer_found
      end
    end
  end
end

puts "part the second"
catch(:answer_found) do
  lines.each do |curr|
    lines.each do |adder1|
      lines.each do |adder2|
        if curr + adder1 + adder2 == 2020
          puts curr * adder1 * adder2
          throw :answer_found
        end
      end
    end
  end
end
