# project_library/models/book.rb
class Book
  attr_accessor :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end
end
