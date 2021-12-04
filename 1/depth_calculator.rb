class DepthCalculator
    def self.count_num_increases(depth_readings, window_size: 1)
        previous_value = depth_readings.first
        depth_readings = window_size == 1 ? depth_readings : self.create_depth_windows(depth_readings, window_size)
        num_increases = depth_readings.count do |d|
            is_greater = d > previous_value
            previous_value = d
            is_greater
        end 
        num_increases
    end

    private
    def self.create_depth_windows(depth_readings, window_size)
        num_windows =  depth_readings.size - window_size + 1
        windows = []
        num_windows.times do |i|
            windows << depth_readings[i..i + window_size - 1].sum 
        end
        windows
    end
end