class Pet
  def run
    "running!"
  end

  def jump
    "jumping"
  end
end

class Dog < Pet
  def swim
    "swimming!"
  end

  def fetch
    "fetching!"
  end

  def speak
    "bark!"
  end
end

class Cat < Pet
  def speak
    "meow!"
  end
end

kal = Dog.new
puts kal.swim
puts kal.speak
pollux = Cat.new
puts pollux.speak
puts pollux.jump