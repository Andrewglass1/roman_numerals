class RomanNumeralEvaluator

  VALUES = {"I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000}


  def evaluate_full_string(string)
    value = 0
    until string.empty?
	    wordlet, string = pop_off_wordlet(string)
	    value += wordlet_value(wordlet)
    end
    value
  end

private

  def pop_off_wordlet(string)
	  wordlet = string[0]
	  string[0] = ''
	  until string.empty? || (letter_value(wordlet[-1]) >= letter_value(string[0]))
		  wordlet += string[0]
		  string[0] = ''
	  end
	  [wordlet, string]
  end

  def wordlet_value(wordlet)
	  return letter_value(wordlet) if wordlet.length == 1

	  positives = []
	  negatives = []

	  wordlet_in_values = wordlet.split("").collect{|l|letter_value(l)}

	  wordlet_in_values.each_with_index do |value, index|
		  if wordlet_in_values[index+1].nil?
			  positives << value
		  elsif value < wordlet_in_values[index+1]
			  negatives << value
		  else
			  positives << value
		  end
	  end
    sum_array(positives) - sum_array(negatives)
  end

  def letter_value(letter)
    VALUES[letter]
  end

  def sum_array(array)
    array.inject(0){|r,v|r+v}
  end
end