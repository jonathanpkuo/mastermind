module Mastermind
  class Secret
    attr_reader :scode

    def initialize()
      @scode = []
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