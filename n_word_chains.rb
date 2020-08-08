require_relative "word_chains"
require 'set'
require 'byebug'

class NWordChains < WordChains
    
    attr_reader :all_paths

    def initialize
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Array.new(words)
        @all_paths = Hash.new { |h, k| h[k] = [] }
        @invalid_comps = Set.new
    end

    def find_word_chains(n)
        count = 0
        until count == n
            debugger
           word1 = @dictionary.sample
           narrowed_dict = self.narrow_dict_params(word1)
           word2 = narrowed_dict.sample
        end
    end
    # def all_word_chains
    #     # debugger
    #     (0...@dictionary.length).each do |start_word|
    #         (start_word...@dictionary.length).each do |end_word|
    #             test = WordChains.new(@dictionary[start_word], @dictionary[end_word])
    #             if test.find_path != false
    #                 @all_paths[@dictionary[start_word]] << test.find_path
    #             else 
    #                 next 
    #             end
    #         end
    #     end
    #     puts @all_paths
    # end
end

