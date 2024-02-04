=begin

nouns: hotel, pet, employee, dog, cat, fish
verbs: check in, check out, swim, run

=end

class Hotel
  def initialize(name)
    @name = name
    @pets = []
  end

  def check_in(pet)
    @pets << pet
  end

  def check_out(pet)
    @pets.delete(pet)
  end
end

class Pet
  def initialize(name)
    @name = name
  end
end

class Employee
  def initialize(name, position)
    @name = name
    @position = name
  end
end

module Walkable
  def walk
    puts "I can walk"
  end
end

module Swimmable
  def swim
    puts "I can swim"
  end
end

class Dog < Pet
  include Walkable
  include Swimmable
end

class Cat < Pet
  include Walkable
end

class Fish < Pet
  include Swimmable
end