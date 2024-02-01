=begin

To be able to `go_fast` we need to mix in the module `Speed` to the
`Car` and `Truck` classes. Once the `Speed` module is included
we can invoke the instance method on a `Car` or `Truck` object 
that we have instantiated
to check if either `Car` or `Truck` objects can now go fast.


=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

car = Car.new
truck = Truck.new
car.go_fast
truck.go_fast