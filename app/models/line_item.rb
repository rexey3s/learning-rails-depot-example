class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  # Task E3:
  def total_price
  	# Task E : playing time 1
  	# This price is a copy of product's price 
  	price * quantity
  end
end
