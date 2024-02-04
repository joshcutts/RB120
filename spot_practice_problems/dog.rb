class Dog
  def initialize(name)
    @name = name
  end

  def say_hello
    puts "Woof! My name is #{@name}."
  end
end

=begin

This code defines a `Dog` class with two methods.

1) The `#intialize` method that initializes a new `Dog` object,
which it does by assigning the instance variable `@name` to the
dog's name specified by the argument.

2) The `#say_hello` instance method which prints a message that
includes the dog's name in place of `#{@name}.` `#say_hello`
returns `nil`.

Concern ourselves with:
1) output
2) return value
3) object mutations


Here the string

=end