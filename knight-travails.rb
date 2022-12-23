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
  puts "#{next_positions}"
  level_order_traversal(start_position, next_positions, end_position)
end

def next_moves(curr_position, start_position = nil)
  row, column = curr_position
  p row
  p column
  p start_position
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
  parent_move = {}
  first_moves.each do |move|
    parent_move[move] = start_position
  end
  # puts "#{parent_move}"
  queue = first_moves
  p "first queue = #{queue}"
 
  current_moves = []
  current_moves << start_position

  until queue.empty?
    # puts "#{queue}"
    check_move = queue.shift
    if check_move == end_position
      current_moves << check_move
      queue = []
    else
      p "This is Queue: #{queue}"
      p parent_move
      previous_move_investigated = queue.shift
      break if previous_move_investigated.nil?

      previous_move_children = next_moves(previous_move_investigated, start_position)
      previous_move_children.each do |move| 
        unless parent_move.include?(move)
          queue << move
          parent_move[move] = previous_move_investigated
          # puts "#{parent_move}"
        end
      end
    end
  end
  parent_move
  # parent_move.fetch(end_position)
  evaluate_path(start_position, parent_move, end_position)
end

def evaluate_path(start_position, parent_move_hash, end_position)
  p parent_move_hash
  all_moves = [end_position]
  previous_move = parent_move_hash.fetch(end_position)
  all_moves << previous_move
  puts "#{previous_move}"
  
  if previous_move == start_position
    all_moves.reverse
  else
    until all_moves.last == start_position
      fetch_move = parent_move_hash.fetch(previous_move)
      all_moves << fetch_move
      previous_move = fetch_move
    end
    puts "The knight took #{all_moves.length - 1} turns!"
    all_moves.reverse
    
  end
end

def testing(start, end_pos)
  knight_moves(start, end_pos)
end

# testing([3, 3], [0, 0])
# testing([0, 0], [3, 3])
# testing([3, 3], [2, 1])
# testing([0,0],[4,3])
# testing([3,3],[4,3])
testing([3,3],[4,3])
