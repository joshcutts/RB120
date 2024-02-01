module Walkable
  def walk
    puts "Let's go for a walk"
  end
end

class Cat
  include Walkable

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
kitty.walk

=begin

Modules are typically used to contain methods that may be useful for mutliple classes,
but not all classes. When you mix a module into a class, you're allowing the calss
to invoke the contained methods.

In our solutio we create a module named `Walkable` that contains a method named `#walk`.
We give `Cat` access to this method by including `Walkable` in the class.

This lets us invoke `#walk` on any instance of `Cat`. In this case if we invoke
`kitty.walk` then `Let's go for a walk!` will be printed

=end