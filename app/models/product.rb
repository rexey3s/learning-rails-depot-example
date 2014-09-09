class Product < ActiveRecord::Base
  # Task D2 :Connecting Product
  has_many :line_items
  # Task G2 : Atom Feeds
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  # Task B1 :Create validation
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01 ,less_than_or_equal_to: 1000}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, uniqueness: true ,format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  # Task C5 :Caching for view/store/index.html.erb
  def self.latest
  	Product.order(:updated_at).last
  end
  # Task D2 :Connecting Product
  private
    def ensure_not_referenced_by_any_line_item
      	if line_items.empty?
      		return true
      	else
      		errors.add(:base, 'Line Items present')
      		return false
      	end
    end
end