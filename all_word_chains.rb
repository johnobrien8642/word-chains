require_relative "word_chains"
require 'byebug'

class AllWordChains < WordChains
    
    attr_reader :all_paths

    def initialize
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Array.new(words)
        @all_paths = Hash.new { |h, k| h[k] = [] }
    end

    def all_word_chains
        debugger
        @dictionary.each do |word1|
            @dictionary.each do |word2|
                test = WordChains.new(word1, word2)
                if test.find_path != false
                    @all_paths[word1] << test.find_path
                else 
                    next 
                end
            end
        end
        @all_paths
    end

    
    
end
