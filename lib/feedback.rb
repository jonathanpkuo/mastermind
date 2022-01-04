module Mastermind
  class Feedback
    attr_reader :feedback

    def initialize()
      @feedback = Array.new(10, "")
    end

    def c_num(code, input)
      return code.intersection(input).length 
    end

    def c_place(code, input)
      correct = 0
      code.each_with_index do | element, index |
        correct += 1 if element == input[index]
      end
      return correct
    end

    def bump_data(turn, code, input)
      cor_num = c_num(code, input)
      cor_pla = c_place(code, input)
      if ( cor_pla == 4 )
        # 
        feedback[turn] = "You have guessed the code! You win!"
        return true
      else
        # feedback[turn] = "There are #{c_num(code_array, input_array)} correct numbers and #{c_place(code_array, input_array)} correct placements."
        feedback[turn] = "There are #{cor_num} correct numbers and #{cor_pla} correct placements."
        return false
      end
    end

  end

end