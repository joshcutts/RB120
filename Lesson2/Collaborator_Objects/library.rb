class Library
  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end
end

class Book
  def initialize(title)
    @title = title
  end
end

my_library = Library.new
p my_library

book1 = Book.new("Dune")
my_library.add_book(book1)

p my_library
p my_library.instance_variables
p book1.instance_variables