# Task D1: Finding a Cart
class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  # Task E1 : A Smarter Cart
  def add_product(product_id)
  	current_item = line_items.find_by(product_id: product_id)
  	if current_item
  		current_item.quantity += 1 
  	else
  		current_item = line_items.build(product_id: product_id)
  	end
  	current_item
  end
  # Task E : playing time 1
  def add_product_with_price(product_id,product_price)
  	current_item = line_items.find_by(product_id: product_id)
  	if current_item
  		current_item.quantity += 1
  	else
  		current_item = LineItem.new :product_id => product_id, :price => product_price
  		line_items << current_item
  	end
  	current_item
  end
  # Task E3:
  def total_price
  	line_items.to_a.sum { |item| item.total_price }
  end
  #
  def total_items
    line_items.to_a.sum { |item| item.quantity }
  end
end
