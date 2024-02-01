module Walkable
  def walk
    puts "#{name} #{self.gait} forward"
  end
end

class Noble
  include Walkable
  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  private
  
  def gait
    "struts"
  end
end

bryon = Noble.new("Bryon", "Lord")
bryon.walk