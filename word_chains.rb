
class WordChains

    def initialize(beginning_word, target_word)
        # Sets a constant.
        @origin_word = beginning_word 
         # Used as placeholder to move to each new word to check for new valid words.
        @current_word = beginning_word
        @target_word = target_word  
        words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Array.new(words)
        # Narrows dictionary to be checked to only words of @current_word and @target_word length.
        @narrowed_dict = self.narrow_dict_params 
        @path = [ @origin_word ]
    end

    attr_accessor :current_word, :target_word, :dictionary, :path, :dead_ends, :invalid_words
  
    # finds path if path is possible
    def find_path
        return false if @origin_word == @target_word
            # Loop runs until path includes both the originating word and target word.
        until @path.include?(@origin_word) && @path.include?(@target_word)
            # Gets all valid words for @current_word.
            valid_words = find_valid_words(@current_word)
            # Checks to make sure a dead end has not been reached. 
            if !valid_words.empty? 
                # Chooses next word from valid_words. 
                find_and_move_to_next_word(@current_word, valid_words) 
            else  
                # In my version of the puzzle solution, if a dead end has been reached 
                # than the program assumes no path could be found.
                return false
            end
        end
        return false if @path.length == 2
        @path
    end

    def narrow_dict_params
        narrowed_dict = @dictionary.select { |word| word.length == @origin_word.length }
        narrowed_dict
    end
    
    def find_and_move_to_next_word(current_word, valid_words)
        next_word = word_moving_towards_target(valid_words)
        @path << next_word
        # This changes current_word to the "next word" so that the next array of 
        # valid words can be found.
        @current_word = next_word
    end
    # This provides a word from valid_words that shares the most letters with target_word.
    # A hash with words as keys and same letter counts as values is created. This hash
    # is then sorted by value and the word with the most similarities is selected from 
    # the end of the hash array.
    def word_moving_towards_target(valid_words)                           
        count_hash = Hash.new { |h, k| h[k] = 0 }

        valid_words.each do |word|
            count = 0
            (0...word.length).each do |i|
                count += 1 if word[i] == @target_word[i]
            end
            count_hash[word] += count
        end

        sorted_hash = count_hash.sort_by { |k, v| v }
        sorted_hash[-1][0]
    end
    # this provides a full list of valid words that a next word is selected from 
    def find_valid_words(current_word)
        valid_words = @narrowed_dict.select { |word| word if valid_word?(word) }
        valid_words 
    end

    def valid_word?(word)
        word != @current_word &&
        last_word_compatible?(word) && 
        target_compatible?(word) &&
        !path.include?(word)
    end
    # checks that word changes no more than one letter from current word.
     def last_word_compatible?(word)
        count = 0 
        (0...word.length).each do |i|
            count += 1 if word[i] != @current_word[i]
        end

        return false if count > 1
        true
    end
    # checks that word shares at least one letter in common with target word
    def target_compatible?(word)
        count = 0 
        (0...word.length).each do |i|
            count += 1 if word[i] == @target_word[i]
        end

        return true if count >= 1
        false
    end

end

