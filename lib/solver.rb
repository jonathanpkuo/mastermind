module Mastermind
  class Solver
    def initialize()
      @shift = false
      @guesses = populate_guesses(Array.new())
    end

    def solution_algo(array_board, turn, num_cor, num_pla)

      

    end

    def shift_one(array)
      no_shift = find_confirmed(array)  # Is this portion unneccessary?
      holding_cells = []
      i = 0
      while array.any? { |x| x.can_move? == false } do
        if array[array.length - (1 + i)].can_move? == false
          holding_cells.push(array.delete_at(array.length - (1 + i)))
        end
        i += 1
      end

    end

    #Do we need this?
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

    def flip_freeze
      if @frozen == true
        @frozen = false
      else
        @frozen = true
      end
    end

    def flip_lock
      if @movable == true
        @movable = false
      else 
        @movable = true
      end
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