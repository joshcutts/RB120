module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

=begin

How do you find where Ruby will look for a method when that
method is called?

By looking at the calling objects' ancestors you can determine 
where Ruby will look for a method when it is called.

How can you find an object's ancestors?
You can invoke the `ancestors` method on an the CLASS to see
it's ancestors.

What is the lookup chain for `Orange` and `HotSauce`?
Orange
-------
Orange
Taste
Object
Kernel
BasicObject


HotSauce
--------
HotSauce
Taste
Object
Kernel
BasicObject

=end

orange = Orange.new
hotsauce = HotSauce.new
p "ORANGE"
p Orange.ancestors
puts
p "HOTSAUCE"
p HotSauce.ancestors