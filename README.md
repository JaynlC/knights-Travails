# Knights Trevails Showcase
-----------
-----------

## Problem:
----------------
Build a function knight_moves that shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

## Pseudocode Design:
---------------------
### Overall Plan:
- A. Create a chess grid. 
- B. Return the possible moves into an array
- C. Print Board with Knight Moves

#### A. Create a chess grid.
1. Create a chess board coordinate system. Each square is represented by coordinates (position). 
2. An 8x8 grid is created with coordiante represented in each grid, starting from [0,0] to [7,7]. 
3. Start with an empty array, and create a nested array representing rows and columns. 
4. Ensure the user input is valid. Else return message error with guidance for the input.  

#### B. Return the possible moves into an array

1. Capture all the possible moves the Knight can make from its starting position, into an array.
2. Use binary level order tree traversal by utilsing a queue. The first possible moves enter the queue. Keep looping and evaluating moves in next_moves until matches final position
3. As part of the loop, track the parent moves in a hash via Key representing current position and value as the parent position.
4. Finally create a new loop to evaluate the hash by fetching the parent moves. Every time there is a match, push the parent move to the final array. Break loop once parent coordinate == first position. 
5. Return final array

#### C. Print Board with Knight Moves
1. Translate the array coordinates corerctly such that 0,0 starts from bottom left on the board. 
2. Take the final array containing an array of coordinates (such as final_arr = [[0,0], [2,1]])  and use each_with_index to read the row and column
3. By using index, state the move number by reflecting this at the board coordinates the row and column numbers are. 
4. Return or print the chess board.

## Closing Thoughts
---------------------
- This was an interesting, fun and satisfying challenge to complete.
- Although I had a good idea of what the design should look like, the toughest part was figuring out part B above where I read up a tip to use level order traversal. 
- The solution takes up more memory than needed. I can simplify the next_moves function for example.
- In the future I would create a class to organise the code in an OOP fashion. E.g. a board class and knight class seems sensible.

