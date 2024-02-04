require "pry"
require "tty-table"
require "yaml"

class Move
  attr_reader :value

  VALUES = %w(rock paper scissors lizard spock)
  ABRV = %w(r p sc l sp)
  VALUES_AND_ABRV = VALUES.zip(ABRV).flatten
  WINS = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['scissors', 'rock'],
    'lizard' => ['spock', 'paper']
  }

  def initialize(value)
    @value = convert_input_value(value)
  end

  def convert_input_value(value)
    if value.length <= 2
      ABRV.zip(VALUES).to_h[value]
    else
      value
    end
  end

  def <=>(other)
    if value == other.value
      0
    elsif WINS[value].include?(other.value)
      1
    else
      -1
    end
  end

  def to_s
    @value
  end
end

class Score
  attr_accessor :value, :grand_winner, :gw_wins

  def initialize(human, computer)
    @value = { human.name => 0, computer.name => 0 }
    @human = human
    @computer = computer
    @gw_wins = input_num_wins_for_gw
  end

  def winner
    if (@human.move <=> @computer.move) == 1
      @human.name
    elsif (@human.move <=> @computer.move) == -1
      @computer.name
    else
      "tie"
    end
  end

  def increment
    case winner
    when @human.name then value[@human.name] += 1
    when @computer.name then value[@computer.name] += 1
    end
  end

  def player_score(player, spaces)
    left_pad = (spaces.length / 2) - 1
    name = player.name
    score = value[name]
    "#{spaces}| #{name}#{' ' * (left_pad - name.length)}| #{score} |"
  end


  def generate_scoreboard
    spaces = ' ' * 28
    sep_line = '-' * 20
    half = (18 - "SCOREBOARD".length) / 2
    
    ["#{spaces}#{sep_line}",
     "#{spaces}|#{' ' * half}SCOREBOARD#{' ' * half}|",
     "#{spaces}#{sep_line}",
     player_score(@human, spaces),
     player_score(@computer, spaces),
     "#{spaces}#{sep_line}"]
  end

  def display_scoreboard
    puts generate_scoreboard
  end

  def input_num_wins_for_gw
    puts ''
    puts 'Choose the number of wins required to become the GRAND WINNER (1-10)'
    @gw_wins = 0
    loop do
      @gw_wins = gets.chomp.to_i
      break if @gw_wins.between?(1, 10)
      puts 'Invalid input. Please enter a number between 1 and 10.'
    end
    @gw_wins
  end

  def determine_grand_winner
    @grand_winner =
      if value[@human.name] == @gw_wins
        @human.name
      else
        @computer.name
      end
  end

  def display_grand_winner
    puts "The GRAND WINNER is #{determine_grand_winner}!"
  end

  def reset
    @value = { @human.name => 0, @computer.name => 0 }
  end
end

class Archive
  attr_reader :round_num

  def initialize(human, computer, score)
    @round_num = 1
    @human = human
    @computer = computer
    @header = ["Round"] + (Move::VALUES * 2) + ["Winner", "Grand Winner"]
    @spacer = Array.new(13, "---")
    @moves_record = [@header, @spacer]
    @score = score
  end

  def round_moves
    round_info = [@round_num]
    round_info += create_xs(@human.move.value)
    round_info += create_xs(@computer.move.value)
    round_info += [@score.winner, ""]

    @moves_record << round_info
    @round_num += 1
  end

  def grand_winner
    gw_row = Array.new(12, "-")
    gw_row << @score.grand_winner
    @moves_record << gw_row
  end

  def create_xs(move)
    x_placements = {
      "rock" => ["X", "", "", "", ""],
      "paper" => ["", "X", "", "", ""],
      "scissors" => ["", "", "X", "", ""],
      "lizard" => ["", "", "", "X", ""],
      "spock" => ["", "", "", "", "X"]
    }
    x_placements[move]
  end

  def display
    puts ''
    puts "#{' ' * 19}#{@human.name} Moves#{' ' * 26}#{@computer.name} Moves"
    table = TTY::Table.new(@moves_record)
    puts table.render(:unicode, alignment: [:center])
  end

  def new_game
    @round_num = 1
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    @move = nil
    set_name
  end
end

