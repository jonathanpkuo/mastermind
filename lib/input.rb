module Mastermind
  class Input_Manager
    def initialize()
    end

    def menu_input()

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
      downcased = proc { |x| x.downcase == "b"}
      scope = proc { |x| x.to_i < 0 || x.to_i > 9 }
      length = proc { |x| x.length < 1 }
      duplicate = proc { |x| array.any?(x.to_i) && mode == 1}
      # duplicate = proc { |x| array.any?(x) }

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
    
    def backspace(array)
      if array.length > 0
        array.pop()
      else
        puts "Error, cannot delete"
      end
    end

    def gattai(array, int)
      if array.length < 4
        array.push(int)
      end
    end

  end
end