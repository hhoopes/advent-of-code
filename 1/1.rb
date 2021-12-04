require './depth_calculator'

depth_readings = File.read('./input.txt').split.map(&:to_i)

puts DepthCalculator.count_num_increases(depth_readings, window_size: 1)
puts DepthCalculator.count_num_increases(depth_readings, window_size: 3)