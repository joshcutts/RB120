require "pry"
class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.select { |_, square| square.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(line, marker)
    markers_in_line = @squares.values_at(*line).map(&:marker)
    markers_in_line.all? { |mark| marker == mark } && marker != ' '
  end

  def winning_marker
    WINNING_LINES.each do |line|
      test_marker = @squares[line[0]].marker
      return test_marker if three_identical_markers?(line, test_marker)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/MethodLength
  def draw
    [
      "     |     |     ",
      "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  ",
      "     |     |     ",
      "-----+-----+-----",
      "     |     |     ",
      "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  ",
      "     |     |     ",
      "-----+-----+-----",
      "     |     |     ",
      "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  ",
      "     |     |     ",
      ""
    ]
  end
  # rubocop:enable Metrics/MethodLength
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
    # maybe a "status" to ekeep track of this square's mark?
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  COMPUTER_MARKER = 'O'

  attr_reader :board, :human, :computer, :score

  def initialize
    @board = Board.new
    @computer = Player.new(COMPUTER_MARKER)
    @name = aquire_name
  end

  def play
    clear
    display_welcome_message
    create_human_player
    initialize_score
    select_first_move
    clear
    main_game
    clear
    display_goodbye_message
  end

  private

  def clear
    system 'clear'
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
    puts "Welcome to Tic Tac ....wait!!"
    sleep(2)
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
    puts "Welcome to Tic Tac Toe, #{@name}!"
    sleep(1)
    puts 'First player to 5 wins is the GRAND WINNER!'
    sleep(1.5)
    puts ''
  end

  def create_human_player
    @human_marker = select_custom_marker
    @human = Player.new(@human_marker)
  end

  def select_custom_marker
    display_custom_marker_welcome
    input = acquire_y_or_n
    if input == "n"
      return "X"
    elsif input == "y"
      marker = select_valid_marker
    end
    marker
  end

  def display_custom_marker_welcome
    puts "Would you like to select a marker for the game? (y/n)"
    puts %(Select "y" to select any single character as a marker.)
    puts %(Select "n" to use the default "X" as a marker.)
  end

  def acquire_y_or_n
    input = ""
    loop do
      input = gets.chomp.downcase
      break if %w(y n).include?(input)
      puts "Please enter either y or n"
    end
    input
  end

  def select_valid_marker
    marker = ""
    puts "Great! Please select a single character as your marker."
    loop do
      marker = gets.chomp
      break if valid_input?(marker) && marker.length == 1
      puts "Please select a single character for a marker."
    end
    marker
  end

  def select_first_move
    puts "Do you want to have the first move? (y/n)"
    input = acquire_y_or_n
    if input == "y"
      @current_marker = @human_marker
    elsif input == "n"
      @current_marker = computer.marker
    end
  end

  def initialize_score
    @score = { @human => 0, @computer => 0 }
  end

  def main_game
    loop do
      loop do
        round
        break if score.values.any?(5)
        reset
      end
      break unless play_again?
      reset_board_and_score
      display_play_again_message
    end
  end

  def round
    display_board_and_scoreboard
    player_move
    increment_score
    display_result
    display_grand_winner
  end

  def display_board_and_scoreboard
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ''
    format_board_and_scoreboard
    puts ''
  end

  def name_fits_default_spacing
    @name.length <= 8
  end

  def generate_default_scoreboard
    spaces = " " * 5
    ["#{spaces}----------------",
     "#{spaces}|  SCOREBOARD  |",
     "#{spaces}----------------",
     "#{spaces}| #{@name}#{' ' * (9 - @name.length)}| #{score[human]} |",
     "#{spaces}| Computer | #{score[computer]} |",
     "#{spaces}----------------"]
  end

  def generate_extended_scoreboard
    spaces = " " * 5
    length = @name.length - 8
    front_half = length / 2
    back_half = ((length / 2) + 1) if @name.length.odd?
    back_half = (length / 2) if @name.length.even?
    dashes = "-" * (length)

    [
      "#{spaces}----------------#{dashes}",
      "#{spaces}| #{' ' * front_half} SCOREBOARD #{' ' * back_half} |",
      "#{spaces}----------------#{dashes}",
      "#{spaces}| #{@name} | #{score[human]} |",
      "#{spaces}| Computer#{' ' * (@name.length - 'Computer'.length)} | #{score[computer]} |",
      "#{spaces}----------------#{dashes}"
    ]
  end

  def display_score
    scoreboard_output =
      if name_fits_default_spacing
        generate_default_scoreboard
      else
        generate_extended_scoreboard
      end
    scoreboard_output
  end

  def format_board_and_scoreboard
    inner = 0
    board.draw.each_with_index do |line, index|
      if index < 7
        print "#{line} #{display_score[inner]}\n"
        inner += 1
      else
        puts line
      end
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def current_player_moves
    if @current_marker == @human_marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = @human_marker
    end
  end

  def human_moves
    puts "Choose a square: #{joinor(board.unmarked_keys)}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end
    board[square] = human.marker
  end

  def joinor(arr)
    case arr.length
    when 1 then arr[0]
    when 2 then arr.join(" or ")
    else "#{arr[0..-2].join(', ')} or #{arr[-1].to_s}"
    end
  end

  def computer_moves
    defense_square = find_at_risk_square
    attack_square = find_attack_square
    empty_squares = board.unmarked_keys
    if empty_squares.include?(5)
      board[5] = computer.marker
    elsif attack_square
      board[attack_square] = computer.marker
    elsif defense_square
      board[defense_square] = computer.marker
    else
      board[empty_squares.sample] = computer.marker
    end
  end

  def find_attack_square
    attack_square = nil
    Board::WINNING_LINES.each do |line|
      markers_in_line = board.squares.values_at(*line).map(&:marker)
      if markers_in_line.count(computer.marker) == 2 && markers_in_line.count(@human_marker) != 1
        at_risk_line = board.squares.select { |key, _| line.include?(key) }
        attack_square = at_risk_line.reject { |_, square| square.marker == computer.marker }.keys[0]
      end
    end
    attack_square
  end

  def find_at_risk_square
    at_risk_square = nil
    Board::WINNING_LINES.each do |line|
      markers_in_line = board.squares.values_at(*line).map(&:marker)
      if markers_in_line.count(@human_marker) == 2 && markers_in_line.count(computer.marker) != 1
        at_risk_line = board.squares.select { |key, _| line.include?(key) }
        at_risk_square = at_risk_line.reject { |_, square| square.marker == @human_marker }.keys[0]
      end
    end
    at_risk_square
  end

  def winning_marker
    Board::WINNING_LINES.each do |line|
      test_marker = @squares[line[0]].marker
      return test_marker if three_identical_markers?(line, test_marker)
    end
    nil
  end

  def clear_screen_and_display_board
    clear
    display_board_and_scoreboard
  end

  def increment_score
    case board.winning_marker
    when human.marker then score[human] += 1
    when computer.marker then score[computer] += 1
    end
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then puts 'You won!'
    when computer.marker then puts 'Computer won!'
    else puts "It's a tie!"
    end
    sleep(1.5)
  end

  def display_grand_winner
    if score[human] >= 5
      puts "Congrats #{@name}! You are the GRAND WINNER!"
    elsif score[computer] >= 5
      puts "The computer is the GRAND WINNER!"
      puts "Better luck next time..."
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
    board.reset
    clear
  end

  def reset_board_and_score
    reset
    @score = { @human => 0, @computer => 0 }
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe #{@name}! Goodbye!"
  end
end

game = TTTGame.new
game.play
