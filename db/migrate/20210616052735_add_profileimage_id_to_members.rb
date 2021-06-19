class AddProfileimageIdToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :profileimage_id, :string
  end
end
