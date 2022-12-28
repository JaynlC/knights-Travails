def knight_moves(start_position, end_position)
  board_size = 8 # 8x8 chess grid
  board = initialise_board(board_size)
  return invalid_position_prompt(start_position, end_position, board) unless check_valid_input?(start_position, end_position, board)

  if start_position == end_position
    knight_board_position([start_position], board, board_size)
  else
    next_positions = next_moves(start_position)
    parent_positions_hash = track_parent_positions(start_position, next_positions)
    all_positions_array = level_order_traversal(start_position, next_positions, end_position, parent_positions_hash)

    puts "The path the Knight took is returned below:"
    knight_board_position(all_positions_array, board, board_size)
    all_positions_array
  end
end

def initialise_board(n)
  board = []
  (0...n).each do |row_index|
    board[row_index] = []
    (0...n).each do |column_index|
      board[row_index][column_index] = [column_index, n - 1 - row_index]
    end
  end
  board
end

def check_valid_input?(start_position, end_position, board)
  row_s, column_s = start_position
  row_e, column_e = end_position
  (valid_move?(row_s, column_s) && valid_move?(row_e, column_e)) ? true : false
end

def valid_move?(row, column)
  return false if (row =~ /\D/ || column =~ /\D/)

  if (row > 7 || column > 7) || (row.negative? || column.negative?)
    false
  else true
  end
end

def invalid_position_prompt(start, end_pos, board)
  puts "Invalid Start (#{start}) or End Position (#{end_pos}) selected."
  puts "Please input a valid X and Y coordinate between 0 and 7 for both start and end positions"
  puts "Use the generated Chess Coordinate Board below for help."
  board
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

def track_parent_positions(start_position, next_moves)
  parent_positions = {}
  next_moves.each do |move|
    parent_positions[move] = start_position
  end
  parent_positions
end

def level_order_traversal(start_position, next_moves, end_position, parent_positions)
  queue = next_moves
  current_moves = []
  current_moves << start_position

  until queue.empty?
    check_move = queue.shift
    if check_move == end_position
      current_moves << check_move
      queue = []
    else
      previous_move_children = next_moves(check_move, start_position)
      previous_move_children.each do |move|
        unless parent_positions.include?(move)
          queue << move
          parent_positions[move] = check_move
        end
      end
    end
  end
  evaluate_path(start_position, parent_positions, end_position)
end

def evaluate_path(start_position, parent_positions_hash, end_position)
  all_moves = [end_position]
  previous_move = parent_positions_hash.fetch(end_position)
  all_moves << previous_move

  if previous_move == start_position
    puts "The knight took #{all_moves.length - 1} turns! See below:"
  else
    until all_moves.last == start_position
      fetch_move = parent_positions_hash.fetch(previous_move)
      all_moves << fetch_move
      previous_move = fetch_move
    end
    puts "The knight took #{all_moves.length - 1} turns! See below:"
  end
  all_moves.reverse
end

def knight_board_position(all_moves, board, board_size)
  all_moves.each_with_index do |move, index|
    row, column = move
    knight_row = board_size - 1 - column
    knight_column = row
    if index == 0
      board[knight_row][knight_column] = "Start"
    else
      board[knight_row][knight_column] = "Move: #{index}"
    end
  end
  create_board(board)
end

def create_board(board)
  puts "\n--------------------------------------------------------------------------"
  board.each do |row|
    print "| "
    row.each do |cell|
      print " #{cell} |"
    end
    puts "\n--------------------------------------------------------------------------"
  end
end

# Testing:
# knight_moves([3, 3], [0, 0])
# knight_moves([0, 0], [3, 3])
# knight_moves([3, 3], [2, 1])
# knight_moves([0,0],[4,3])
# knight_moves([3,3],[4,3])
# knight_moves([-1,0],[0,0])
knight_moves([7,7],[0,0])