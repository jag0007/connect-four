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

    it "should throw exception if board would overflow" do
      new_board = GameBoard.new
      expect {7.times.each { new_board.play_checker(0, 'x')}}.to raise_error(ColumnFull)
    end
  end

  describe "player_win?" do
    it "should return false if no four in a row found" do
      new_board = GameBoard.new
      expect(new_board.player_win?).to eql(false)
    end

    it "should return token if four found on diagonal" do
      new_board = GameBoard.new
      3.times.each { new_board.play_checker(3, 'x')}
      4.times.each { new_board.play_checker(4, 'x')}
      5.times.each { new_board.play_checker(5, 'x')}
      6.times.each { new_board.play_checker(6, 'x')}
      expect(new_board.player_win?).to eql('x')
    end

    it "should return token if four found on row" do
      new_board = GameBoard.new
      4.times { |column| new_board.play_checker(column, 'x')}
      expect(new_board.player_win?).to eql('x')
    end

    it "should return token if four found on column" do 
      new_board = GameBoard.new
      4.times { new_board.play_checker(0, 'x')}
      expect(new_board.player_win?).to eql('x')
    end
  end
end