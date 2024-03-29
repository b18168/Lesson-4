class TicTacToe

def begin
  begin_spel
end

  

    def clear
            require 'rbconfig'
            host_os = RbConfig::CONFIG['host_os']
            case host_os
           
            when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
                    system('cls')
            else
                    system('clear')
            end
    end



#Speler kan spelen zolang als hij wil
def play
  while true
    speel_game
  break unless speel_opnieuw?
  end
  puts "Bedankt voor het spelen!"
end

private

# Reset variabelen voor een nieuwe game
def begin_spel
  @zetten = 0
  @player = PIECE[:x]
  @board = []
  9.times { @board << PIECE[:blank] }
end

# play a game of tic-tac-toe
def speel_game
    begin_spel
    puts "Veel succes!"

  while true
    laat_bord_zien
    set_move get_valid_move
    @zetten += 1
  break if game_over?
    switch_player
  end
end

# Display current state of the game board
def laat_bord_zien
print "\t"
@board.each_with_index do |piece, index|
display_piece_by_location(piece, index)
end
end

# Display a game piece and separators between game pieces
# based on the location of the piece on the game board
def display_piece_by_location(piece, location)
if location == 2 || location == 5
print_piece(piece, "\n\t")
print_separator_line
elsif location == 8
print_piece(piece, "\n")
else
print_piece(piece, SEPARATOR[:vertical])
end
end

# Display a single game piece and separator(s) around it
def print_piece(piece, separator)
print " #{ piece } #{ separator }"
end

# Display the line that separates two game board rows
def print_separator_line
line = ""
3.times do
3.times { line << SEPARATOR[:horizontal] }
line << SEPARATOR[:cross]
end
puts line[0...line.length - 1]
print "\t"
end

# Set location specified by move to the current player's piece
def set_move move
@board[move] = @player
end

# Get a move that is valid
def get_valid_move
while true
move = get_move
if valid_move?(move)
return move
else
puts "Position #{ move + 1 } is occupied...Enter a free position"
end
end
end

# Get a position to place a new piece
def get_move
while true
question = "Player #{ @player }, Enter play position (1 - 9)"
move = (get_response_for question).to_i
if move.between?(1, 9)
return move - 1
else
puts "Invalid input...Enter a number between 1 and 9"
end
end
end

# Get the response to a question from the player
def get_response_for question
print question + ": "
gets.chomp
end

# Check if a move is valid
def valid_move? move
@board[move] == PIECE[:blank]
end

# Determine if game is over.
# Display appropriate message if the game is over.
def game_over?
win_formations = [ [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8],
[2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 7] ]
win_formations.each do |win_formation|
if formation_met?(win_formation)
end_game_message "Player #{ @player } Won."
return true
end
end
draw?
end

  # Determine if a player has pieces in a certain formation
def formation_met? formation
pieces = [@board[formation[0]], @board[formation[1]], @board[formation[2]]]
pieces.uniq.length == 1 && (pieces[0] != PIECE[:blank])
end

# Display relevant message when the game is over
def end_game_message(message)
system "clear"
puts "GAME OVER: #{ message }"
laat_bord_zien
end

# Determine if game ended in a draw; display message if so
def draw?
if @zetten >= 9
end_game_message "Game Ended in a draw."
true
else
false
end
end

# Switch the current player
def switch_player
if @player == PIECE[:x]
@player = PIECE[:o]
else
@player = PIECE[:x]
end
end

# Determine if user what to play another tic-tac-toe game
def speel_opnieuw?
while true
speel_opnieuw = (get_response_for "Play again (y/n)").downcase
case speel_opnieuw
when 'y', 'yes' then return true
when 'n', 'no' then return false
end
end
end
end

if $PROGRAM_NAME == __FILE__
tic_tac_toe = TicTacToe.new
tic_tac_toe.play
end