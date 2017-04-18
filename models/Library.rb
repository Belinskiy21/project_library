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

	def get_data(file = 'project_library.yml')
		data = YAML.load_file(file)
		pp data
	end

	def top_reader
		top 1, :reader
	end

	def top_book
		top 1, :book
	end

	def mainstream_readers
		top 3, :book do |books|
      @orders.map { |order| order.reader if books.include? order.book }
             .compact.uniq.size
    	end
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

	def top(num, target)
    res = @orders.group_by(&target)
                 .max_by(num) { |_, orders| orders.size }
                 .to_h.keys
    	if block_given? 
      	yield res
    	else
      	num == 1 ? res.first : res
    	end
  	end

end