module Mastermind
  class Board
    attr_reader :board
    attr_writer :board
    attr_reader :secret

    def initialize()
      @board = []
      @secret = []
    end

    def populate_secret(array)
      until array.length == 4 do
        array.push( (rand * 10).to_i )
      end
      return array
    end

    def wipe_secret(array)
      while array.length > 0 do
        array.pop()
      end
    end

    end
  end
end