module Mastermind
  class Input_Manager
    def initialize()
      # buffer = []
    end

    # def input_function
    #   # init_buffer()

    #   input_loop(buffer)
    # end

    def input_loop(array)
      if array.length == 4
        return array
      end
      if array.length < 4
        puts "Current selection is: #{array}."
      end
      puts "Please input choice."
      input = gets.chomp
      # puts "#{input}, #{input.downcase}, #{input.to_i}"
      downcased = proc { |x| x.downcase == "b"}
      scope = proc { |x| x.to_i < 0 || x.to_i > 9 }
      length = proc { |x| x.length < 1 }

      case input
      when downcased
        backspace(array)
        input_loop(array)
      when length
        puts "Invalid input."
        input_loop(array)
      when scope
        puts "Input out of scope."
        input_loop(array)
      else
        gattai(array, input.to_i)
        input_loop(array)
      end
      
    end 

    # def init_buffer()
    #   buffer = Array.new()
    # end

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