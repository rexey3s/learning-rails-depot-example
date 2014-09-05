# Task D1: Finding a Cart
class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
end
