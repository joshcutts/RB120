class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end

end

kitty = Cat.new("Sophie")
p kitty.identify

=begin

In the last two exercise, we used `self` to define class methods and
to modify instance variable. `self` is used because it refers to the
calling object. This means that in our solution,
invoking `self` is the same as invoking `kitty`.

`#p` is used to print the object that that `#inspect` is called, 
which lets us view the instance variables and their values along
with the object.

=end