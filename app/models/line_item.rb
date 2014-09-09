class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  # Task E3:
  def total_price
  	# Task E : playing time 1
  	# This price is a copy of product's price 
  	self.price * self.quantity
  end
  def decrease_quantity
  	if quantity > 1
  		self.quantity -= 1
  	else
  		self.destroy 
  	end
  	self
  end
  def increase_quantity
  	self.quantity += 1
  	self
  end
end
