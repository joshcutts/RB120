# You're creating a game called Mortal Kombat.

# Mortal Kombat is a game where two characters fight.

# Each fighter has a special move, but they all punch, kick and block. 

# They all start with 100 health. 

# Raiden is a god, and Kitana, Liu and Jax are humans.

# Raiden has a very large hat.
# Kitana has fans.
# Liu Kane has no shirt.
# Jax has metal arms.

# Raiden shoots lightning out of his hands which inflicts 15 damage.
# Kitana throws her fans which inflicts 25 damage.
# Liu Kane turns into a dragon which inflicts 72 damage.
# Jax pounds the ground which inflicts 63 damage.

# Raiden and Jax can set stuff on fire.

# Liu and Kitana can fly through the air.

#### Create a to_s method that outputs the following:

# *********
# FIGHT! FIGHT! #{name}
# ********* 

=begin
Nouns: Fighter, Raiden, Kitana, Liu Kane, Jax, Large hat, fans, metal arms, health, god, human.
Verbs: Individual special moves, fly, set stuff on fire.
      All fighters: Punch, kick, block

=end

require "pry"

class Fighter
  attr_accessor :health

  def initialize
    @health = 100
  end

  def punch
  end

  def kick
  end

  def block
  end

  def to_s
    puts "*********"
    puts "FIGHT! FIGHT! #{self.name}"
    puts "*********"
  end
end

module Fireable
  def set_fire
    puts "set stuff on fire"
  end
end

module Flyable
  def fly
    puts "fly, fly away"
  end
end

class Raiden < Fighter
  attr_reader :name

  include Fireable

  def initialize
    super
    @name = "Raiden"
    @appearance = "very large hat"
  end
  
  def special_move(other)
    shoot_lightning(other)
  end

  def shoot_lightning(other)
    other.health -= 15
  end

  def special_ability
    set_fire
  end
end

class Kitana < Fighter
  attr_reader :name
  
  include Flyable

  def initialize
    super
    @name = "Kitana"
    @appearance = "fans"
  end
  
  def special_move(other)
    throw_fans(other)
  end

  def thow_fans(other)
    other.health -= 25
  end

  def special_ability
    fly
  end
end

class LiuKane < Fighter
  attr_reader :name
  
  include Flyable

  def initialize
    super
    @name = "Liu Kane"
    @appearance = "shirtless"
  end

  def special_move(other)
    transform_dragon(other)
  end

  def transform_dragon(other)
    other.health -= 72
  end

  def special_ability
    fly
  end
end

class Jax < Fighter
  attr_reader :name
  
  include Fireable

  def initialize
    super
    @name = "Jax"
    @appearance = "metal arms"
  end

  def special_move(other)
    pound_ground(other)
  end

  def pound_ground(other)
    other.health -= 63
  end
end

class Game
  attr_reader :fighter1, :fighter2

  FIGHTERS = ["Raiden", "Kitana", "Liu Kane", "Jax"]
  ARENAS = ["Cage Mansion", "The Gateway", "Treasure Chamber"]

  def initialize
    @fighter1 = select_player
    @fighter2 = select_player
    @arena = select_arena
  end

  def welcome
    system "clear"
    puts "welcome animation"
  end

  def select_player
    puts "Select your fighter: #{FIGHTERS.join(', ')}"
    fighter_selection = ""
    loop do
      fighter_selection = gets.chomp
      break if FIGHTERS.include?(fighter_selection)
      puts "invalid fighter selection"
    end
    fighter_name = Object.const_get(fighter_selection)
    fighter_name.new
  end
  
  def fight
    #fight
  end 

  def select_arena
    puts "Select your arena: #{ARENAS.join(', ')}"
    arena_selection = ""
    loop do
      arena_selection = gets.chomp
      break if arena_selection.include?(arena_selection)
      puts "Invalid arena selection. Please try again"
    end
    arena_selection
  end

  def game_over
    system "clear"
    puts "game over animation"
  end

  def play
    fight
    game_over if fighter1.health <= 0 || fighter2.health <= 0
  end
end

mortal_kombat = Game.new()
mortal_kombat.play
binding.pry
