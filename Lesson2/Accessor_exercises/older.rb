class Person
  attr_writer :age
  def older_than?(other)
    age > other.age
  end
  protected
  attr_reader :age
end


person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)

=begin

The getter method is protected, which means we can only
access it from an instance of the same class.

We therefore have to invoke `older_than?` on an existing instance and pass in 
another instance as an argument. 

=end