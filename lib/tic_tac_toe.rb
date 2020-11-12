require 'pry'

class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS = [
        [6,7,8],
        [3,4,5],
        [0,1,2],
        [0,4,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [2,4,6],
    ]

    def initialize(board = nil)
        @board = board || Array.new(9," ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        string = (string.to_i - 1)
    end

    def move(i, token = "X")
        @board[i] = token
    end

    def position_taken?(i)
        if @board[i] == "X" || @board[i] == "O"
            true
        else
            false
        end
    end

    def valid_move?(i)
        if i.between?(0, 8) && position_taken?(i) == false
            true
        else
            false
        end
    end

    def turn_count
      @board.select {|i| i=="X" || i=="O"}.count
    end

    def current_player
        if turn_count.even?
            "X"
        elsif turn_count.odd?
            "O"
        end
    end

    def turn
        input = gets
        index = input_to_index(input)
        if valid_move?(index) == true
            move(index, current_player)
            display_board
        else
            turn
        end 
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
            win1 = combo[0]
            win2 = combo[1]
            win3 = combo[2]

            board1 = @board[win1]
            board2 = @board[win2]
            board3 = @board[win3]

            if board1 == "X" && board2 =="X" && board3 == "X" ||
                board1 == "O" && board2 =="O" && board3 == "O"
                return combo
            end
        end
        false    
    end

    def full?
        !@board.include? (" ")
    end

    def draw?
        !won? && full?
    end

    def over?
        draw? || won?
    end

    def winner
        if won?
            @board[won?[0]]
        end
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end


end