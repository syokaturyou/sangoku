class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|

      t.integer :member_id
      t.integer :post_id
      t.string :answerimage_id
      t.text   :answerbody
      t.string :answersyutten

      t.timestamps
    end
  end
end
