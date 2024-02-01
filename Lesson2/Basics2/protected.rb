class Person
  attr_writer :secret

  def compare_secret(other)
    secret == other.secret
  end

  protected

  attr_reader :secret

end

person1 = Person.new
person1.secret = "Shh.. this is a secret!"

person2 = Person.new
person2.secret = "Shh..this is a ddifferent secret!"

puts person1.compare_secret(person2)

=begin

We pass person2 as an argument into `#compare_secret`.
We then compare the value of `@secret` from `person1` with the 
value of `@secret` from `person2`. We do this using the `==` operator
which returns a boolean.

=end