class AdminController < ApplicationController
  # Task I2: Authenticating Users
  skip_before_action :authorize
  def index
  	@total_orders = Order.count
  end
end
