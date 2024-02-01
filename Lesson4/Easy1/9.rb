class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

new_bag = Bag.new("blue", "plastic")
p new_bag
p new_bag.instance_variables
=begin

You would need to call the `new` method with 2 arguments.

=end