class Human < Player
  attr_reader :name

  def set_name
    set_name_display_welcome
    @name = ""
    attempts = 0
    loop do
      @name = gets.chomp
      break if (valid_input?(@name) || attempts >= 2)
      handle_invalid_input(@name)
      attempts += 1
    end
    puts "Let's just call you 'Difficult' shall we?" if attempts >= 2
    attempts >= 2 ? "Difficult" : @name
  end

  def set_name_display_welcome
    puts "First things first, what's your name?"
  end

  def handle_invalid_input(name)
    if name.empty?
      puts "You can't have a blank name! Please try again."
    elsif !valid_input?(name)
      puts "You can't trick me with spaces! Please enter a valid name."
    end
  end

  def valid_input?(name)
    !name.gsub(" ", "").empty?
  end

  def format_moves
    formatted_moves = Move::VALUES_AND_ABRV.each_slice(2).map do |move|
      "#{move[0]} (#{move[1]})"
    end
    "#{formatted_moves[0, 4].join(', ')} or #{formatted_moves[-1]}"
  end

  def choose
    choice = nil
    loop do
      puts "Please choose #{format_moves}:"
      choice = gets.chomp
      break if Move::VALUES_AND_ABRV.include?(choice.downcase)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice.downcase)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Iron Giant', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  MESSAGES = YAML.safe_load(File.read("messages_yaml.yml"))
  RULES = ["The rules of the game are as follows:",
           "Scissors cuts Paper",
           "Paper covers Rock",
           "Rock crushes Lizard",
           "Lizard poisons Spock",
           "Spock smashes Scissors",
           "Scissors decapitates Lizard",
           "Lizard eats Paper",
           "Paper disproves Spock",
           "Spock vaprozes Rock, and as it always has",
           "Rock crushes Scissors"]

  attr_accessor :human, :computer, :score, :archive

  def initialize
    system "clear"
    display_welcome_message
    @human = Human.new
    display_rules
    @computer = Computer.new
    @score = Score.new(@human, @computer)
    @archive = Archive.new(@human, @computer, @score)
  end

  # rock, paper scissors art from https://gist.github.com/wynand1004/b5c521ea8392e9c6bfe101b025c39abe
  # spock adapted from https://www.deviantart.com/astrotorical/art/Spock-425909744
  # lizard adapted from https://www.asciiart.eu/animals/reptiles/lizards - jro
  def display_welcome_message
    puts ''
    puts "WELCOME TO".center(86)
    puts ''
    # puts "The first player to 10 wins is the GRAND WINNER!"
    puts MESSAGES["art"]
    puts ''
  end

  def display_rules_input
    puts "Do you want to see the rules of the game?(Y/N)"
    response = ""
    loop do
      response = gets.chomp.downcase
      break if %w(y n).include?(response.downcase)
      puts "Invalid input. Please enter y or n" unless response == "n"
    end
    response == "y"
  end

  def display_rules
    return unless display_rules_input
    RULES.each do |rule|
      puts rule
      sleep(1.25)
    end
    sleep(3.5)
  end

  def display_round_num
    puts "Starting round #{@archive.round_num}".upcase.center(76)
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing #{Move::VALUES}. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}."
    sleep(2)
  end

  def display_winner
    if score.winner == "tie"
      puts "It's a tie!"
    else
      puts "#{score.winner} won!"
    end
    sleep(2)
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    return true if answer.downcase == 'y'
    false
  end

  def grand_winner?
    score.value.values.any?(@score.gw_wins)
  end

  def display_archive
    puts "Do you want to see a history of the moves made? (Y/N)"
    input = ""
    loop do
      input = gets.chomp
      break if %w(y n).include?(input.downcase)
      puts 'Invalid input. Please input either Y or N'
    end
    input == "y" ? archive.display : nil
  end

  def round
    system "clear"
    display_round_num
    score.display_scoreboard
    human.choose
    computer.choose
    display_moves
    display_winner
    score.increment
    archive.round_moves
  end

  def reset_for_next_game
    score.reset
    archive.new_game
  end

  def end_game
    score.display_grand_winner
    archive.grand_winner
    display_archive
    reset_for_next_game
  end

  def play
    loop do
      round
      if grand_winner?
        end_game
        break unless play_again?
      end
    end
    display_goodbye_message
  end
end

RPSGame.new.play
