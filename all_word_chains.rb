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
        @dictionary.each do |word1|
            @dictionary.each do |word2|
                test = WordChains.new(word1, word2)
                @all_paths[word1] << test unless test == false
            end
        end
    end

    
    
end
