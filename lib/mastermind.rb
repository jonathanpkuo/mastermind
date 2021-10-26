require_relative 'secret.rb'
require_relative 'board.rb'
require_relative 'feedback.rb'

module Mastermind

  class Game
    attr_reader :is_over
    attr_reader :turn
    attr_reader :scode
    attr_reader :gboard
    attr_reader :responses
    attr_reader :display
    attr_reader :input

    def initialize
      @scode= Secret.new()
      @gboard = Board.new()
      @responses = Feedback.new()
      # @display = Display.new()
      @input = []
      @is_over = false
      @turn = 0
      @buffer = []
    end

    def game_play_loop()
      
      # Display board
      # Take input
      # Check and formulate responses
      # Repeat.
      # Turn > 9 = lose; successfully guess = win.

    end

    def draw_board()
      gboard.board
      responses.feedback

      i = 0
      if gboard.board.length != responses.feedback.length
        return "Array Mismatch Error"
      end

      while (i < gboard.board.length) do
        puts "#{gboard.board[i]} : #{responses.feedback[i]}"
        i += 1
      end
    end

    def validator()
      buffer = []
      while buffer.length < 4 do
        input = gets.chomp
        if input.downcase == "b" && buffer.length > 0
          buffer.pop()
        end
        while ( input.to_i < 0 && input.to_i > 9 )
          puts "Input Invalid (Move out of scope)."
          input = gets.chomp
        end
        if buffer.length < 4
          buffer.push(input.to_i)
        end
      end
      return buffer
    end


  end
end