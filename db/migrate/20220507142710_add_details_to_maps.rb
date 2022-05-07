class AddDetailsToMaps < ActiveRecord::Migration[5.2]
  def change
    add_column :maps, :mapimage_id, :string
  end
end
