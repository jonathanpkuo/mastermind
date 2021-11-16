module Mastermind
  class Secret

    def initialize()
    end

    def populate_secret(array)
      until array.length == 4 do
        new = ( rand * 10 ).to_i
        puts new
        puts "#{ !(array.any? { |x| x == new }) }"
        if !( array.any? { |x| x == new })
          array.push(new)
        end
      end
      return array
    end

    def wipe_secret(array)
      array.pop(4)
      return array
    end

  end
end