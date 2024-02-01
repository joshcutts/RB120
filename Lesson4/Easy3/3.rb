class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

pollux = AngryCat.new("4", "pollux")
tudexo = AngryCat.new("4", "tux")
p pollux
p tudexo

=begin

When we create the `AngryCat` objects, we pass the 
constructor two values - an age and a name. These values
are assigned to the new object's instance varaibles,
and each object ends up with different information.

By default, Ruby will call the `initialize` method on object creation.

=end