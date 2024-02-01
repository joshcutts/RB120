class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end

end

kitty = Cat.new("Sophie")
kitty.greet
kitty.name = "Luna"
kitty.greet

=begin

`attr_accessor` is Ruby shorthand to create getter and setter methods
Using `attr_accessor` is conveient with an instance variable like `@name`
because we want to both retireve the name and change it
As you saw in the previous exercise, `attr_reader` and `attr_writer` let
us do both of those things.
`attr_accessor` is just a simpler way of creating both of those methods.

=end