module Dixon
  module ArrayHelpers
    def element_of_same_size
      self.all? { |a| a.size == self.first.size }
    end
  end
end

class Array
  include Dixon::ArrayHelpers
end