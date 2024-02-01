class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age = age + 1
  end
end

pollux = Cat.new("black")
tuxedo = Cat.new("tuxedo")
pollux.make_one_year_older
p pollux.age

=begin

`self.age` in this case is referencing the setter and getter
methods provided by `attr_accessor` - this means
that we could replace `self` with `@`

=end