class Animal
  attr_writer :name

  def initialize(name)
    self.name = name
  end

  def combine_name
    x == y ? @name_a : @name_b
    name
  end
end

class Dog < Animal
  def display_name
    puts "#{name}   "
  end

end

pepper = Animal.new('pepepr')
p pepper