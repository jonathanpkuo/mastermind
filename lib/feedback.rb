module Mastermind
  class Feedback
    attr_reader :feedback

    def initialize()
      @feedback = Array.new(10, "")
    end
  end

end