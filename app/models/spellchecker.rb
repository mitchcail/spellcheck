require 'set'

class Spellchecker

  
  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

  #constructor.
  #text_file_name is the path to a local file with text to train the model (find actual words and their #frequency)
  #verbose is a flag to show traces of what's going on (useful for large files)
  def initialize(text_file_name)
    @dictionary = Hash.new 0 
    #read file text_file_name
    #extract words from string (file contents) using method 'words' below.
    #put in dictionary with their frequency (calling train! method)
    File.open(text_file_name) do |f|
      f.each_line do |line|
        words = line.split
        words.each do |word|
          
          train! words word

        end
      end
    end
  end

  def dictionary
    #getter for instance attribute
    @dictionary
  end
  
  #returns an array of words in the text.
  def words (text)
    return text.downcase.scan(/[a-z]+/) #find all matches of this simple regular expression
  end

  #train model (create dictionary)
  def train!(word)
    #create @dictionary, an attribute of type Hash mapping words to their count in the text {word => count}. Default count should be 0 (argument of Hash constructor).
    if !@dictionary.has_key?(word) then @dictionary[word] = 1 else @dictionary[word] += 1 end

  end

  #lookup frequency of a word, a simple lookup in the @dictionary Hash
  def lookup(word)
    @dictionary[[word]]
  end
  
  #generate all correction candidates at an edit distance of 1 from the input word.
 def edits1(word)
    
    deletes = []
    i = 0
    while i < word.length
      deletes_word = word
      deletes << deletes_word.slice(0,i) + deletes_word.slice(i+1, word.length)
      i+=1
    end
    #all strings obtained by deleting a letter (each letter)
    transposes = []
    i = 0
    while i < word.length
      transpose_word = word
      letter_to_replace = transpose_word[i]

      transpose_word[i] = transpose_word[i-1]
      transpose_word[i-1] = letter_to_replace
      transposes << transpose_word

      transpose_word = word
      letter_to_replace = transpose_word[i]

      if(transpose_word[i+1] != nil)
        transpose_word[i] = transpose_word[i+1]
        transpose_word[i+1] = letter_to_replace
        transposes << transpose_word
      end

      i+=1
    end
    #all strings obtained by switching two consecutive letters
    inserts = []
    word
    inserts(word)

    # all strings obtained by inserting letters (all possible letters in all possible positions)
    replaces = []
    #all strings obtained by replacing letters (all possible letters in all possible positions)

    #return (deletes + transposes + replaces + inserts).to_set.to_a #eliminate duplicates, then convert back to array
  end
  

  # find known (in dictionary) distance-2 edits of target word.
  def known_edits2 (word)
    # get every possible distance - 2 edit of the input word. Return those that are in the dictionary.
  end

  #return subset of the input words (argument is an array) that are known by this dictionary
  def known(words)
    return words.find_all {true } #find all words for which condition is true,
                                    #you need to figure out this condition
    
  end


  # if word is known, then
  # returns [word], 
  # else if there are valid distance-1 replacements, 
  # returns distance-1 replacements sorted by descending frequency in the model
  # else if there are valid distance-2 replacements,
  # returns distance-2 replacements sorted by descending frequency in the model
  # else returns nil
  def correct(word)
  end

  private

  def inserts word
    word.split(//).each_with_index do |word_char, index|
      puts index
      inserts_word = word
      ALPHABET.split(//).each do |alpha_char|
        inserts_word[index] = alpha_char
        puts "alpha_character: #{alpha_char}, insert_word: #{inserts_word}"
        inserts << inserts_word
      end
    end
  end
    
  
end

