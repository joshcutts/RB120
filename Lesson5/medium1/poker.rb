# Include Card and Deck classes from the last two exercises.

require "pry"

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :cards

  def initialize
    @cards = create_and_shuffle_deck
  end

  def create_and_shuffle_deck
    deck = create_deck
    shuffled_deck = shuffle(deck)
  end

  def create_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck
  end

  def shuffle(deck)
    shuffled_deck = []
    nums = (0..51).to_a
    ran_nums = []
    while ran_nums.length < 52
      ran_num = nums.sample
      if !ran_nums.include?(ran_num)
        ran_nums << ran_num
      end
    end
    ran_nums.each do |ran_num|
      shuffled_deck << deck[ran_num]
    end
    shuffled_deck
  end

  def draw
    if cards.empty?
      @cards = create_and_shuffle_deck 
    end
    cards.pop
  end

end

class Card
  attr_reader :rank, :suit

  RANK_VALUES = {
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    10 => 10,
    "Jack" => 11,
    "Queen" => 12,
    "King" => 13,
    "Ace" => 14
  }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    RANK_VALUES[rank] <=> RANK_VALUES[other.rank]
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def ==(other)
    self.to_s == other.to_s
  end
end

class PokerHand
  attr_reader :hand

  def initialize(cards)
    if cards.class == Deck
      @hand = deal_hand(cards)
    else
      @hand = cards
    end
  end

  def deal_hand(cards)
    hand = []
    5.times {hand << cards.draw}
    hand
  end

  def print
    @hand.each do |card|
      puts card
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    flush = hand.map(&:suit).uniq.length == 1
    flush && hand.sort.map(&:rank) == Card::RANK_VALUES.keys[-5..-1]
  end

  def straight_flush?
    flush = hand.map(&:suit).uniq.length == 1

    all_ranks = Card::RANK_VALUES.keys
    min_rank = hand.min.rank
    index_start = all_ranks.index(min_rank)
    putative_straight_ranks = all_ranks[index_start, 5]

    straight = putative_straight_ranks == hand.sort.map(&:rank)
    flush && straight
  end

  def four_of_a_kind?
    if hand.any? {|card| hand.map(&:rank).count(card.rank) == 4}
    true
    else
      false
    end
  end

  def full_house?
    ranks = hand.map(&:rank)
    ranks_uniq = ranks.uniq
    counts = ranks_uniq.map {|r| ranks.count(r)}
    counts.sort == [2, 3]
  end

  def flush?
    hand.map(&:suit).uniq.length == 1
  end

  def straight?
    all_ranks = Card::RANK_VALUES.keys
    min_rank = hand.min.rank
    index_start = all_ranks.index(min_rank)
    putative_straight_ranks = all_ranks[index_start, 5]

    putative_straight_ranks == hand.sort.map(&:rank)
  end

  def three_of_a_kind?
    if hand.any? {|card| hand.map(&:rank).count(card.rank) == 3}
      true
    else
      false
    end
  end

  def two_pair?
    ranks = hand.map(&:rank)
    ranks_uniq = ranks.uniq
    counts = ranks_uniq.map {|r| ranks.count(r)}
    if counts.count(2) == 2
      true
    else
      false
    end
  end

  def pair?
    if hand.any? {|card| hand.map(&:rank).count(card.rank) == 2}
      true
    else
      false
    end
  end
end

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'