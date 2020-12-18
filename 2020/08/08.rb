def run_instructions(instructions)
  visited_instructions = []
  current_instruction = 0
  accumulator = 0

  while(1)
    return [:revisited_instruction, accumulator] if visited_instructions.include?(current_instruction)
    return [:ran_out_of_instructions, accumulator] if current_instruction >= instructions.count

    visited_instructions << current_instruction
    op, increment = instructions[current_instruction].split(" ")
    increment = increment.to_i

    if op == "nop"
      current_instruction += 1
    elsif op == "acc"
      accumulator += increment
      current_instruction += 1
    elsif op == "jmp"
      current_instruction += increment
    else
      raise "uh oh! Unknown operation #{op}"
    end
  end
end

# part the first
instructions = File.readlines("input.txt").map { |i| i.chomp }
result, acc = run_instructions(instructions)
puts acc

# part the second
def swap_instruction(input)
  input[0..2] == "nop" ? input.gsub("nop", "jmp") : input.gsub("jmp", "nop")
end

instruction_variations = []
instructions.each_with_index do |instruction, index|
  next unless %w{nop jmp}.include? instruction[0..2] # only create variations for nop & jmp instructions
  new_copy = instructions.clone
  new_copy[index] = swap_instruction(new_copy[index])
  instruction_variations << new_copy
end

instruction_variations.each do |variation|
  result, acc = run_instructions(variation)
  next if result == :revisited_instruction
  puts acc
  break
end
