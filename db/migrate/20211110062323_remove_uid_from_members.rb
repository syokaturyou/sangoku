class RemoveUidFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :Uid, :string
  end
end
