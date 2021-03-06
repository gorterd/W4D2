require_relative "piece"

class Board 
    attr_reader :grid, :sentinel
    
    def initialize(sentinel = NullPiece.instance)
        @sentinel = sentinel
        build_board
    end 

    def build_pawn_row(color)
        i = color == :white ? 6 : 1 

        8.times do |j|
            self[[i,j]] = Pawn.new(color, self, [i,j])
        end
    end

    def build_back_row(color)
        pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

        i = color == :white ? 7 : 0 

        pieces.each_with_index do |piece, j|
            self[[i,j]] = piece.new(color, self, [i,j])
        end
    end

    def build_board
        @grid = Array.new(8) {Array.new(8, NullPiece.instance)}
        
        build_back_row(:white)
        build_back_row(:black)
        build_pawn_row(:white)
        build_pawn_row(:black)
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
        self[start_pos] = sentinel
        self[end_pos] = current_piece

        nil
    end 

    def pieces
        pieces_arr = []

        grid.each do |row|
            row.each do |ele|
                pieces_arr << ele unless ele.is_a?(NullPiece)
            end
        end

        pieces_arr
    end 

    def in_check?(color)
        opponent_arr = []
        king_pos = nil
        pieces.each do |piece|
            opponent_arr << piece if piece.color != color 
            if piece.class == King && piece.color == color
                king_pos = piece.position
            end
        end

         opponent_arr.any? do |oppo_piece|
            oppo_piece.moves.include?(king_pos)
         end
    end

    def checkmate?(color)
        pieces.all? do |piece|
            piece.valid_moves.empty? || piece.color != color
        end

        # own_pieces = pieces.select { |p| p.color == color }
        # own_pieces.all? { |p| p.valid_moves.empty? }
    end

    def dup
        duped = Board.new
        grid.each_with_index do |row, x|
            row.each_with_index do |piece, y|
                duped[x, y] = piece.class.new(piece.color, duped, [x, y])
            end 
        end 
        duped 
    end


    # def add_piece(piece, pos)

    # end

end


# * 0 1 2 3 4 5 6 7
# 0 r k b Q K b k r
# 1 p p p p p p p p
# 2 . . . . . . . .
# 3 . . . . . . . .
# 4 . . . . . Q . .
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