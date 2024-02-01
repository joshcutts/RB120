class Game
  def play
    "Start the game!"
  end
end


class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

=begin

We can have the `Bingo` class inherit from the `Game` class.

=end

bingo = Bingo.new
p bingo.play