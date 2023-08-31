
class ColumnFull < StandardError
end

class GameBoard
  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    @board = Array.new(columns) {Array.new(rows)}
  end

  def slot_empty?(row, column)
    @board[column][row].nil?
  end

  def get_checker(row, column)
    return nil if row < 0 || row > @rows || column < 0 || column > @columns
    @board[column][row]
  end

  def play_checker(column, token)
    raise ColumnFull.new if first_empty_row(column).nil? 
    @board[column][first_empty_row(column)] = token 
  end

  def first_empty_row(column)
    @board[column].index { |x| x.nil? }
  end

  def player_win?
    6.times.each do |row| 
      7.times.each do |column|
        if slot_empty?(row, column) then next end
        return get_checker(row, column) if [get_checker(row+1, column+1), get_checker(row+2, column+2), get_checker(row+3, column+3)].all? {|x| x==get_checker(row, column)}
        return get_checker(row, column) if [get_checker(row, column+1), get_checker(row, column+2), get_checker(row, column+3)].all? {|x| x == get_checker(row, column)}
        return get_checker(row, column) if [get_checker(row+1, column), get_checker(row+2, column), get_checker(row+3, column)].all? {|x| x == get_checker(row, column)}
      end
    end
    return false
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
