require "byebug"

module Slideable

    # THIS IS SCREWING UP MAJORLY
    # FIX!!

    def horizontal_dirs
        possible_moves = []
        HORIZONTAL_DIRS.each do |dx, dy|
            possible_moves += grow_unblocked_moves_in_dir(dx, dy)
        end 
        possible_moves
    end 

    def diagonal_dirs 
        possible_moves = []
        DIAGONAL_DIRS.each do |dx, dy|
            possible_moves += grow_unblocked_moves_in_dir(dx, dy)
        end 
        possible_moves
    end 

    def moves # 
        possible_moves = []        
        if move_dirs.include?(:diagonal)
            possible_moves += diagonal_dirs
        end
        
        if move_dirs.include?(:horizontal)
            possible_moves += horizontal_dirs
        end

        possible_moves
    end 

    private
    HORIZONTAL_DIRS = [
        [0, 1],
        [0, -1],
        [-1, 0],
        [1, 0]
    ]
    DIAGONAL_DIRS = [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1]
    ]

    def move_dirs  # tell us which directions a piece can move, overwritten by subclass 
    end 

    def grow_unblocked_moves_in_dir(dx, dy)
        new_moves = []

        start_x, start_y = position
        current_pos = [start_x + dx, start_y + dy]
        while board.valid_pos?(current_pos) && board[current_pos].is_a?(NullPiece)
            # debugger
            new_moves << current_pos
            new_x = current_pos[0] + dx 
            new_y = current_pos[1] + dy 
            current_pos = [new_x, new_y]
        end 

        # debugger
        if board.valid_pos?(current_pos) && color != board[current_pos].color
            new_moves << current_pos
        end

        # debugger
        new_moves
        # debugger
    end 

end 

module Stepable
    def moves 
        possible_moves = []
        start_x, start_y = position

        move_diffs.each do |diff|
            dx, dy = diff
            current_pos = [start_x + dx, start_y + dy]
            if board.valid_pos?(current_pos) && color != board[current_pos].color 
                possible_moves << current_pos
            end
        end

        possible_moves
    end 

    private 
    def move_diffs 
        #each subclass overwrites
    end 
end 

