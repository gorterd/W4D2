require_relative "modules.rb"
require "singleton"

class Piece
    attr_reader :color, :board
    attr_accessor :position

    def initialize(color = nil, board = nil, position = nil)
        @color = color 
        @board = board
        @position = position
    end 

    def to_s
        "#{self.color} #{self.class}"
    end 

    def empty?
    end 

    def valid_moves
        moves.reject { |move| move_in_check?(move) }
    end 

    # def pos=(val)
    # end 

    def move_in_check?(end_pos)
        duped = board.dup 
        duped.move_piece(position, end_pos)
        duped.in_check?(color)
    end 
    
end 


class Rook < Piece
    include Slideable
    
    def symbol
        color == :white ? "\u2656" : "\u265C"
    end
    
    protected
    
    def move_dirs
        [:horizontal]
    end
end 

class Bishop < Piece
    include Slideable
    
    def symbol
        color == :white ? "\u2657" : "\u265D"
    end
    
    protected
    
    def move_dirs
        [:diagonal]
    end
end 

class Queen < Piece
    include Slideable

    def symbol
        color == :white ? "\u2655" : "\u265B"
    end

    protected

    def move_dirs 
        [:diagonal, :horizontal]
    end
end 

class Knight < Piece
    include Stepable

    def symbol  
        color == :white ? "\u2658" : "\u265E"   
    end

    protected 

    def move_diffs
        [[2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1],
        [1, 2],
        [1, -2],
        [-1, 2],
        [-1, -2]
        ]
    end 
end 

class King < Piece
    include Stepable

    def symbol  
        color == :white ? "\u2654" : "\u265A"   
    end

    protected 

    def move_diffs
        [[0, 1],
        [0, -1],
        [-1, 0],
        [1, 0],
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1]
        ]
    end 
end 

class Pawn < Piece
    def symbol
        color == :white ? "\u2659" : "\u265F"
    end

    # def move_dirs
    # end
    
    def moves
        possible_moves = []
        start_x, start_y = position

        forward_steps.each do |diff|
            dx, dy = diff
            current_pos = [start_x + dx, start_y + dy]
            if board.valid_pos?(current_pos) && board[current_pos].is_a?(NullPiece)
                possible_moves << current_pos
            end
        end

        side_attacks.each do |attack|
            dx, dy = attack
            attack_pos = [start_x + dx, start_y + dy]
            if board.valid_pos?(attack_pos) && !board[attack_pos].is_a?(NullPiece) && color != board[attack_pos].color
                possible_moves << attack_pos
            end
        end
        
        possible_moves
    end

    private
    def at_start_row?
        color == :white ? position[0] == 6 : position[0] == 1  # 1 --> and 6 -->
    end

    def forward_dirs # return 1 or -1
        color == :white ?  -1 : 1
    end 

    def forward_steps 
        steps = [[forward_dirs, 0]]
        steps << [forward_dirs * 2, 0] if at_start_row? 
        steps 
    end 

    def side_attacks
        #white [-1,1], [-1,-1]
        #black [1,1] [1,-1]
        attacks = [[forward_dirs, 1], [forward_dirs, -1]]
    end
end 

class NullPiece < Piece
    include Singleton

    attr_reader :color, :symbol

    def symbol
        " "
    end

    # def initialize
    #     @color
    #     @symbol
    # end

    def moves        
    end
end 