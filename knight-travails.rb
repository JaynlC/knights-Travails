def initialise_board
  n = 8 # 8x8 chess grid
  board = []
  (0...n).each do |row_index|
    board[row_index] = []
    (0...n).each do |column_index|
      board[row_index][column_index] = [column_index, n - 1 - row_index]
    end
  end
  board
end

def knight_board_position(given_position, board)
  n = 8 # 8x8 chess grid
  row, column = given_position
  board_row = n - 1 - column
  board_column = row
  return nil unless valid_move?(board_row, board_column)

  board[board_row][board_column] = "[Knight]"
  board
end

def valid_move?(row, column)
  if (row > 7 || column > 7) || (row.negative? || column.negative?)
    false
  else true
  end
end

def create_board(board)
  puts "\n-------------------------------------------------------------"
  board.each do |row|
    print "|"
    row.each do |cell|
      print "#{cell}|"
    end
    puts "\n-------------------------------------------------------------"
  end
end

def knight_moves(start_position, end_position)
  board = initialise_board
  knight_start_position = knight_board_position(start_position, board)
  knight_start_position.nil? ? nil : knight_position
end


def testing(start)
  end_pos = [1, 2]
  knight_moves(start, end_pos)
end

testing([-1, 0])