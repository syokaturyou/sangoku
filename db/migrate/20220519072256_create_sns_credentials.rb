class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.string :provider
      t.string :mid
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
