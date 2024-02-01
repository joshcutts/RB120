class Person
  # attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def name
    @name.clone
  end
end

person1 = Person.new("James")
person1.name.reverse!
puts person1.name

=begin

In the initial examples `@name` was modified through the incovation
of a destructive method. This is because getter methods typically
return a reference to the instance varaible.

If you use this reference to mutate the return value, you also mutate
the instance variable. To preent this, we can invoke the `#clone` method 
on `@name`, which returns a copy of `@name` instead of a reference to it.
This means that many modifications done to th return value won't affect
the value of `@name`. Note that we should also remove the `attr_reader` line 
since we are providing a customized getter method.
=end