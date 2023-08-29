class TurnBasedGame
  def initialize(game, players)
    @game = game
    @players = players
    @active_player = players.first
  end

  def play
    until game.game_over?
      game.take_turn(@active_player)
      game.set_next_active_player 
    end
    game.declare_winner
  end 
end

class ConnectFour
  def initialize(board, players)
  end

  def take_turn(active_player)
    player_move = active_player.get_move
    loop do
      player_move = active_player.get_move()
      break if self.board.valid?(player_move)
    end
    self.board.play_move(active_player, player_move)
  end
end

class GameBoard
  def initialize(rows = 6, columns = 7)
    @board = Array.new(columns, Array.new(rows))
  end

  def slot_empty?(row, column)
    @board[column][row].nil?
  end

  def get_checker(row, column)
    @board[column][row]
  end

  def play_checker(column, token)
    @board[@board.index { |x| !x.nil?}] = token 
  end

end

describe GameBoard do
  describe "NewGameBoard" do
    new_board = GameBoard.new
    
    it "should be empty" do
      6.times { |row| 7.times { |column| expect(new_board.slot_empty?(row, column)).to eql(true) }}
    end
  end

  describe "play_checker" do 
    new_board = GameBoard.new

    it "should add token to bottom of empty column" do
      new_board.play_checker(0, 'x')
      expect(new_board.get_checker(0,0)).to eql('x')
    end
  end
end