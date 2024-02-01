class Person
  def initialize
    @heros = ["Superman", "Spiderman", "Batman"]
    @cash = {"ones" => 12, "fives" => 2, "tens" => 0, "twenties" => 2, "hundreds" => 0}
  end

  def cash_on_hand
    total = @cash.values.sum
    "$#{format("%.2f",total)}"
  end

  def heros
    @heros.join(", ")
  end
end

joe = Person.new
p joe.cash_on_hand
p joe.heros