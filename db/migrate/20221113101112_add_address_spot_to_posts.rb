class AddAddressSpotToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :address_spot, :text
  end
end
