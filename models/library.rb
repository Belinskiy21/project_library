require 'faker'
require 'yaml'
require 'pp'
require_relative 'author.rb'
require_relative 'book.rb'
require_relative 'order.rb'
require_relative 'reader.rb'
require_relative 'library.rb'
require_relative 'seeds.rb'

# project_library/models/library.rb
class Library
  attr_accessor :books, :orders, :readers, :authors
  def initialize(books = [], orders = [], readers = [], authors = [])
    @books = books
    @orders = orders
    @readers = readers
    @authors = authors
  end

  def put_data
    File.open('project_library.yml', 'w') { |f| f.write(self.to_yaml) }
    puts 'Datafile is ready!'
  end

  def get_data(file = 'project_library.yml')
    data = YAML.load_file(file)
    @books = data.books
    @orders = data.orders
    @readers = data.readers
    @authors = data.authors
    pp data
  end

  def top_reader
    top(1, :reader).name
  end

  def top_book
    top(1, :book).title
  end

  def mainstream_readers
    top(3, :book) do |books|
      @orders.flat_map { |order| order.reader if books.include?(order.book) }
             .compact.uniq.size
    end
  end

  private

  def top(number, method)
    result = @orders.group_by(&method)
                    .max_by(number) { |_, item| item.size }
                    .to_h.keys
    if !block_given?
      number == 1 ? result.first : result
    else
      yield result
    end
  end
end
