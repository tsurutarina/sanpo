class AddAddressToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :address, :text
  end
end
