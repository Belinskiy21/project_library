
require_relative 'models/Library.rb'
require 'pry'
require 'yaml'

lib = Library.new


if File.exist? ("project_library.yml")
	lib.menu
else
	lib.input_seeds
	File.open("project_library.yml", 'w') {|f| f.write(lib.to_yaml) }
	puts "Data is ready!"
	lib.menu
end


put = gets.chomp

while (put != 5)

		case put 
		when "1"
			lib.get_data
			put = ""
			lib.menu
		when "2"
			lib.top_reader
			put = ""
			lib.menu
		when "3"
			lib.top_book
		when "4"
			lib.mainstream_readers
		when "5"
		    break
		else 
			puts "Follow Menu list! Put 1 to 5!"
			put = gets.chomp
		end
	end
	puts "Goodbye!"
	sleep 3
	exit