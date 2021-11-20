require_relative 'secret.rb'
require_relative 'board.rb'
require_relative 'feedback.rb'
require_relative 'input.rb'
require_relative 'solver.rb'

module Mastermind

  class Game
    attr_reader :is_over
    attr_writer :is_over
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
      @solver = Solver.new()
      @is_over = false
      @@turn = 0
      @code = []
      main_menu()
    end

    def main_menu()
      puts "Select game mode : "
      puts "(1) - Single Player"
      puts "(2) - PvP"
      puts "(3) - Single Player (Player is code master) *WIP*"
      puts "(4) - Exit"
      # directly calls the corresponding mode
      game_play_loop(@input_manager.menu_input)
    end

    # Mode 0 = normal single player (AI picks code), 1 = pvp (player picks code), 2 = pve (player picks code - not implemented yet)
    def game_play_loop(mode = 0)
      # if-else set calls code generation as needed.
      if mode == 0
        @code = secret.populate_secret(@code)
      elsif mode == 1
        @code = @input_manager.input_loop([], mode)
      end
      while ( @is_over == false && @@turn < 10 ) do
        puts "Turn: #{@@turn + 1}"
        puts "Game over!" if @is_over == true
        draw_board()
        # Take input
        input = input_manager.input_loop([])
        # Check and formulate responses
        game_board.board[@@turn] = input
        @is_over = feedback.bump_data(@@turn, @code, input)
        if @is_over == true
          draw_board()
          main_menu()
        end
        # Repeat.
        @@turn += 1
        # Turn > 9 = lose; successfully guess = win.
        if @@turn > 9 
          @is_over == true
          puts "Game Over: You Lose!"
          draw_board()
          main_menu()
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