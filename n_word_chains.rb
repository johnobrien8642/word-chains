require_relative "word_chains"
require 'set'

class NWordChains < WordChains
    
    def initialize
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Array.new(words)
        @all_paths = Hash.new { |h, k| h[k] = [] }
        @invalid_comps = Set.new
    end

    def find_word_chains(num)
        #simply takes in a number of random word pair with word chain paths 
        #that you would like returned. Haven't tried anything super long in terms of
        #number of word chains returned.
        count = 0
        until count == num
            word_pair = two_rand_eql_length_words
      
            redo if invalid_pair?(word_pair)
                
                word1 = word_pair[0]
                word2 = word_pair[1]
                
                path_search = WordChains.new(word1, word2)
                
                if path_search.find_path == false
                    @invalid_comps << [ word1, word2 ]
                else
                    all_paths_key = "#{word1.upcase + ' ' + "to" + ' ' + word2.upcase}"
                    @all_paths[all_paths_key] << path_search.path
                    count += 1
                end
        end
        @all_paths
    end

    attr_reader :all_paths

    def two_rand_eql_length_words 
        word1 = @dictionary.sample
        narrowed_dict = self.narrow_dict_params(word1)
        word2 = narrowed_dict.sample

        [ word1, word2 ]
    end

    def invalid_pair?(word_pair)
        @invalid_comps.include?(word_pair) || 
        @invalid_comps.include?(word_pair.reverse)
    end

end

