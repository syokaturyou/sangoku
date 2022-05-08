class CreateEvaluates < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluates do |t|
      t.integer :member_id
      t.integer :sight_id
      t.float :rate, default: 0

      t.timestamps
    end
  end
end
