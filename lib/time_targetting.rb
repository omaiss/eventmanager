require 'csv'
require 'date'
require 'time'
require 'erb'
puts 'Event Manager Initialized!'

csvData = CSV.open("event_attendees.csv", headers: true)
dateTime = []
csvData.each do |row|
  dateTime << row[1].gsub('/', '-')
end

puts dateTime

# Define the format of the date and time strings
date_time_format = "%m-%d-%y %H:%M"

dateTimeObjs = dateTime.map{|dt_str| DateTime.strptime(dt_str, date_time_format)}

# Calculate the sum of all timestamps (in seconds)
total_seconds = dateTimeObjs.map(&:to_time).map(&:to_i).sum

# Calculate the average timestamp in seconds
average_timestamp = total_seconds / dateTimeObjs.length

# Convert the average timestamp back to a DateTime object
average_date_time = DateTime.strptime(average_timestamp.to_s, '%s')

puts "Time of the day for the most registrations: #{average_date_time.strftime(" %H:%M")}"
