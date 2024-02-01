class FixedArray
  def initialize(elements)
    @arr = Array.new(elements)
  end

  def [](index)
    @arr.fetch(index)
  end

  def to_a
    @arr.clone
  end

  def to_s
    to_a.to_s
  end

  def []=(index, value)
    # self[index]
    @arr[index] = value
  end
end

fixed_array = FixedArray.new(5)
p fixed_array
a = fixed_array.to_a
a.delete_at(0)
p fixed_array
# puts "1"
# puts fixed_array[3] == nil
# puts "2"
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts "3"
# puts fixed_array[3] == 'a'
# puts "4"
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts "5"
# puts fixed_array[1] == 'b'
# puts "6"
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts "7"
# puts fixed_array[1] == 'c'
# puts "8"
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts "9"
# puts fixed_array[4] == 'd'
# puts "10"
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts "11"
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts "12"
# puts fixed_array[-1] == 'd'
# puts "13"
# puts fixed_array[-4] == 'c'

# puts "14"
# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end
# puts "15"
# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end
# puts "16"
# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end