class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

=begin

The getter and setter methods from attr_accessor
don't add any value since neither `@brightness` or @color
are referenced in the `Light` class definition.

Also the explicit return in the `information` method.

=end