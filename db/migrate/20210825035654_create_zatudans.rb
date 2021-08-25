class CreateZatudans < ActiveRecord::Migration[5.2]
  def change
    create_table :zatudans do |t|
      t.string :message

      t.timestamps
    end
  end
end
