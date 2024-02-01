require "pry"
class Participant
  attr_accessor :hand

  def initialize
    @hand = clear_hand
  end

  def hit(deck, dealer)
    @hand << dealer.deal(deck)
  end

  def total
    hand.map(&:value).sum
  end

  def busted?
    total > 21
  end

  def clear_hand
    @hand = []
  end
end

class Player < Participant
  def total
    values = hand.map(&:value)
    total = values.sum
    ranks = hand.map(&:rank)
    aces = ranks.count("A")

    while total > 21 && aces > 0
      total -= 10
      aces -= 1
    end
    total
  end

  def busted?
    total > 21
  end
end

class Dealer < Participant
  attr_reader :deck

  def deal(deck)
    card = deck.cards.sample
    deck.cards.delete(card)
  end
end

class Deck
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(Hearts Diamonds Clubs Spades)

  attr_accessor :cards

  def initialize
    @cards = create_cards
  end

  def create_cards
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck
  end
end

class Card
  attr_accessor :rank, :suit, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = assign_value(rank)
  end

  def assign_value(rank)
    case rank
    when "A" then 11
    when /[KQJ]/ then 10
    else rank.to_i
    end
  end

  def to_s
    "#{rank} #{suit}"
  end
end

class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = reset
    @name = aquire_name
  end

  def deal_cards
    2.times { player.hand << dealer.deal(deck) }
    2.times { dealer.hand << dealer.deal(deck) }
  end

  def clear
    system "clear"
  end

  def aquire_name
    aquire_name_display_welcome
    name = ""
    attempts = 0
    loop do
      name = gets.chomp
      break if valid_input?(name)
      name = handle_invalid_input(name, attempts)
      break if name
      attempts += 1
    end
    name
  end

  def aquire_name_display_welcome
    clear
    puts "Welcome to Twenty-One!!"
    sleep(0.5)
    puts "First things first, what's your name?"
  end

  def handle_invalid_input(name, attempts)
    if attempts > 2
      puts %(Lets just call you "difficult" shall we?)
      sleep(2)
      "Difficult"
    elsif name.empty?
      puts "You can't have a blank name! Please try again."
    elsif !valid_input?(name)
      puts "You can't trick me with spaces! Please enter a valid name."
    end
  end

  def valid_input?(name)
    !name.gsub(" ", "").empty?
  end

  def display_welcome_message
    clear
    puts "Welcome to Twenty-One #{@name}!"
    puts 'You will play against the dealer.'
    puts 'Your objective is to reach 21 points without going over.'
    sleep(3.5)
  end

  def display_player_cards
    puts "PLAYER CARDS - VALUE #{player.total}"
    puts "-----------------------"
    player.hand.each { |card| puts card }
    puts ""
  end

  def display_dealer_one_card_hidden
    puts "DEALER CARDS - VALUE ???"
    puts "-----------------------"
    puts "????????????"
    puts dealer.hand[0]
    puts ""
  end

  def display_dealer_cards
    puts "DEALER CARDS - VALUE #{dealer.total}"
    puts "-----------------------"
    dealer.hand.each { |card| puts card }
    puts ''
  end

  def display_initial_cards
    clear
    display_player_cards
    display_dealer_one_card_hidden
  end

  def display_cards
    clear
    display_player_cards
    display_dealer_cards
  end

  def aquire_input(valid_input)
    input = ''
    loop do
      input = gets.chomp
      break if valid_input.include?(input)
      puts "Please enter either #{valid_input.join(' ')}"
    end
    input
  end

  def player_turn
    loop do
      puts "Do you want to hit or stay? (hit/stay)"
      input = aquire_input(["hit", "stay"])
      break if input == "stay"
      player.hit(deck, dealer)
      display_cards
      break if player.busted?
    end
  end

  def dealer_turn
    while !player.busted? && dealer.total < 17
      dealer.hit(deck, dealer)
      display_cards
      sleep(2)
    end
  end

  def determine_winner
    if player.busted?
      "dealer"
    elsif dealer.busted?
      "player"
    elsif player.total == dealer.total
      "tie"
    else
      player.total > dealer.total ? "player" : "dealer"
    end
  end

  def show_result
    case determine_winner
    when "player"
      puts "Dealer busted!" if dealer.busted?
      puts "You won!"
    when "dealer"
      puts "You busted!" if player.busted?
      puts "The dealer won!"
    when "tie"
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "#{@name}, would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts 'Sorry, please input either y or n.'
    end
    answer == 'y'
  end

  def reset
    clear
    player.clear_hand
    dealer.clear_hand
    Deck.new
  end

  def display_play_again_message
    puts "Let's play again!"
    sleep(2)
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One! Goodbye!"
  end

  def main_game
    deal_cards
    display_initial_cards
    player_turn
    display_cards
    sleep(2)
    dealer_turn
    show_result
  end

  def play
    display_welcome_message
    loop do
      main_game
      break unless play_again?
      reset
      display_play_again_message
    end
  end
end

game = Game.new
game.play
