class Something
  def initialize
    @data = "Hello"
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    "ByeBye"
  end
end

thing = Something.new
puts Something.dupdata # "ByeBye"
puts thing.dupdata # HelloHello

=begin

Here we see two methods named `dupdata` in the `Something` class.
However, one is defined as `dupdata` and is thus an instance method.
The other id defined as `self.dupdata`, and is a class method. The two methods
are different and are compleetely independent of each other.

Our code first creates a `Soemthing` object, and then prints the result of
`Something.dupdata`, and then `thing.dupdata`. The former invocation calls
the class method (`self.dupdata`), and so prints "ByeBye". The latter
invocation calls the instance method, and so prints "HelloHello".

=end