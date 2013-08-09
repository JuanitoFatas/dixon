module Dixon
  module Validators
    class Taiwan

      INVALID_MESSAGE = 'Invalid ID number.'

      LETTER_ISSUED_BY = {
        # Active Letters
        'A' => 'Taipei City'     , 'B' => 'Taichung City',
        'C' => 'Keelung City'    , 'D' => 'Tainan City',
        'E' => 'Kaohsiung City'  , 'F' => 'New Taipei City',
        'G' => 'Yilan County'    , 'H' => 'Taoyuan County',
        'I' => 'Chiayi City'     , 'J' => 'Hsinchu County',
        'K' => 'Miaoli County'   , 'M' => 'Nantou County',
        'N' => 'Changhua County' , 'O' => 'Hsinchu City',
        'P' => 'Yunlin County'   , 'Q' => 'Chiayi County',
        'T' => 'Pingtung County' , 'U' => 'Hualien County',
        'V' => 'Taitung County'  , 'W' => 'Kinmen County',
        'X' => 'Penghu County'   , 'Z' => 'Lienchiang County',
        # Letters no longer issued
        'L' => 'Taichung County' ,
        'R' => 'Tainan County'   ,
        'S' => 'Kaohsiung County',
        'Y' => 'Yangmingshan Management Bureau'
      }

      LETTER_NUMBERS = {
        'A' => '10', 'B' => '11', 'C' => '12', 'D' => '13', 'E' => '14',
        'F' => '15', 'G' => '16', 'H' => '17', 'J' => '18', 'K' => '19',
        'L' => '20', 'M' => '21', 'N' => '22', 'P' => '23', 'Q' => '24',
        'R' => '25', 'S' => '26', 'T' => '27', 'U' => '28', 'V' => '29',
        'X' => '30', 'Y' => '31', 'W' => '32', 'Z' => '33', 'I' => '34',
        'O' => '35'
      }

      RULE_NUMBERS = [1, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1]

      ## Check if a given ID is valid.
      # `id` must be a string, case is insensitive.
      # First convert ID into all numbers, then multiply to RULE_NUMBERS
      # element by element. Sum up and take a 10 modulo then check
      # if remainder is 0. If it's, return true, false otherwise.
      def checks(id)
        # "F127337575" => [1, 5, 1, 2, 7, 3, 3, 7, 5, 7, 5]
        converted = convert id.to_s
        #    [1,  5,  1,  2,  7,  3,  3,  7,  5,  7, 5]
        #  * [1,  9,  8,  7,  6,  5,  4,  3,  2,  1, 1]
        #  --------------------------------------------
        # sum 1, 45,  8, 14, 43, 15, 12, 21, 10,  7, 5
        # => 180
        # 180 mod 10, is the remainder equal to zero? If so, return true.
        #
        return (mapcar(-> (a,b) { a * b }, converted, RULE_NUMBERS).reduce(:+).divmod 10)[1] == 0
      end

      ## Returns gender for given ID.
      # By check the second digit of ID.
      # 1 is male, 2 is female.
      def gender(id)
        case id[1]
          when '1' then 'male'
          when '2' then 'female'
          else puts INVALID_MESSAGE
        end
      end

      ## Returns local agencies who issued your id.
      def issued_by(id)
        LETTER_ISSUED_BY[id[0]]
      end

      private

      ## Convert array of strings into integer array.
      def to_i_array(str_arr)
        str_arr.map(&:to_i)
      end

      ## Convert an identification number to array of strings
      # First letter conversion rules is defined in LETTER_NUMBERS
      # `convert 'F127337575'` will result in
      # [1, 5, 1, 2, 7, 3, 3, 7, 5, 7, 5]
      def convert(id)
        to_i_array((LETTER_NUMBERS[id[0]] + id[1..-1]).split(''))
      end

      ## mapcar operates on successive elements of the arrays.
      # fn is applied to the first element of each array, then to the second element of each array, and so on. The iteration terminates when the shortest array runs out, and excess elements in other arrays are ignored. The value returned by mapcar is a array of the results of successive calls to function
      def mapcar(fn, *arrs)
        return [] if arrs.empty? or arrs.include? []
        transposed = if arrs.element_of_same_size
                       arrs.transpose
                     else
                       arrs[0].zip(*arrs.drop(1))
                     end
        transposed.map do |e|
          e.reduce(&fn) unless e.include? nil
        end
      end
    end
  end
end

module ValidateFormat

  TAIWAN_ID_REGEXP = /[a-zA-Z][1|2][0-9]+/i

  ## Check if given id's format is valid.
  # The current ID number has exact 10 digits
  # The first digit is one capital English letter and
  # is followed by nine Arabic numerals.
  def valid_format?(id)
    return true if id =~ TAIWAN_ID_REGEXP and id.size == 10
    puts 'Invalid ID number.'
    false
  end

  %i(checks gender issued_by convert).each do |m|
    define_method(m) { |id| super(id) if valid_format? id }
  end

  private :convert

end

module Dixon
  module Validators
    class Taiwan
      prepend ValidateFormat
    end
  end
end

