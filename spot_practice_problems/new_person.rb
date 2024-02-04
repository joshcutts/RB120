class Person
  def initialize(name)
    @name = name
  end

  def self.what_am_i
	"I'm a #{self} class"
  end
end

# josh = Person.new("josh")
puts Person.what_am_i