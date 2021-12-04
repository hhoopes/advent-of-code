vectors = File.read('./input.txt').split("\n")

depths = []
positions = []
aim = 0

vectors.each do |v|
    direction, amount = v.split(' ')
    amount = amount.to_i

    case direction
    when 'forward'
        positions << amount
        depths << aim * amount
    when 'down'
        aim += amount
    when 'up'
        aim -= amount
    end
end

final_position = positions.sum
final_depth = depths.sum
puts "Position = #{final_position} Depth = #{final_depth}"
puts "Mutiplied = #{final_position * final_depth}"