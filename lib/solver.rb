module Mastermind
  class Solver
    def initialize()
      @shift = false
      @guesses = populate_guesses(Array.new())
    end

    def solution_algo(turn, feedback)
      # Take feedback[turn] 
      temp = feedback.gsub(/[^\s\d]/, "").split
      num_cor = temp[0].to_i
      pla_cor = temp[1].to_i
      

    end
    
    #TESTING CONTROLS
    def assemble_values # Takes values from the guess objects and assembles them in an array for ease of use.
      temp = []
      for x in @guesses do
        temp.push(x.value?)
      end
      return temp
    end

    def show_guesses()
      for x in @guesses do
        puts x
        puts "@frozen is: #{x.frozen?}"
        puts "@movable is: #{x.can_move?}"
        puts "@value is: #{x.value?}"
      end
    end

    def manipulate_guess(index, action)
      case action
      when "freeze"
        @guesses[index].flip_freeze
      when "lock"
        @guesses[index].flip_lock
      when "increment"
        @guesses[index].increment
      when "shift"
        shift_one(@guesses)
      end

    end

    def shift_one(array)
      holding_cells = Array.new(4)
      i = 0
      #temporarily removes any frozen values
      while array.any? { |x| x.can_move? == false } do
        array.each do |x|
          if x.can_move? == false 
            puts x
          end
        end
        if array[array.length - (1 + i)].can_move? == false
          holding_cells[array.length - (1 + i)] = array.delete_at(array.length - (1 + i))
        end
        i += 1
      end
      # Conducts the shift with the remaining values.
      array[(array.length - 1)] = array.shift()
      # moves values from temporary array back to main array.
      j = 0
      while holding_cells.any? { |x| x != nil} do
        if holding_cells[j] != nil
          array.insert(j, holding_cells[j])
        end
        j += 1
      end
      return array

    end

    #Do we need this?
    def find_confirmed(array)
      temp = Array.new()
      array.each_with_index do | x, index |
        temp[index] = x.can_move?()
      end
      return temp
    end

    # Fills array with guess objecets (Guesstimates)
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

    def value?
      return @value
    end

    def increment()
      @value += 1
    end
  end
end