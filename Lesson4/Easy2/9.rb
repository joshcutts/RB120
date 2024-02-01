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

if a `play` method were added to the `Bingo` class,
if `play` were invoked object instantiated from the
`Bingo` class, the method defined in the `Bingo` class
would be used since it is higher in the method lookup order.

=end