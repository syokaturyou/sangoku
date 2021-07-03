class AddScoreToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :score, :decimal, precision: 5, scale: 3
  end
end
