class RemoveProviderFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :Provider, :string
  end
end
