module Mastermind
  class Board
    attr_reader :board

    def initialize()
      @board = Array.new(10, [])
    end
  end


end