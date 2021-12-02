module Mastermind
  class Solver
    def initialize()
      @shift = false
      @guesses = Array.new()
    end

    def solution_algo(array_board, turn, num_cor, num_pla)

      

    end

    def shift_one(array)
      no_shift = find_confirmed(array)  #unneccessary?

      

    end

    def find_confirmed(array)
      temp = Array.new()
      array.each_with_index do | x, index |
        temp[index] = x.can_move?()
      end
      return temp
    end

    def populate_guesses(array)
      until array.length == 4
        array.push(Guesstimate.new())
      end
      return array
    end

  end

  class Guesstimate

    def initialize()
      @value = 1
      @movable = true
      @frozen = false
      @set = false
    end

    def freeze()
      @frozen = true
    end

    def unfreeze()
      @frozen = false
    end

    def unlock()
      @movable = true
    end

    def lock()
      @movable = false
    end

    def frozen?()
      return @frozen
    end

    def confirm()
      @set = true
    end

    def can_move?()
      return @movable
    end

    def increment()
      @value += 1
    end
  end
end