class GuessingGame
  attr_reader :guesses, :player_guess
  
  def initialize
    @num = rand(1..100)
    @guesses = 7
  end

  def aquire_player_input
    display_game_text
    input = ""
    loop do
      input = gets.chomp
      break if input.to_i.to_s == input && input.to_i.between?(1,100)
      puts "Invalid guess. Enter a valid number between 1 and 100"
    end
    @player_guess = input.to_i
  end

  def display_game_text
    puts "You have #{guesses} guesses remaining"
    puts "Enter a valid number between 1 and 100:"
  end

  def correct_guess?
    @player_guess == @num
  end

  def decrement_guess_count
    @guesses -= 1
  end

  def display_comparison
    if @player_guess < @num
      puts "Your guess is too low."
    elsif @player_guess > @num
      puts "Your guess is too high."
    elsif @player_guess == @num
      puts "That's the number!"
    end
    puts ""
  end

  def final_display
    if correct_guess?
      puts "You won!"
    elsif no_remaining_guess?
      puts "You have no more guesses. You lost!"
    end
  end

  def no_remaining_guess?
    @guesses == 0
  end

  def play
    loop do
      aquire_player_input
      decrement_guess_count
      display_comparison
      break if correct_guess? || no_remaining_guess?
    end
    final_display
  end

end

game = GuessingGame.new
game.play