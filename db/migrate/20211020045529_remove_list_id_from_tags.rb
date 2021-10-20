class RemoveListIdFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :tags, :list_id, :integer
  end
end
