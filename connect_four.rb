#The connect four game consists of:
#A seven-column, six-row grid that is the playing board
#Two players and their symbols
#The object of the game is to get four tokens in a row.

#Here is my template for creating Player objects.
#What can a Player do, and what does a Player know? 
#Iirc from tic tac toe, the Player class is mainly useful for keeping track of
#whose turn it is.
#Maybe I am going to need a separate class for a computer player?
class Player
  def initialize
  end
end

#Game is going to need:
#A play function that loops until the game is over
#A place marker function
#A game over function that checks if a player has won

#First I am going to write the game for two human players.
#then I will add the option of a computer player 

class Game

  attr_accessor :board
  #Whenever we have a new game, we have a new board and two new players
  def initialize
    #@board[0][0] is top left.
    #@board[5][6] is bottom right.
    @board = [ [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "] ]
    @player_one = Player.new
    @player_two = Player.new
  end

  #What happens in the play function?
  #The play function runs until a win condition is met.
  #This must be checked each turn with a loop.
  #The player is prompted to choose a column.
  #The player's token is inserted in the lowest empty spot in that column.
  #If the board does not contain four in a row, it is the other player's turn.
  def play
    while !game_over?
      print_board
      column_index = get_player_input - 1
      bottom_empty_row_index = find_empty_square(column_index)
      place_token(bottom_empty_row_index, column_index)
    end
    print_board
    puts "Four in a row!"
  end

  #winning combinations:
  #row number is the same and column numbers are sequential
  #column number is the same and row numbers are sequential
  #both row and column numbers are sequential
  def game_over?
    if horizontal_win?
      return true
    elsif vertical_win? 
      return true
    elsif diagonal_win_descending?
      return true
    elsif diagonal_win_ascending?
      return true
    end

    return false
  end

  def horizontal_win?
    i = 0
    while i < 6
      j = 0
      while j < 4
        if @board[i][j..(j + 3)].all? { |x| x == "x" }
          return true
        end
        j += 1
      end
      i += 1
    end
    return false
  end

  def vertical_win?
    i = 0
    while i < 3
      j = 0
      while j < 7
        if (@board[i][j] == "x") && (@board[i + 1][j] == "x") && 
           (@board[i + 2][j] == "x") && (@board[i + 3][j] == "x")
          return true
        end
        j += 1
      end
      i += 1
    end
    return false
  end

  def diagonal_win_descending?
    i = 0
    while i < 3
      j = 0
      while j < 4
        if (@board[i][j] == "x") && (@board[i + 1][j + 1] == "x") &&
           (@board[i + 2][j + 2] == "x") && (@board[i + 3][j + 3] == "x")
          return true
        end
        j += 1
      end
      i += 1
    end
    return false
  end

  def diagonal_win_ascending?
    i = 0
    while i < 3
      j = 7
      while j > 2
        if (@board[i][j] == "x") && (@board[i + 1][j - 1] == "x") &&
           (@board[i + 2][j - 2] == "x") && (@board[i + 3][j - 3] == "x")
              return true
        end
        j -= 1
      end
      i += 1
    end
    return false
  end

  def place_token(row, column)
    @board[row][column] = "x"
  end

  def get_player_input
    puts "What column do you want to drop your piece into? Enter a number 1-7:"
    column = gets.chomp.to_i
    while !(column.between?(1, 7))
      puts "Invalid input, please try again:"
      column = gets.chomp.to_i
    end
    return column
  end

  #Returns the index of the lowest empty spot in the column
  #Returns nil if the column is already full
  def find_empty_square(col)
    i = 5
    while i >= 0
      if @board[i][col] == " "
      return i
      end
      i -= 1
    end
    return nil
  end

  #Prints the current board state to the screen
  def print_board
    print "+---+---+---+---+---+---+---+\n"
    @board.each_with_index do |row|
      row.each_with_index do |column|
        print "| #{column} "
      end
      print "|\n"
      print "+---+---+---+---+---+---+---+\n"   
    end 
    print "  1   2   3   4   5   6   7   \n"
  end

end

game = Game.new
game.play