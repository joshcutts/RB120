class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end


# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"
#   end

#   def show_template
#     self.template
#   end
# end

comp1 = Computer.new
comp1.create_template
p comp1.show_template


=begin

In the first class definiton, the `show_template` method
references a new local varaible `template`. When `show_template`
is invoked there will be a NameError

In the second class definition, the `show_template` method
references the getter method `self.template`, which will return
`"template 14231"` when `show_template is invoked.

=end