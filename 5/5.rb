input = File.read('./input.txt').split("\n")
require 'pry'


hotspots = Array.new(1000) {Array.new(1000, 0)}
count = []
input.each do |line|
    x1, y1, x2, y2 = line.match(/(\d*),(\d*) -> (\d*),(\d*)/).captures.map(&:to_i)

    if x1 == x2
        range = [y1, y2]
        (range.min..range.max).each do |n|
            hotspots[x1][n] += 1
            count << "#{x1}#{n}" if hotspots[x1][n] > 1
        end
    elsif y1 ==y2
        range = [x1, x2]
        (range.min..range.max).each do |n|
            hotspots[n][y1] += 1
            count << "#{n}#{y1}" if hotspots[n][y1] > 1
        end
    else
        x_range = [x1, x2]
        slope = (y2 - y1)/(x2 - x1)
        b = y1 - slope * x1
        (x_range.min..x_range.max).each do |x|
                y = slope * x + b
                hotspots[x][y] += 1
                count << "#{x}#{y}" if hotspots[x][y] > 1
        end
    end
end

puts "Hotspot count: #{count.uniq.count}"