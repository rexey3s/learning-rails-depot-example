class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  # Task E3:
  def total_price
  	product.price * quantity
  end
end
