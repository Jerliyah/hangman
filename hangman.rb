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




# Format the GAME_WORD into a secret for in game viewing
def create_secret_word
    # Array
    letters = []

    # Push each letter into array
    GAME_WORD.each_char do |letter| 
        letters << letter 
    end

    # Format secret word to have letters replaced with underscores and spacing
    $secret_word = letters.join(" ").gsub( /[a-z]/, "_")
end


# Reformat secret_word when letters are found
def reformat_secret_word(guess_letter)
    locations = GAME_WORD.split('').each_index.select do |letter| GAME_WORD[letter] == guess_letter end

    secret_word = $secret_word.split(' ')

    for i in 0...locations.length
        index = locations[i]
        secret_word[index] = guess_letter
    end

    secret_word = secret_word.join(" ")

    secret_word
end



# Actions based on right on wrong letter answer
def right_or_wrong_letter(guess_letter)

    if GAME_WORD.include? guess_letter
        puts "\nNice"

        # Show found letters
        $secret_word = reformat_secret_word(guess_letter)

    else
        puts "\nNope, that's not it"

        # Countdown of mistakes left
        $mistakes_left -= 1
    end

end


# Actions based on right on wrong word answer
def right_or_wrong_word(guess_word)

    if guess_word == GAME_WORD
        puts "\nAmazing! The puzzle has been solved, great job."
        close_game

    else
        puts "\nOh my gosh! You did it! (it = providing the wrong answer)"
        puts "Better luck next time"

        # Countdown of mistakes left
        $mistakes_left -= 1
    end
    
end



# When the user takes their turn
def user_takes_turn(choice)

    $player = :user

    if choice == "letter"
        # Interface for guessing letters (one player against comp)
        puts "\nPlease type in a letter"
        guess_letter = gets.chomp

        right_or_wrong_letter(guess_letter)
    else
        puts "\nSomeone is feeling courageous, give it a shot by typing in the word"
        guess_word = gets.chomp

        right_or_wrong_word(guess_word)
    end

    taking_turns(:comp)
end


# When the computer takes its turn
def comp_takes_turn

    $player = :comp

    # [Start of with random letters -> random letters in a certain range of known letter -> guess next later based on known words in dictionary]
    randIndex = rand(26)
    guess_letter = ('a'..'z').to_a[randIndex]
    
    puts "\nThe computer guessed: #{guess_letter}"

    right_or_wrong_letter(guess_letter)

    taking_turns(:user)
end


# Toggle between the players
def taking_turns(player)

    between_turns

    if player == :user 
        puts "\n\nYour turn"
        user_takes_turn(give_letter_or_word)
    else
        puts "\n\nComputer's turn"
        comp_takes_turn
    end
end


# Between the turns
def between_turns

    # Close when too many mistakes are taken
    if $mistakes_left <= 0
        close_game
    end

    # Show current $secret_word (letters may have been uncovered and user needs to know number of spaces)
    puts "\n\nFigure out this word:"
    puts $secret_word

    # Close game when all letters found
    if $secret_word == GAME_WORD
        puts "\nAll the letters were found! Great job"
        close_game
    end

    # Show number of mistakes left
    puts "\nMistakes Left: #{$mistakes_left}"
end


# Player chooses they want to answer with a full word or one letter
def give_letter_or_word
    puts "Please type the number or word corresponding to your choice"
    puts "Would you like to solve by \n1. letter \n2. word"

    choice = gets.chomp

    if choice == '1' || choice == 'letter'
        "letter"
    elsif choice == '2' || choice == 'word'
        "word"
    else
        puts "That's not a valid answer"
        give_letter_or_word
    end
end


# How to close the game
def close_game
    puts "That's the end of the game!"

    #TODO
    # replay?

    abort
end






# Option to solve whole word or provide letter

# Save game functionality 

# Send save game data to a file

# Close game functionality

# When program is run, check for saves before starting new, and retrieve data

# Properly use the data to start from save spot

# Establish procedure and refactor



=begin 
------------------------
        PROCEDURE
------------------------ 
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
GAME_WORD = filtered_words[ rand(filtered_words.length - 1) ].chomp

create_secret_word

# TODO: Remove
puts "Game word: #{GAME_WORD}"
puts "hidden: #{$secret_word}"

# Global player variable so that all functions know if the user or computer is taking their turn
$player = :user

# Global number of mistakes left before game over
$mistakes_left = 3

# First turn
taking_turns($player)