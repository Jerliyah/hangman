
# The user always takes the first turn
$person = :user


# Record everthing in terminal for game so that save data is more exact
$terminal_history = []
def to_terminal_and_history(statement)
    puts statement
    $terminal_history << statement
end


# Format the $game_word into a secret for viewing
def create_secret_word
    # Array
    letters = []

    # Push each letter into array
    $game_word.each_char do |letter| 
        letters << letter 
    end

    # Format secret word to have letters replaced with underscores and spacing
    $secret_word = letters.join(" ").gsub( /[a-z]/, "_")
end


