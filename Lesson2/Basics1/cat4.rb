class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new("Sophie")

=begin

Instance variables are variables that exist only within an object instance.
They are avialable to reference only once the object has been
intialized.

They're differentiated by the `@` symbol prepended to their name.
We use an instance variable here to assign a unique name to the `kitty` object.

To accept arguemnts upon initialization, we need to add a paramater to 
`#intialize`. In our solution, we accept one arguemnt, `name` and assign it to
an instance variable named `@name`.

The instance variable is now available  to reference anywhere in the object.




=end