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

    def initialize
      @scode= Secret.new()
      @gboard = Board.new()
      @responses = Feedback.new()
      @is_over = false
      @turn = 1
    end
  end

end