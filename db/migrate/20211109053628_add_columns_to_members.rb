class AddColumnsToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :uid, :string
    add_column :members, :provider, :string
  end
  add_index :users, [:provider, :uid], unique: true #これを追記する
end
