class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

=begin

When looking at the initial example, the first thing you should notice
is the invocation of `::generic_greeting` is a class method.

Class methods are defined differently than instance methods.
When defining a class emthod, the method name is prepended with
`self`, like this: `self.generic_greeting`. In the solution, `self`
refers to the `Cat` class. This means we could also define
`::generic_greeting` as `Cat.generic_greeting`. However, `self` is
preferring when defining class methods (in case you ever change the class name)

Like instance methods, we can place any statement we want inside a class method.
In our solution, we place `puts 'Hello! I'm a cat!'`, so that
`Hello! I'm a cat!` is printed when `::generic_greeting` is invoked.

To invoke class methods, they must be called on the class itself, not an
instance of the class. If we invoke a class method on an instance of the class
we'll get a `NoMethodError`

=end

kitty = Cat.new
p kitty.class.generic_greeting
