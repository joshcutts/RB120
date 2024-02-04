class Person
  attr_reader :name

  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name

=begin
nil is output.
Getter method...
If we want to access the object's name, which is stored
  in the `@name` instance variable, we have to create a method
  that will return the name. We can call it `get_name` and
  its only job is to return the value in the @name instance 
  variable.
attr_reader provides a way to expose an object's state,
  in this case since 
Instance variables exist as long as the object instance exists.

  instance variables not initialized c/w local varialbe NameError

  shortcut/shorthand for getter method....

=end