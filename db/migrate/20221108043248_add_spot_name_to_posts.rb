class AddSpotNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :spot_name, :string
  end
end
