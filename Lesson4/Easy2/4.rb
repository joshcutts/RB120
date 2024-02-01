class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  # def type
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

=begin

You could remove the `type` and `type=` instance methods
and replace with `attr_accessor :type`

It is standard practice to refer to instance variables inside
the class without `@` if the getter method is available.

=end