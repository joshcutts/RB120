class Cat
  attr_reader :name

  COLOR = "purple"

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is Sophie and I'm a #{COLOR} cat"
  end

end

kitty = Cat.new("Sophie")
kitty.greet