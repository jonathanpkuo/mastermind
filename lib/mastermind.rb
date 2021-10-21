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

    def initialize
      @scode= Secret.new()
      @gboard = Board.new()
      @responses = Feedback.new()
      @display = Display.new()
      @is_over = false
      @turn = 1
    end

    def game_play_loop()
      # Display board
      # Take input
      # Check and formulate responses
      # Repeat.
      # Turn > 10 = lose; successfully guess = win.

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
  end

end