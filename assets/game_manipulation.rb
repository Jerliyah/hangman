
# Welcome message
def welcome
    to_terminal_and_history("\n\n====================================")
    to_terminal_and_history("==========  Hangman Game  ==========")
    to_terminal_and_history("====================================")
end


# Closing the game
def close_game
    to_terminal_and_history("That's the end of the game!")

    #TODO
    # replay?

    abort
end


# Save the current game for next run
def save_game
    saved_game_file = File.open("saved-game.txt", "w")

    saved_game_file.puts "{ :$game_word => \"#{$game_word}\" , :$secret_word => \"#{$secret_word}\" , :$mistakes_left => \"#{$mistakes_left}\" , :$terminal_history => #{$terminal_history} }"

    saved_game_file.close  

    to_terminal_and_history("\n\nGame has been saved")
    to_terminal_and_history("You will have the option to open saved game or start a new one next time") 
    to_terminal_and_history("See ya!")

    abort
end


def start_saved_game
    saved_game_file = File.open("saved-game.txt", "r")
    content = saved_game_file.read.chomp
    content_obj = eval(content)
    
    $game_word = content_obj[:$game_word]
    $secret_word = content_obj[:$secret_word]
    $mistakes_left = content_obj[:$mistakes_left].to_i
    $terminal_history = content_obj[:$terminal_history]

    # Puts terminal history to terminal so user sees an exact save
    $terminal_history.each do |statement| puts statement end

    # Global player variable so that all functions know if the user or computer is taking their turn
    $player = :user

    welcome

    # First turn
    taking_turns($player)
end


def new_game
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
    $game_word = filtered_words[ rand(filtered_words.length - 1) ].chomp

    create_secret_word

    # Global player variable so that all functions know if the user or computer is taking their turn
    $player = :user

    # Global number of mistakes left before game over
    $mistakes_left = 3

    welcome

    # TODO: Remove
    to_terminal_and_history("Game word: #{$game_word}")
    to_terminal_and_history("hidden: #{$secret_word}")

    # First turn
    taking_turns($player)
end

