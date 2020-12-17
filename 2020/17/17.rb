initial_lines = File.readlines("input.txt")

# Both parts in one solution. Stop reading if you don't want spoilers for part 2.

# dimensions_to_check = 3 # Part 1
dimensions_to_check = 4 # Part 2

# populate our initial flat data
$data = Hash.new
y = 0
initial_lines.each do |yline|
  x = 0
  yline.chomp.split("").each do |entry|
    $data["#{x},#{y},0,0"] = (entry == "#")
    x += 1
  end

  y += 1
end

def cycle(dimensions)
  min_x, max_x, min_y, max_y, min_z, max_z, min_w, max_w = find_extents
  update = $data.clone # all changes happen simultaneously, so we need to not change $data until the end

  w_range = dimensions >= 4 ? (min_w - 1..max_w + 1) : [0]

  (min_x - 1..max_x + 1).each do |new_x|
    (min_y - 1..max_y + 1).each do |new_y|
      (min_z - 1..max_z + 1).each do |new_z|
        w_range.each do |new_w|
          my_coordinates = "#{new_x},#{new_y},#{new_z},#{new_w}"
          active_neighbor_count = active_neighbors(new_x, new_y, new_z, new_w).count
          if $data[my_coordinates]
            # active
            update[my_coordinates] = false unless active_neighbor_count.between?(2, 3)
          else
            # inactive
            update[my_coordinates] = true if active_neighbor_count == 3
          end
        end
      end
    end
  end

  $data = update
end

def find_extents
  x_values = $data.keys.map { |k| k.split(",")[0].to_i }.uniq
  y_values = $data.keys.map { |k| k.split(",")[1].to_i }.uniq
  z_values = $data.keys.map { |k| k.split(",")[2].to_i }.uniq
  w_values = $data.keys.map { |k| k.split(",")[3].to_i }.uniq
  [ x_values.min, x_values.max,
    y_values.min, y_values.max,
    z_values.min, z_values.max,
    w_values.min, w_values.max ]
end

def active_neighbors(x, y, z, w)
  coordinates_to_check = []
  (x - 1..x + 1).each do |check_x|
    (y - 1..y + 1).each do |check_y|
      (z - 1..z + 1).each do |check_z|
        (w - 1..w + 1).each do |check_w|
          coordinates_to_check << "#{check_x},#{check_y},#{check_z},#{check_w}"
        end
      end
    end
  end

  coordinates_to_check.delete("#{x},#{y},#{z},#{w}") # our target cube itself is not a neighbor

  coordinates_to_check.filter { |xyzw| $data[xyzw] }
end

def active_cubes_count
  $data.values.filter { |x| x }.count
end

puts "#{active_cubes_count} cubes active."

6.times do
  cycle(dimensions_to_check)
  puts "#{active_cubes_count} cubes active."
end

#require 'pry';binding.pry
