class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
# tv.manufacturer #NoMethodError
# tv.model #whatever the model instance method outputs

# Television.manufacturer # whatever the class method `manufacturer` outputs
Television.model #NoMethodError