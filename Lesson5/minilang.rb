class Minilang
  VALID = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  attr_reader :register, :commands

  def initialize(commands)
    @register = 0
    @stack = []
    @commands = commands.split(" ")
  end

  def check
    other = nil
    @commands.gsub(/[\d]/, "").each do |command|
      other = command if !VALID.include?(command)
    end
    other
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
    @register % @stack.pop
  end

  def POP
    @stack.pop
  end

  def PRINT
    puts @register
  end

  def eval
    return check if check
    # @commands.each do |command|
    #   if command.class == String
    #     self.send(command.to_sym, @register)
    #   else
    #     @register = command.to_i
    #   end
    # end
  end
end

Minilang.new('PRINT')
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

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)
