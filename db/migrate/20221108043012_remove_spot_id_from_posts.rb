class RemoveSpotIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :spot_id, :integer
    remove_column :posts, :longitude, :float
    remove_column :posts, :latitude, :float
  end
end
