class CreateSights < ActiveRecord::Migration[5.2]
  def change
    create_table :sights do |t|
      t.string :address
      t.string :profile
      t.float :latitude
      t.float :longitude
      t.integer :member_id
      t.string :mapimage_id

      t.timestamps
    end
  end
end
