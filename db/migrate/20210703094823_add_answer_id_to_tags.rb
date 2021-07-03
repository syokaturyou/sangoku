class AddAnswerIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :answer_id, :integer
  end
end
