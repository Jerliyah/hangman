=begin
=========================
      Instructions
==========================
    1) Download the 5desk.txt dictionary file from http://scrapmaker.com/.
    When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.

    2) You don't need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses she has before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.

    3) Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.

    4) Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects... you can serialize your game class too!

    5) When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!

=end


# Read 5desk line by line
dictionary = File.readlines "5desk.txt"

# Filter words that are 5 to 12 characters long
filtered_words = []

dictionary.each do |word|
    if (5..12).to_a.include? word.length
        filtered_words << word
    end
end

# Pick a word from the filtered list at random
GAME_WORD = filtered_words[ rand(filtered_words.length - 1) ]



# Interface for guessing letters (one player against comp)
# [Start of with random letters -> random letters in a certain range of known letter -> guess next later based on known words in dictionary]

# Right or wrong alert

# Countdown of mistakes left

# Save game functionality 

# Send save game data to a file

# Close game functionality

# When program is run, check for saves before starting new, and retrieve data

# Properly use the data to start from save spot


