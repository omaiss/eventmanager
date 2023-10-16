puts 'Event Manager Initialized!'
require 'google/apis/civicinfo_v2'
require 'csv'
require 'erb'

# Look for a solution before making a solution

# Reading the whole file in one go
# if File.exist? "event_attendees.csv"
#   contents = File.read('event_attendees.csv')
#   puts contents
# else
#   puts "File Error\n"
# end

#Read the file line by line
# if File.exist? "event_attendees.csv"
#   lines = File.readlines('event_attendees.csv')
#   lines.each_with_index do |line,index|
#     next if index == 0
#     columns = line.split(",")
#     name = columns[2]
#     puts name
#   end
# end

# Using CSV to do the same thing i.e reading the file line by line
# Header value is to tell the class if the file has header or not
# contents = CSV.open('event_attendees.csv', headers: true)
# contents.each do |row|
#   name = row[2]
#   puts name
# end


# Further functionality of the CSV library
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   full_name = row[:first_name] + ' ' + row[:last_name]
#   puts full_name
# end

# Using the csv functions to complete the missing zip codes in the csv file
# if zip code is of length:5 do nothing
# if zip code is of >length:5 then choose only first five digits
# if zip code is of <length:5 then append zeros to the current zip code
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name] + ' ' + row[:last_name]
#   zipcode = row[:zipcode]

#   if zipcode.nil?
#     zipcode = '00000'
#   elsif zipcode.length < 5
#     zipcode = zipcode.rjust(5, '0')
#   elsif zipcode.length > 5
#     zipcode = zipcode[0..4]
#   end

#   puts "#{name} #{zipcode}"
# end

# Cleaning the zip code correction algorithm
# Make a function named clean zip codes that must be very concise and clear
# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, '0')[0..4]
# end

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]

#   zipcode = clean_zipcode(row[:zipcode])

#   puts "#{name} #{zipcode}"
# end

# Exploring data using ruby on Google CIVIC using google gem api
# require 'google/apis/civicinfo_v2'
# #=> true

# civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
# #=> #<Google::Apis::CivicinfoV2::CivicInfoService:0x007faf2dd47108 ... >

# civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
# #=> "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

# response = civic_info.representative_info_by_address(address: 80202, levels: 'country', roles: ['legislatorUpperBody', 'legislatorLowerBody'])
# #=> #<Google::Apis::CivicinfoV2::RepresentativeInfoResponse:0x007faf2d9088d0 @divisions={"ocd-division/country:us/state:co"=>#<Google::Apis::CivicinfoV2::GeographicDivision:0x007faf2e55ea80 @name="Colorado", @office_indices=[0]> } > ...continues...
# puts response

# The above code gives a lot of clustered information
# Write a new concise code that show the info in a good way

# civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
# civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, '0')[0..4]
# end

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]

#   zipcode = clean_zipcode(row[:zipcode])

#   legislators = civic_info.representative_info_by_address(
#     address: zipcode,
#     levels: 'country',
#     roles: ['legislatorUpperBody', 'legislatorLowerBody']
#   )
#   legislators = legislators.officials

#   puts "#{name} #{zipcode} #{legislators}"
# end

# Using begin and rescue to correct the above codes error
#

# require 'csv'
# require 'google/apis/civicinfo_v2'

# civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
# civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

# contents.each do |row|
#   name = row[:first_name]

#   zipcode = clean_zipcode(row[:zipcode])

#   begin
#     legislators = civic_info.representative_info_by_address(
#       address: zipcode,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     )
#     legislators = legislators.officials

#     legislator_names = legislators.map(&:name)

#     legislators_string = legislator_names.join(", ")
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end

#   puts "#{name} #{zipcode} [#{legislators_string}]"
# end


# def legislators_by_zipcode(zip)
#   civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#   civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

#   begin
#     legislators = civic_info.representative_info_by_address(
#       address: zip,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     )
#     legislators = legislators.officials
#     legislator_names = legislators.map(&:name)
#     legislator_names.join(", ")
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end
# end

# # Form Letters:
# template_letter = File.read('formletter.html')

# contents.each do |row|
#   name = row[:first_name]

#   zipcode = clean_zipcode(row[:zipcode])

#   legislators = legislators_by_zipcode(zipcode)

#   personal_letter = template_letter.gsub('FIRST_NAME', name)
#   personal_letter.gsub!('LEGISLATORS', legislators)

#   puts personal_letter
# end

# ERB
#
# meaning_of_life = 42

# question = "The Answer to the Ultimate Question of Life, the Universe, and Everything is <%= meaning_of_life %>"
# template = ERB.new question

# results = template.result(binding)
# puts results

# Final code
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def write_to_files(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('formletter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  write_to_files(id, form_letter)
end
