class Person
  attr_reader :name

  def name=(name)
    @name = name.capitalize
  end
end

person1 = Person.new
person1.name = "eLiZaBeTh"
puts person1.name

=begin

Normally we would use Ruby's built in accessor methods, but since we have to
add the extra functionality to the method, we're forced to implement our own.

To capitalize `@name` upon assignment, all we need to do is invoke `#capitalize` on `name`.
  Using this approach guarantees that each person's name will always be formatted correctly.

=end