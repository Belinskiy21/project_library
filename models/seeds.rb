module Seeds
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
end
