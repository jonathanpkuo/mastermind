module Mastermind
  class Secret

    def initialize()
    end

    def populate_secret(array)
      until array.length == 4 do
        new = ( rand * 10 ).to_i
        if !( array.any? { |x| x == new })
          array.push(new)
        end
      end
    end

    def wipe_secret(array)
      array.pop(4)
      return array
    end

  end
end