class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student; end

a = Graduate.new("a", 1, :yes)
b = Undergraduate.new("b", 1)

p a
p b