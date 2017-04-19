require 'faker'
require 'yaml'
require 'pp'
require_relative 'Author.rb'
require_relative 'Book.rb'
require_relative 'Order.rb'
require_relative 'Reader.rb'
require_relative 'Library.rb'

class Library
	attr_accessor :books, :orders, :readers, :authors
	
	def initialize(books = [], orders = [], readers = [], authors = [])
	@books = books
	@orders = orders 
	@readers = readers 
	@authors = authors 
	end

	def input_seeds
		@authors = []
		10.times { @authors << Author.new(Faker::Book.author, Faker::Lorem.paragraphs)}

		@books = []
		20.times { @books << Book.new(Faker::Book.title, @authors.sample)}

		@readers = []
		50.times { @readers << Reader.new(Faker::Name.name,
											Faker::Internet.email,
											Faker::Address.city,
											Faker::Address.street_name,
											Faker::Address.building_number)}
		@orders = []
		100.times { @orders << Order.new(@books.sample, @readers.sample, Faker::Date.backward(100))}
	end

	def put_data
	File.open("project_library.yml", 'w') {|f| f.write(self.to_yaml) }
	puts "Datafile is ready!"
	end

	def get_data(file = 'project_library.yml')
		data = YAML.load_file(file)
		pp data
	end

	def top_reader
		@readers.map { |reader| reader.name if top.include? (reader.email)}.compact.uniq[0]
	end

	def top_book
		@books.map { |book| book.title if top("book").include? (book.title)}.compact.first
	end

	def mainstream_readers
    	@orders.map { |order| order.reader.name if top("book", 3).include? (order.book.title) }.compact.uniq.size
	end


	def menu
		puts "Welcome in Library Menu:\n 
	put 1 -  for get data \n 
	put 2 - for top reader \n 
	put 3 - for most popular book \n
	put 4 - How many people ordered one of the three most popular books? \n
	put 5 -for Exit \n"
	end

	private 

	
  	def top(target="reader", n=1)
  	h=Hash.new(0)
  	@orders.map do |el| 
  	  target=="reader" ? h[el.reader.email]+=1 : h[el.book.title]+=1 
  	end
    h.sort_by { |k,v| -v }.first(n).flatten
  end

end