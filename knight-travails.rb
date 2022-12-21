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
  knight_start_position.nil? ? nil : knight_start_position
  next_positions = next_moves(start_position)
  # puts "#{next_positions}"
  level_order_traversal(start_position, next_positions, end_position)
end

def next_moves(curr_position, start_position = nil)
  row, column = curr_position
  new_moves = []
  (1..2).each do |i|
    j = 1
    i == 1 ? j = 2 : j = 1

    if valid_move?(row + i, column + j) && [row + i, column + j] != start_position then new_moves.push([row + i, column + j]) end
    if valid_move?(row + i, column - j) && [row + i, column - j] != start_position then new_moves.push([row + i, column - j]) end
    if valid_move?(row - i, column + j) && [row - i, column + j] != start_position then new_moves.push([row - i, column + j]) end
    if valid_move?(row - i, column - j) && [row - i, column - j] != start_position then new_moves.push([row - i, column - j]) end
  end
  new_moves
end

def level_order_traversal(start_position, first_moves, end_position)
  queue = first_moves
  current_moves = []
  current_moves << start_position
  until queue.empty?
    puts "#{queue}"
    check_move = queue.shift
    puts "#{check_move}"
    if check_move == end_position
      current_moves << check_move
      queue = []
    else
      #resume here, find way of adding all moves to current_moves array. Save parent nodes. 
      child_moves = next_moves(check_move, start_position)
      child_moves.each {|move| queue << move }
    end
  end
  current_moves
end


def testing(start, end_pos)
  knight_moves(start, end_pos)
end

testing([3, 3], [0, 0])