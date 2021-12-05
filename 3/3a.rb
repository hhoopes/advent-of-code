class Diagnostic 
    attr_reader :input, :input_length

    def initialize(input)
        @input = input
        @input_length = input.max.length
    end

    def calculate_consumption
        gamma = self.calculate_gamma
        gamma * self.calculate_epsilon(gamma)
    end
    
    private
    def calculate_epsilon(gamma)
        gamma ^ 2**(input_length)-1
    end

    def calculate_gamma
        majority = input.size/2
        mask = 0b1
        result = 0b0

        while mask <= 2**(input_length) - 1 do
            num_of1s = 0
            input.each do |i|
                i = i.to_i(2)
                diff = mask & i
                num_of1s += 1 if diff > 0 
            end
            result = result | mask if num_of1s >= majority
            mask = mask << 1
        end
        result
    end
end

input = File.read('./input.txt').split()
calculator = Diagnostic.new(input)
puts calculator.calculate_consumption

