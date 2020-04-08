require "colorize"
require_relative "board"
require_relative "cursor"

class Display

    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        system("clear")
        board.grid.each_with_index do |row, i|
            row.each_with_index do |piece, j|
                color = (i + j).even? ? :blue : :magenta     
                if [i,j] == cursor.cursor_pos
                    color = cursor.selected ? :red : :light_black
                end
                print (piece.symbol + " ").colorize(:background=>color)
            end
            puts
        end
        nil
    end

end

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    d = Display.new(b) 
    while true 
        d.cursor.get_input
        d.render
    end
    d.render
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

# 0,0 grey
# 0,1 white

# 1,0 white
# 1,1 grey

# row 0: odds are white, evens are grey
#     row + index -> odd for white, even for grey
# row 1: odds are grey, even are white
#     row + index -> odd for white, even for grey
