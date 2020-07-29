

class AllWordChains

    def initialize 
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Array.new(words)
    end

    


end
