class AddAnswerIdToRates < ActiveRecord::Migration[5.2]
  def change
    add_column :rates, :answer_id, :integer
  end
end
