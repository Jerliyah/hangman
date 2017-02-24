
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

load "assets/global_vars.rb"
load "assets/input_decisions.rb"
load "assets/player_turns.rb"
load "assets/game_manipulation.rb"

# Check for saved games
if File.exists?("saved-game.txt")

   puts "Looks like you have a saved game"
   saved_or_new

else
    new_game
end

# TODO
# Cleanup and stylization

