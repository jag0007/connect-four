
class GameBoard
  def initialize(rows = 6, columns = 7)
    @board = Array.new(columns) {Array.new(rows)}
  end

  def slot_empty?(row, column)
    @board[column][row].nil?
  end

  def get_checker(row, column)
    @board[column][row]
  end

  def play_checker(column, token)
    @board[0][@board[0].index { |x| x.nil?} ] = token 
  end

  def print_board
    6.times.reverse_each do |row|
      7.times do |column|
        print (get_checker(row, column).nil? ? '0' : get_checker(row, column))
        print " "
      end
      puts 
    end
    puts
  end

end
