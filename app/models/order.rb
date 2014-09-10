class Order < ActiveRecord::Base
	# Task G1 : Capturing order 
  # PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  has_one :payment_type
	has_many :line_items, dependent: :destroy
  validates :name, :address, :email, presence: true
  # validates :pay_type, inclusion: PAYMENT_TYPES
  # Change affected by Task G Playing time activity 2
  validates :payment_type_id, presence: true

  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  #
end
