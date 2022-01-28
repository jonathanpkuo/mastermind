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
      # puts "Number of correct is #{num_cor}"
      # puts "Number frozen is #{count_guesses("frozen")}"
      if num_cor > count_guesses("frozen")
        # Freeze the first non-frozen entity.
        @guesses.each do |x| 
          if x.frozen? != true
            x.flip_freeze
            break
          end
        end
      end
      # Checks if number of correct placements is greater than number currently locked and not movable
      # There is an issue with this portion, causing it to unlock values that should remain locked.
      # New issue is that it is not locking when it should lock.
      if pla_cor > count_guesses("unmovable")
        # Lock the first non-movable entity. (Lowest value?)
        @guesses.each do |x|
          if x.can_move? == true
            # x.flip_lock
            x.move_lock
            break
          end
        end
      elsif pla_cor < count_guesses("unmovable")
        # Unlock the latest non-movable entity. (Highest value?)
        @guesses.reverse_each do |x|
          if x.can_move? == false
            # x.flip_lock
            x.move_unlock
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
      # Debug printout to check movable state post processing
      puts "movable state (post locks) #{movable_state}"
      # Shift one
      # @guesses = shift_one(@guesses)
      shift_values
      input = assemble_values
      return input
    end
    
    def assemble_values # Takes values from the guess objects and assembles them in an array for ease of use.
      temp = []
      for x in @guesses do
        temp.push(x.value?)
      end
      return temp
    end

        #TESTING CONTROLS
    def frozen_state # Takes frozen state from guess objects and assembles them in an array for easy reading.
      temp = []
      for x in @guesses do
        temp.push(x.frozen?)
      end
      return temp
    end

    def movable_state # Takes movable state from guess objects and assembles them in an array for easy reading.
      temp = []
      for x in @guesses do
        temp.push(x.can_move?)
      end
      return temp
    end

    def show_guesses()
      for x in @guesses do
        puts x
        puts "@frozen is: #{x.frozen?}"
        puts "@movable is: #{x.can_move?}"
        puts "Unmovable is: #{x.unmoving?}"
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
          if x.can_move? == true
            counter += 1
          end
        when "confirmed"
          if x.confirmed? == true
            counter += 1
          end
        when "unmovable"
          if x.can_move? == false
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
        # shift_one(@guesses)
        shift_values
      end

    end

    # Simple array shift to serve as basis for more complex version
    # Completed and working as of Tue 25 Jan 2022 15:00
    def simple_shift(array)
      i = 0
      while i < (array.length - 1) do
        array[i], array[i + 1] = array[i + 1], array[i]
        i += 1
      end
      return array
    end

    # New experimental shift function
    # Take existing @guesses array, starting from index of 0, checks to see next shiftable index and swaps places.
    def shift_values
      i = 0
      next_index = 0
      while i < 3 do
        # If the current index can be moved: Look for next movable and switch them.
        if @guesses[i].can_move? == true
          next_index = next_available(i) 
          @guesses[i], @guesses[next_index] = @guesses[next_index], @guesses[i]
          i += 1
        else
          i += 1
        end
      end
    end

    # Function to find the next available (movable) index
    def next_available(current_index)
      i = current_index
      while i < 3 do
        if @guesses[i+1].can_move? == true
          return (i+1)
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

    def move_lock
      @movable = false
    end

    def move_unlock
      @movable = true
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

    def unmoving?
      return !@movable
    end

    def value?
      return @value
    end

    def increment()
      @value += 1
    end
  end
end