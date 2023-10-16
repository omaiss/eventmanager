# Assignment
# This code is written by M. Omais Afzal (omaisafzal225@gmail.com)
# This code removes the bad phone numbers from the event_attendees.csv data and saves
# the data in another folder named corrected_phone_numbers
#
require 'csv'
require 'erb'

puts 'Event Manager Initialized!'

def correct_phone_nums(phone_nums)

  # more understandable code
  new_phones = phone_nums.map do |nums|
    if nums.length < 10 or nums.length > 11
      "Bad Number"
    elsif nums.length == 11 && nums[0] == '1'
      nums[1..-1]
    else
      nums
    end
  end

  # one line implementation
  # new_phones = phone_nums.map { |nums| (nums.length < 10 || nums.length > 11) ? "Bad Number" : (nums.length == 11 && nums[0] == '1') ? nums[1..-1] : nums }

  return new_phones
end

def remove_special_characters(input_string)
  # Use a regular expression to match and remove special characters
  # permit only numbers with no spaces in between
  input_string.gsub(/[^0-9]/, '')
end

readCSV = CSV.open("event_attendees.csv", headers: true)
columns = []
puts 'Wrong Phone Numbers:'
readCSV.each do |row|
  columns << remove_special_characters(row[5].to_s)
end

puts columns

puts "\nCorrected Phone Numbers"
new_phone_nums = correct_phone_nums(columns)

puts new_phone_nums
