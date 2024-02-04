class Laptop
  attr_accessor :memory

  def initialize(memory)
    @memory = memory
  end
end

macbook = Laptop.new("8GB")
p macbook