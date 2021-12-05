require 'pry'
class Diagnostic 
    attr_reader :input, :input_length

    def initialize(input)
        @input = input
        @input_length = input.max.length
    end

    def calculate_consumption
        puts <<~HEREDOC
          Gamma: #{gamma = calculate_gamma}
          Epsilon: #{epsilon = calculate_epsilon(gamma)}
          Consumption: #{gamma * epsilon}
        HEREDOC
    end

    def calculate_life_support_rating
        puts <<~HEREDOC
          Oxy Gen Rating: #{oxy_gen_rating = calculate_ratings(mode: :ogr)}
          CO2 Scrubber Rating: #{co2_scrubber = calculate_ratings(mode: :csr)}
          Life Support Rating: #{oxy_gen_rating * co2_scrubber}
        HEREDOC
    end
    
    private

    def calculate_ratings(mode:)
        candidates = input.map {|c| c.to_i(2)} 
        mask = 2**(input_length - 1 )

        while candidates.size != 1 do 
            num_of1s = 0
            candidates.each do |c|
                diff = mask & c
                num_of1s += 1 if diff > 0 
            end

            is_majority = num_of1s >= candidates.size - num_of1s
            case mode
            when :ogr
                candidate_mask = is_majority ? :filter : :reject
            when :csr
                candidate_mask = is_majority ? :reject : :filter 
            end

            candidates = candidates.send(candidate_mask) {|c| c & mask > 0}
            mask = mask >> 1
        end
        candidates.first
    end

    def calculate_epsilon(gamma)
        gamma ^ 2**(input_length)-1
    end

    def calculate_gamma
        mask = 0b1
        result = 0b0

        while mask <= 2**(input_length) - 1 do
            num_of1s = 0
            input.each do |i|
                i = i.to_i(2)
                diff = mask & i
                num_of1s += 1 if diff > 0 
            end
            is_majority = num_of1s >= input.size - num_of1s 
            result = result | mask if is_majority
            mask = mask << 1
        end
        result
    end
end

input = File.read('./input.txt').split()
calculator = Diagnostic.new(input)
calculator.calculate_consumption
calculator.calculate_life_support_rating
