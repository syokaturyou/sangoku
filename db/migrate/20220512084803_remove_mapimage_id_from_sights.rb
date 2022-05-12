class RemoveMapimageIdFromSights < ActiveRecord::Migration[5.2]
  def change
    remove_column :sights, :mapimage_id, :string
  end
end
