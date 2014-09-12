# Task C1
class StoreController < ApplicationController
  # Task I3: Limit Access
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart
  def index
  	@products = Product.order(:title)
  	increment_counter
  end
end
# Taks D: Playtime 1 - counting how many time user access store/index
def increment_counter
	if session[:counter].nil?
		session[:counter] = 0
	end
	session[:counter] += 1
end