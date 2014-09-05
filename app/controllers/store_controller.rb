# Task C1
class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)
  end
end
