require_relative 'secret.rb'
require_relative 'board.rb'
require_relative 'feedback.rb'
require_relative 'input.rb'

module Mastermind

  class Game
    attr_reader :is_over
    attr_reader :turn
    attr_reader :secret
    attr_reader :game_board
    attr_reader :feedback
    attr_reader :input_manager

    attr_reader :code
    attr_writer :code

    def initialize
      @secret = Secret.new()
      @game_board = Board.new()
      @feedback = Feedback.new()
      @input_manager = Input_Manager.new()
      # @display = Display.new()
      @is_over = false
      @@turn = 0
      @code = []
    end

    # Mode 0 = normal single player (AI picks code), 1 = pvp (player picks code)
    def game_play_loop(mode = 0)
      if mode == 0
        @code = secret.populate_secret(@code)
      elsif mode == 1
        @code = @input_manager.input_loop([], mode)
      end
      while ( @is_over == false && @@turn < 10 ) do
        # Display board
        puts "Turn: #{@@turn + 1}"
        puts "Game over!" if @is_over == true
        draw_board()
        # Take input
        input = input_manager.input_loop([])
        # Check and formulate responses
        game_board.board[@@turn] = input
        feedback.bump_data(@@turn, @code, input)
        # Repeat.
        @@turn += 1
        # Turn > 9 = lose; successfully guess = win.
        if @@turn > 9 
          @is_over == true
          puts "Game Over: You Lose!"
          draw_board()
        end
      end

    end

    def draw_board()
      game_board.board
      feedback.feedback

      i = 0
      if game_board.board.length != feedback.feedback.length
        return "Array Mismatch Error"
      end

      while (i < game_board.board.length) do
        puts "#{game_board.board[i]} : #{feedback.feedback[i]}"
        i += 1
      end
    end
    
  end
end

# game = Mastermind::Game.new()