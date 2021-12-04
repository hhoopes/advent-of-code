vectors = File.read('./input.txt').split("\n")

depths = []
positions = []
depth_vector = {
    up: -1,
    down: +1
}

vectors.each do |v|
    direction, amount = v.split(' ')
    if direction == 'forward'
        positions << amount.to_i
    else
        depths << amount.to_i * depth_vector[direction.to_sym]
    end
end

final_position = positions.sum
final_depth = depths.sum
puts "Position = #{final_position} Depth = #{final_depth}"
puts "Mutiplied = #{final_position * final_depth}"