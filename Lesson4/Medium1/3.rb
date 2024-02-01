class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

=begin

This is a valid way to fix the issue, however it 
allows the instance variables `@quantity` & `@product_name`
to be updated via the setter methods. 

=end