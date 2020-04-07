require_relative "Piece"

class Board 
    
    def initialize 
        @grid = self.build_board
    end 

    def build_board
        board = Array.new(8) {Array.new(8, NullPiece.instance)}
    
        [0,1].each do |x|
            (0..7).each do |y|
                board[x][y] = Piece.new(:black, self, [x,y])
            end 
        end 

        [6,7].each do |x|
            (0..7).each do |y|
                board[x][y] = Piece.new(:white, self, [x,y])
            end 
        end 
        board
    end 
    
    def [](pos)
        x, y = pos 
        @grid[x][y]
    end 

    def []=(pos, new_val)
        x, y = pos 
        @grid[x][y] = new_val
    end 

    def valid_pos?(pos)
        x, y = pos
        x.between?(0,7) && y.between?(0,7)
    end

    def move_piece(start_pos, end_pos)
        raise ArgumentError.new("There is no piece at starting position.") if self[start_pos].is_a?(NullPiece)
        raise ArgumentError.new("Position out of bounds") if !valid_pos?(start_pos) || !valid_pos?(end_pos) 

        current_piece = self[start_pos]
        current_piece.position = end_pos 
        self[start_pos] = nil
        self[end_pos] = current_piece
    end 

    def add_piece(piece, pos)

    end

end


# * 0 1 2 3 4 5 6 7
# 0 r k b Q K b k r
# 1 p p p p p p p p
# 2 . . . . . . . .
# 3 . . . . . . . .
# 4 . . . . . . . .
# 5 . . . . . . . .
# 6 p p p p p p p p
# 7 r k b K Q b k r

# Stepping:
#     Knight: [0,1], [0,6]    || [7,1], [7,6]
#     Kings:  [0,4]           || [7,3]
# Sliding: 
#     Rook:   [0,0], [0,7]    || [7,0], [7,7]
#     Bishop: [0,2], [0,5]    || [7,2], [7,5]
#     Queen:  [0,3]           || [7,4]
# Pawns:
#             [1][0..7]       || [6][0..7]