module Mastermind
  class Secret

    def initialize()
    end

    def populate_secret(array)
      until array.length == 4 do
        array.push( (rand * 10).to_i )
      end
      return array
    end

    def wipe_secret(array)
      array.pop(4)
      return array
    end

  end
end