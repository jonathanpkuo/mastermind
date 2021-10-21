module Mastermind
  class Secret
    attr_reader :secret

    def initialize()
      @board = Array.new(10, [])
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