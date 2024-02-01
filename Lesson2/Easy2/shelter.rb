class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end
end

class Shelter
  attr_accessor :record

  def initialize
    @record = {}
  end

  def adopt(owner, pet)
    if @record.keys.include?(owner.name)
      @record[owner.name] << pet
    else
      @record[owner.name] = [pet]
    end
  end

  def print_adoptions
    @record.each do |owner, pets|
      puts "#{owner} has adopted the following pets"
      pets.each do |pet|
        puts "a #{pet.species} named #{pet.name}"
      end
      puts
    end
  end

end

class Owner
  attr_reader :name

  def initialize(name)
    parts = name.split
    @name = parts.map(&:capitalize).join(" ")
  end

  def number_of_pets(shelter)
    shelter.record[@name].length
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets(shelter)} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets(shelter)} adopted pets."