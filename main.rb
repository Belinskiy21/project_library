
require_relative 'models/library.rb'
require 'pry'
require 'yaml'
require_relative 'models/menu.rb'
require_relative 'models/seeds.rb'

include Seeds
include Menu

lib = Library.new
lib.input_seeds
lib.put.data unless File.exist? 'project_library.yml'
lib.menu
put = gets.chomp

while put != 5
  case put
  when '1'
    lib.get_data
    put = ''
  when '2'
    puts "Top reader: #{lib.top_reader}."
    put = ''
  when '3'
    puts "Top book: #{lib.top_book}"
    put = ''
  when '4'
    puts "How many people ordered one of the three most popular books:
     #{lib.mainstream_readers}"
    put = ''
  when '5'
    break
  else
    puts 'Follow Menu list! Put 1 to 5!'
    put = gets.chomp
  end
end
puts 'Goodbye!'
sleep 3
exit
