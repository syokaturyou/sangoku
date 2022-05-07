class RemoveMemberIdFromMaps < ActiveRecord::Migration[5.2]
  def change
    remove_column :maps, :member_id, :integer
  end
end
