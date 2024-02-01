class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future
# one of the strings from `choices` in `RoadTrip` class
=begin

Ruby tries to resolve a method name starting with
methods defined on the class you are calling.
Even though there is a method defined in `Oracle`
Ruby will first look for a definition of `choices`
in `RoadTrip` before falling back to `Oracle` if
it does not find `choices` defined in `RoadTrip`.

=end