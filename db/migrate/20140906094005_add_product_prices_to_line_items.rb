class AddProductPricesToLineItems < ActiveRecord::Migration
  # Task E : Playing time 1
  def up 
  	add_column :line_items, :price, :decimal, :precision => 8, :scale => 2
  	say_with_time "Updating prices ... " do
  		LineItem.all.each do |item|
  			item.update_attribute :price, item.product.price
  		end
  	end
  end
  def down
  	remove_column :line_items, :price
  end
end
