def initialise_board(knight_position)
  # 8x8 chess grid
  board = []
  8.times do |row_index|
    board[row_index] = []
    8.times do |column_index|
      board[row_index][column_index] = nil
    end
  end
  row, column = knight_position
  board[row][column] = "Knight = (#{row}, #{column})"
  board
#   create_board(board)
end

def create_board(board)
  puts "\n----------------"
  board.each do |row|
    print "|"
    row.each do |cell|
      print "#{cell}|"
    end
    puts "\n----------------"
  end
end

def knight_moves(start_position, end_position)
  initialise_board(start_position)

end

def testing
  start = [0, 0]
  end_pos = [1, 2]
  knight_moves(start, end_pos)
end

testing