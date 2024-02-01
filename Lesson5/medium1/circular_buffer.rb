class CircularBuffer
  def initialize(size)
    @buffer = [nil] * size
    @next_pos = 0
    @old_pos = 0
  end

  def put(object)
    unless @buffer[@next_pos].nil?
      @old_pos = increment(@next_pos)
    end

    @buffer[@next_pos] = object
    @next_pos = increment(@next_pos)
  end

  def get
    value = @buffer[@old_pos]
    @buffer[@old_pos] = nil
    @old_pos = increment(@old_pos) unless value.nil?
    value
  end

  private

  def increment(position)
    (position + 1) % @buffer.size
  end

end

# class CircularBuffer
#   attr_reader :buffer, :size

#   def initialize(size)
#     @buffer = []
#     @size = size
#   end

#   def put(value)
#     if buffer.size >= size
#       get
#       buffer.push(value)
#     else
#       buffer.push(value)
#     end
#   end

#   def get
#     buffer.shift
#   end
# end

# buffer = CircularBuffer.new(3)
# puts buffer.get == nil

# buffer.put(1)

# buffer.put(2)
# puts buffer.get == 1

# buffer.put(3)
# buffer.put(4)
# puts buffer.get == 2

# buffer.put(5)
# buffer.put(6)
# buffer.put(7)
# puts buffer.get == 5
# puts buffer.get == 6
# puts buffer.get == 7
# puts buffer.get == nil

# buffer = CircularBuffer.new(4)
# puts buffer.get == nil

# buffer.put(1)
# buffer.put(2)
# puts buffer.get == 1

# buffer.put(3)
# buffer.put(4)
# puts buffer.get == 2

# buffer.put(5)
# buffer.put(6)
# buffer.put(7)
# puts buffer.get == 4
# puts buffer.get == 5
# puts buffer.get == 6
# puts buffer.get == 7
# puts buffer.get == nil

