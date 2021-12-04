depths = File.read('./input.txt').split.map(&:to_i)
previous_value = depths.first
count = depths.count do |d|
    greater = d > previous_value
    previous_value = d
    greater
end 
puts count