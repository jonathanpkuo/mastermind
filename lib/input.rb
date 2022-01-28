module Mastermind
  class Input_Manager
    def initialize()
    end

    def menu_input()
      input = gets.chomp.to_i
      case input
      when 1
        return 0
      when 2 
        return 1
      when 3
        # puts "Mode incomplete, please select another option."
        # menu_input()
        return 2
      when 4
        return 3
      when 5
        exit
      else
        puts "Invalid entry"
        menu_input()
      end
    end

    def input_loop(array, mode = 0)
      if mode == 1
        puts "Secret Code Input"
      end
      if array.length == 4
        return array
      end
      if array.length < 4
        puts "Current selection is: #{array}."
      end
      puts "Please input choice."
      input = gets.chomp
      puts "Your input is: #{input}."
      downcased = proc { |x| x.downcase == "b" }
      scope = proc { |x| x.to_i < 0 || x.to_i > 9 }
      length = proc { |x| x.length < 1 }
      # duplicate proc is present and active only during code generation, as duplicate numbers are not permitted.
      duplicate = proc { |x| array.any?(x.to_i) && mode == 1 }

      case input
      when downcased
        backspace(array)
        input_loop(array, mode)
      when length
        puts "Invalid input."
        input_loop(array, mode)
      when scope
        puts "Input out of scope."
        input_loop(array, mode)
      when duplicate
        puts "Duplicates not permitted."
        input_loop(array, mode)
      else
        gattai(array, input.to_i)
        input_loop(array, mode)
      end
      
    end 
    
    # backspace function is designed to allow player(s) to go back in their moves if they entered the wrong key initially (does not allow for the 4th character to be undone).
    def backspace(array)
      if array.length > 0
        array.pop()
      else
        puts "Error, cannot delete"
      end
    end

    # gattai combines the current input into the active input buffer
    def gattai(array, int)
      if array.length < 4
        array.push(int)
      end
    end

  end
end