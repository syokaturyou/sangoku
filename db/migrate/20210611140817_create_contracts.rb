class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|

      t.string :name
      t.string :email,   null: false, default: ""
      t.string :phone_number
      t.text   :message

      t.timestamps
    end
  end
end
