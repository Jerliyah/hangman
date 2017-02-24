
# Toggle between the players
def taking_turns(player)

    between_turns

    if player == :user 
        to_terminal_and_history("\n\n---------- Your turn ----------")
        user_takes_turn(give_letter_or_word)
    else
        to_terminal_and_history("\n\n---------- Computer's turn ----------")
        comp_takes_turn
    end
end


# Between the turns
def between_turns

    # Close when too many mistakes are taken
    if $mistakes_left <= 0
        close_game
    end

    # Remind user that they can save their game
    to_terminal_and_history("\n*** Rmbr: You can save game by typing --save ***\n")

    # Show current $secret_word (letters may have been uncovered and user needs to know number of spaces)
    to_terminal_and_history("\n\nFigure out this word:")
    to_terminal_and_history($secret_word)

    # Close game when all letters found
    if $secret_word == $game_word
        to_terminal_and_history("\nAll the letters were found! Great job")
        close_game
    end

    # Show number of mistakes left
    to_terminal_and_history("\nMistakes Left: #{$mistakes_left}")
end


# When the user takes their turn
def user_takes_turn(choice)

    $player = :user

    if choice == "letter"
        # Interface for guessing letters (one player against comp)
        to_terminal_and_history("\nPlease type in a letter")
        guess_letter = gets.chomp
        $terminal_history << guess_letter

        if guess_letter == "--save" then save_game end

        right_or_wrong_letter(guess_letter)
    else
        to_terminal_and_history("\nSomeone is feeling courageous, give it a shot by typing in the word")
        guess_word = gets.chomp
        $terminal_history << guess_word

        if guess_word == "--save" then save_game end

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
    
    to_terminal_and_history("The computer guessed: #{guess_letter}")

    right_or_wrong_letter(guess_letter)

    taking_turns(:user)
end