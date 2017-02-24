
# Reformat secret_word when letters are found
def reformat_secret_word(guess_letter)
    locations = $game_word.split('').each_index.select do |letter| $game_word[letter] == guess_letter end

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

    if $game_word.include? guess_letter
        to_terminal_and_history("\nNice")

        # Show found letters
        $secret_word = reformat_secret_word(guess_letter)

    else
        to_terminal_and_history("\nNope, that's not it")

        # Countdown of mistakes left
        $mistakes_left -= 1
    end

end


# Actions based on right on wrong word answer
def right_or_wrong_word(guess_word)

    if guess_word == $game_word
        to_terminal_and_history("\nAmazing! The puzzle has been solved, great job.")
        close_game

    else
        to_terminal_and_history("\nOh my gosh! You did it! (it = providing the wrong answer)")
        to_terminal_and_history("Better luck next time")

        # Countdown of mistakes left
        $mistakes_left -= 1
    end
    
end


# Player chooses whether they want to answer with a full word or one letter
def give_letter_or_word
    to_terminal_and_history("Please type the number or word corresponding to your choice")
    to_terminal_and_history("Would you like to solve by: \n1. letter \n2. word")

    choice = gets.chomp
    $terminal_history << choice

    if choice == '1' || choice == 'letter'
        "letter"
    elsif choice == '2' || choice == 'word'
        "word"
    elsif choice == '--save'
        save_game
    else
        to_terminal_and_history("That's not a valid answer")
        give_letter_or_word
    end
end


# At run, when saved data found
def saved_or_new
    to_terminal_and_history("Would you like to reopen it or start a new game? (type number)")
    to_terminal_and_history("1. Saved game \n2. New game")

   choice = gets.chomp
   $terminal_history << choice

   if choice == '1'
       start_saved_game

    elsif choice == '2'
        new_game

    else
        to_terminal_and_history("That's not a valid answer")
        saved_or_new
    end
end