class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

=begin

From within the class, when an instance method uses
`self`, it references the calling object, in this case a `Cat`
object.

`make_one_year_older` is an instance methyod and can only
be called on instances of the class `Cat`. Therefore, `self`
is referencing the instance (object) that called the method.
AKA the calling object.

=end