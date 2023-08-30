require './lib/gameboard'

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


describe GameBoard do
  describe "NewGameBoard" do
    new_board = GameBoard.new
    
    it "should be empty" do
      6.times { |row| 7.times { |column| expect(new_board.slot_empty?(row, column)).to eql(true) }}
    end
  end

  describe "play_checker" do 

    it "should add token to bottom of empty column" do
      new_board = GameBoard.new
      new_board.play_checker(0, 'x')
      expect(new_board.get_checker(0,0)).to eql('x')
    end

    it "should stack checker when column not empty" do
      new_board = GameBoard.new
      new_board.play_checker(0, 'x')
      new_board.play_checker(0, 'y')
      expect(new_board.get_checker(1,0)).to eql('y')
    end
  end
end