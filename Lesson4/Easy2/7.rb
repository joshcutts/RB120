class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

=begin

The `@@cats_count` variable is a class variable which keeps
track of the number of `Cat` objects that are instantiated. AKA
the number of cat instances which have been created.

Whenever a `Cat` object is instantiated, the `@@cats_count` 
integer is incremented by 1 in the `initialize` method.

If 2 `Cat` objects were instantiated and the `self.cats_count`
method were invoked on the `Cat` class, it would return
the value of `@@cats_count`, which would be the integer 2.

=end

cat1 = Cat.new("black")
cat2 = Cat.new("tuxedo")
p Cat.cats_count