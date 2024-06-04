# frozen_string_literal: true

class StringCalculator
  def self.add(numbers)
    # returns 0 for an empty string
    return 0 if numbers.empty?

    delimiters, numbers_string = extract_delimiters(numbers)
    numbers_array = parse_numbers(numbers_string, delimiters)
    validate_numbers(numbers_array)
    add_sum(numbers_array)
  end

  def self.extract_delimiters(numbers)
    if numbers.start_with?('//')
      # supports different delimiters
      delimiter_section, numbers_section = numbers.split("\n", 2)
      delimiters = delimiter_section.gsub('//', '').split(/[\[\]]+/).reject(&:empty?)
      numbers_section ||= ''
    else
      # allows new lines between numbers
      delimiters = [',', "\n"]
      numbers_section = numbers
    end
    [delimiters, numbers_section]
  end

  def self.parse_numbers(numbers_string, delimiters)
    delimiters_regex = Regexp.union(delimiters)
    numbers_string.split(delimiters_regex).map(&:to_i)
  end

  def self.validate_numbers(numbers_array)
    negatives = numbers_array.select(&:negative?)

    # throws an exception for negative numbers
    raise ArgumentError, "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end

  # returns the number for array of numbers
  def self.add_sum(numbers_array)
    numbers_array.sum
  end
end
