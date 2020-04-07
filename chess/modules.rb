module Slideable
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
            new_moves << current_pos
            current_pos[0] += dx 
            current_pos[1] += dy 
        end 

        new_moves
    end 

end 

module Stepable
    def moves 
        possible_moves = []
        if move_diffs 
    end 

    private 
    def move_diffs 
    end 
end 