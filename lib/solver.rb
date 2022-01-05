module Mastermind
  class Solver
    def initialize()
      @shift = false
      @guesses = populate_guesses(Array.new())
    end

    def solution_algo(turn, feedback)
      if turn == 0
        input = assemble_values
        return input
      end
      # Take feedback[turn] 
      temp = feedback.gsub(/[^\s\d]/, "").split
      num_cor = temp[0].to_i
      pla_cor = temp[1].to_i
      # Check if number of correct is greater than the number currently "frozen (non-incrementing)"
      puts num_cor
      puts count_guesses("frozen")
      if num_cor > count_guesses("frozen")
        # Freeze the first non-frozen entity.
        @guesses.each do |x| 
          if x.frozen? != true
            x.flip_freeze
            break
          end
        end
      end
      if pla_cor > count_guesses("confirmed")
        # Lock the first non-confirmed entity. (Lowest value?)
        @guesses.each do |x|
          if x.confirmed? != true
            x.flip_lock
            break
          end
        end
      elsif pla_cor < count_guesses("confirmed")
        # Unlock the latest non-confirmed entity. (Highest value?)
        @guesses.reverse_each do |x|
          if x.confirmed? == true
            x.flip_lock
            break
          end
        end
      end
      # Increment values
      @guesses.each do |x|
        if x.frozen? != true
          x.increment
        end
      end
      # Shift one
      @guesses = shift_one(@guesses)
      input = assemble_values
      return input
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
    
    def count_guesses(qualifier)
      counter = 0
      @guesses.each do |x|
        case qualifier
        when "frozen"
          if x.frozen? == true
            counter += 1
          end
        when "movable"
          if x.movable? == true
            counter += 1
          end
        when "confirmed"
          if x.confirmed? == true
            counter += 1
          end
        end
      end
      return counter
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
      @value = 0
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

    def confirmed?
      return @set
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