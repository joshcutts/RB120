class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new("Butterscotch", 10, 'tan and white')
puts pudding, butterscotch

=begin

Since `Cat#new` requires different arguements than `Pets#new` we need to define
a new `initialize` method for `Cat` and that method
must be sure to call `super` as well. Additionally the fact that the two
`initialize` emthods take different arguemnets, also forces us to supply
the correct arguments to super.

Futhermore, `Cat` objects must respond appropriately to `puts`. The way to do 
  this is to override `to_s` to provide the appropriate value, which we do.

=end