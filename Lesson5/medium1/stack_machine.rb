require "pry"
class Minilang
  VALID = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  attr_reader :register, :commands, :commands_str

  def initialize(commands)
    @register = 0
    @stack = []
    @commands_str = commands
  end

  def check
    other = nil
    commands_no_nums = commands_str.split.select {|command| command.to_i == 0}
    commands_no_nums.each do |command|
      if !VALID.include?(command)
        other = command 
      end
    end
    other
  end

  def create_commands
    @commands = commands_str.split
  end

  def PUSH
    @stack.push(@register)
  end

  def ADD
    @register += @stack.pop
  end

  def SUB
    @register -= @stack.pop
  end

  def MULT
    @register *= @stack.pop
  end

  def DIV
    @register /= @stack.pop
  end

  def MOD
    @register = @register % @stack.pop
  end

  def POP
    @register = @stack.pop
  end

  def PRINT
    if @register
      puts @register
    else
      puts "Empty stack!"
    end
  end

  def eval
    create_commands
    begin
      commands.each do |command|
        if command.to_i == 0
          self.send(command.to_sym)
        else
          @register = command.to_i
        end
      rescue
        puts "Invalid token: #{check}" if check
        break
      end
    end
  end
end

# Minilang.new('PRINT').eval
# 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)


