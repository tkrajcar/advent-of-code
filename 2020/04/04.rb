entries = File.readlines("input.txt","\n\n")

puts "part the first"
needed_fields = %w{byr ecl eyr hcl hgt iyr pid}

valid_passports = entries.filter do |entry|
  h = Hash[entry.split(/ |\n/).collect { |str| str.split(':')}]
  (h.keys.sort & needed_fields) == needed_fields
end

puts valid_passports.count

puts "part the second"
def validate_byr(i) i.to_i.between?(1920, 2002) end

def validate_iyr(i) i.to_i.between?(2010, 2020) end

def validate_eyr(i) i.to_i.between?(2020, 2030) end

def validate_hgt(i)
  _, ht, unit = i.match(/(\d+)(cm|in)/).to_a
  return false if ht.nil? || unit.nil?
  unit == "cm" ? ht.to_i.between?(150, 193) : ht.to_i.between?(59, 76)
end

def validate_hcl(i) i =~ /^#[0-9a-f]{6}$/ end

def validate_ecl(i) %w{amb blu brn gry grn hzl oth}.include? i end

def validate_pid(i) i =~ /^\d{9}$/ end

valid_passports = entries.filter do |entry|
  h = Hash[entry.split(/ |\n/).collect { |str| str.split(':')}]
  next false unless (h.keys.sort & needed_fields) == needed_fields

  validate_byr(h["byr"]) && validate_iyr(h["iyr"]) &&
  validate_eyr(h["eyr"]) && validate_hgt(h["hgt"]) &&
  validate_hcl(h["hcl"]) && validate_ecl(h["ecl"]) &&
  validate_pid(h["pid"])
end

puts valid_passports.count
