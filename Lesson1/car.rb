require "Time"

class Vehicle
  attr_accessor :speed, :color
  attr_reader :year, :model, :mpg

  @@num = 0

  def self.vehicle_num
    puts "There are #{@@num} vehicle objects created"
  end

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@num += 1
  end

  def increase_speed(mph)
    @speed += mph
    puts "You push the gas and accelerate #{mph} mph"
  end

  def brake(b)
    @speed -= b
    puts "You push the brake and decelerate #{b} mph"
  end

  def current_speed
    puts "You are now going #{@speed} mph"
  end

  def spray_paint(color)
    @color = color
    puts "Your #{@model} is now #{@color}"
  end

  def off
    @speed = 0
    puts "You turn the car off"
  end

  def calc_mpg(tank, miles)
    @mpg = miles/tank
  end

  def to_s
    "This is a #{color} #{year} #{model}. Nice car!"
  end

  def how_old
    "This #{model} is #{age} years old"
  end

  private

  def age
    Time.now.year - year
  end
end

module Towwable
  def towing
    "I can tow"
  end
end


class MyCar < Vehicle
end

class MyTruck < Vehicle
  include Towwable

  TRUCK_BED = true
end

tank = MyCar.new(1998, "grey", "4Runner")
# tank.increase_speed(10)
# tank.current_speed
# tank.brake(5)
# tank.current_speed
# tank.off
# tank.current_speed

fury = MyTruck.new(2000, "red", "Tacoma")
p fury.towing

Vehicle.vehicle_num

# puts tank.color
# tank.color = "red"
# puts tank.color
# puts tank.year
# tank.spray_paint("purple")
# puts tank.color
# tank.calc_mpg(20, 200)
# puts tank.mpg
# puts tank

puts MyTruck.ancestors
puts
puts Vehicle.ancestors

puts fury.how_old