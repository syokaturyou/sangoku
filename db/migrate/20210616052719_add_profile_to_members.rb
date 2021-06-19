class AddProfileToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :profile, :text
  end
end
