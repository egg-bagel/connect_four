class Player

  attr_accessor :token

  def initialize(token)
    @token = token
  end

end

class Game

  attr_accessor :board, :player_one, :player_two, :to_play_next

  def initialize
    @board = [ [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "],
               [" ", " ", " ", " ", " ", " ", " "] ]
    @player_one = Player.new("x")
    @player_two = Player.new("o")
    @to_play_next = @player_one
  end

  def play
    while !game_over?
      print_board
      announce_turn       
      column_index = get_player_input - 1
      bottom_empty_row_index = find_empty_square(column_index)
      place_token(bottom_empty_row_index, column_index)
      switch_players
    end

    print_board
    if @to_play_next == @player_two
      puts "Player One wins with four in a row!"
    else
      puts "Player Two wins with four in a row!"
    end
  end

  #checks win conditions
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
        if (@board[i][j] == @player_one.token) && (@board[i][j + 1] == @player_one.token) &&
           (@board[i][j + 2] == @player_one.token) && (@board[i][j + 3] == @player_one.token)
          return true
        elsif (@board[i][j] == @player_two.token) && (@board[i][j + 1] == @player_two.token) &&
              (@board[i][j + 2] == @player_two.token) && (@board[i][j + 3] == @player_two.token)
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
        if (@board[i][j] == @player_one.token) && (@board[i + 1][j] == @player_one.token) && 
           (@board[i + 2][j] == @player_one.token) && (@board[i + 3][j] == @player_one.token)
          return true
        elsif (@board[i][j] == @player_two.token) && (@board[i + 1][j] == @player_two.token) && 
              (@board[i + 2][j] == @player_two.token) && (@board[i + 3][j] == @player_two.token)
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
        if (@board[i][j] == @player_one.token) && (@board[i + 1][j + 1] == @player_one.token) &&
           (@board[i + 2][j + 2] == @player_one.token) && (@board[i + 3][j + 3] == @player_one.token)
          return true
        elsif (@board[i][j] == @player_two.token) && (@board[i + 1][j + 1] == @player_two.token) &&
              (@board[i + 2][j + 2] == @player_two.token) && (@board[i + 3][j + 3] == @player_two.token)
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
        if (@board[i][j] == @player_one.token) && (@board[i + 1][j - 1] == @player_one.token) &&
           (@board[i + 2][j - 2] == @player_one.token) && (@board[i + 3][j - 3] == @player_one.token)
              return true
        elsif (@board[i][j] == @player_two.token) && (@board[i + 1][j - 1] == @player_two.token) &&
              (@board[i + 2][j - 2] == @player_two.token) && (@board[i + 3][j - 3] == @player_two.token)
        end
        j -= 1
      end
      i += 1
    end
    return false
  end

  def announce_turn
    if @to_play_next == @player_one
      puts "Player One to play"
    elsif @to_play_next == @player_two
      puts "Player Two to play"
    end
  end

  #Marks the player's chosen square with their token
  def place_token(row, column)
    @board[row][column] = @to_play_next.token
  end

  #Prompts the player to choose a column for their token
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

  def switch_players
    if @to_play_next == @player_one
      @to_play_next = @player_two
    elsif @to_play_next == @player_two
      @to_play_next = player_one
    end
    return @to_play_next
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

play_again = "Y"
while play_again == "Y"
  game = Game.new
  game.play
  puts "Would you like to play again? Enter Y/N:"
  play_again = gets.chomp.upcase
end