require_relative 'secret.rb'
require_relative 'board.rb'
require_relative 'feedback.rb'

module Mastermind

  class Game
    attr_reader :is_over
    attr_reader :turn
    attr_reader :secret
    attr_reader :game_board
    attr_reader :feedback
    # attr_reader :display
    # attr_reader :input

    attr_reader :code
    attr_writer :code

    def initialize
      @secret = Secret.new()
      @game_board = Board.new()
      @feedback = Feedback.new()
      # @display = Display.new()
      @is_over = false
      @turn = 0
      @code = []
    end

    def game_play_loop()
      @code = scode.populate_secret()
      while ( is_over == false || turn < 11 ) do
        # Display board
        draw_board()
        # Take input
        input = fetch_input()
        # Check and formulate responses
        responses.bump_data(@turn, scode.scode, @input)
        # Repeat.
        turn += 1
        # Turn > 9 = lose; successfully guess = win.
      end

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

    def fetch_input()
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

game = Mastermind::Game.new()