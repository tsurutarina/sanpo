class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|

      t.string :spot_name    ,null: false
      t.string :spot_address ,null: false

      t.timestamps
    end
  end
end
