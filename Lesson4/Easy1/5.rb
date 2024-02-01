class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end


=begin

The `Pizza` class would create object that have an
instance variable. We know this since only the `Pizza` class
has a variable that starts with "@".

=end

f = Fruit.new("apple")
p = Pizza.new("pep")

p f.instance_variables
p p.instance_variables

=begin

To determine if an object has instance variables one can look
at the class definition or invoke the `instance_variables` 
method on an instantiated object of that class.

We can see clearly that only the `Pizza` class has a variable
that begins with "@", which denotes an instance variable.

Additionally when we invoke `instance_variables` method on
objects instantiated from the `Pizza` class we can see
`@name` is listed as an instance variable


=end

p f