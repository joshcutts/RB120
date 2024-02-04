class Fruit
  def initialize(name)
    @name = name
  end

  def compare(other)
    puts "I am #{type} and you are #{other.type}"
  end

  protected
  def type
    name
  end

  private
  attr_reader :name
end

class Apple < Fruit
  def type
    "hidden"
  end  
end
class Orange < Fruit; end
class Pear < Fruit; end

apple = Apple.new("Macintosh")
orange = Orange.new("Navel")
pear = Pear.new("Bradford")

apple.compare(orange)
orange.compare(pear)
pear.compare(apple)
