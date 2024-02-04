class Eukaryote
  attr_accessor :nucelus
  
  def initialize(dna)
    @nucleus = [dna]
  end
end

class Animal < Eukaryote
  def initialize
    @multicellular = true
  end

  def respiration
  end

  def grow
    "eat"
  end

end

class Plant < Eurkaryote
  def initialize
    @multicellular = true
  end

  def respiration
  end

  def grow
    "photosynthesis"
  end
end

class Protozoa
  def initialize
    @multicellular = false
  end
end