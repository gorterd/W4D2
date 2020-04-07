class Piece
    attr_reader :color, :board
    attr_accessor :position

    def initialize(color, board, position)
        @color = color 
        @board = board
        @position = position
    end 

    def to_s
    end 

    def empty?
    end 

    def valid_moves
    end 

    def pos=(val)
    end 
    


end 


class Rook < Piece
end 

class Bishop < Piece
end 

class Queen < Piece
end 

class Knight < Piece
end 

class King < Piece
end 

class Pawn < Piece
end 

class NullPiece < Piece
    include Singleton
end 