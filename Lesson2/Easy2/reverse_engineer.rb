class Transform
  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end

end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

=begin

This probelm is about distinguishing between instance and class methods.

The first line of the test code creates an object from the Transform class,
using a single string argument whose value is 'abc'. We then call
the instance method, `uppercase`, using the `my_data` object as the caller.
This returns the value we were passed during initialization in uppercase, 
which we then print.

Finally, we call the class method `lowercase`, passing it a value of 
`XYZ`. `lowercase` converts its arguement to lowercase and returns the result
which we then print.

=end