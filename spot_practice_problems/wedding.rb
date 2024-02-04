class Wedding
  attr_reader :guests, :flowers, :songs

  def initialize
    @guests = ["Billy", "Jessica"]
    @flowers = ['roses', 'sunflowers']
    @songs = ['Book of Love', 'Bloodbuzz Ohio']
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    puts "Preparing food for #{guests[0]} and #{guests[1]}."
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    puts "Placing the #{flowers[0]} and #{flowers[1]} on the table."
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    puts "#{songs[0]} and #{songs[1]} coming up next!"
  end
end

joe = Chef.new
bob = Decorator.new
linda = Musician.new
staff = [joe, bob, linda]
brad_angelina = Wedding.new
brad_angelina.prepare(staff)