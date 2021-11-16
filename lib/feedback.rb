module Mastermind
  class Feedback
    attr_reader :feedback

    def initialize()
      @feedback = Array.new(10, "")
    end

    def c_num(array1, array2)
      return array1.intersection(array2).length 
    end

    def c_place(array1, array2)
      correct = 0
      array1.each_with_index do | element, index |
        correct += 1 if element == array2[index]
      end
      return correct
    end

    def bump_data(int, arr_1, arr_2)
      cor_num = c_num(arr_1, arr_2)
      cor_pla = c_place(arr_1, arr_2)
      if ( cor_pla == 4 )
        # 
        feedback[int] = "You have guessed the code! You win!"
        return true
      else
        # feedback[turn] = "There are #{c_num(code_array, input_array)} correct numbers and #{c_place(code_array, input_array)} correct placements."
        feedback[int] = "There are #{cor_num} correct numbers and #{cor_pla} correct placements."
      end
    end

  end

end