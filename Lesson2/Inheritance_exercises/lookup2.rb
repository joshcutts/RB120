class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

=begin


Cat
Animal
Object
Kernel
BasicObject


Nearly every class in Ruby inherits from another class. This is true
until the class named `BasicObject`, which doesn't inherit from a class.
  Some classes also include modules, much like how the `Object` class
includes the `Kernel` module.

Here, Ruby searches for the `#color` method in every class and module
in the search path. Since the method isn't anywhere,
the answer includes every class and module in the search path.

=end

