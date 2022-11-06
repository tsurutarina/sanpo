class RemoveLongitudeFormPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :longitude, :float
  end
end
