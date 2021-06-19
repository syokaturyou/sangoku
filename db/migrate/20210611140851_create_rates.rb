class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|

      t.integer :member_id
      t.integer :post_id
      t.float :communication, default: 0
      t.float :source, default: 0
      t.float :rationality, default: 0
      t.float :intellect, default: 0

      t.timestamps
    end
  end
end
