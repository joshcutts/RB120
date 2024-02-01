=begin

`self.class` returns the name of the class, which is 
the name of the vehicle.

_____

`self` refers to the object referenced by `small_car`.
In this case that is a `Car` object. 
We ask `self` to tell us its class with `class`
We dont need to use to_s here because
it is a `string` and is interpolated which means 
it will take care of the `to_s` for us.

=end