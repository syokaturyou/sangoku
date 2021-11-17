class RemoveProviderFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :provider, :string
  end
end
