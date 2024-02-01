class Cat
  @@count = 0

  attr_accessor :name

  def initialize(name)
    @name = name
    @@count += 1
  end

  def self.total
    puts @@count
  end
end

tux = Cat.new("Tuxedo Mask")
pollux = Cat.new("Pollux")
Cat.total

=begin



=end