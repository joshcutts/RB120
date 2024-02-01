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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.