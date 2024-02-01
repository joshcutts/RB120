class Person
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

end

p1 = Person.new("Jane")
p2 = Person.new("Becca")

p p1.get_name
p p2.get_name