class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :member_id
      t.string :posttitle
      t.text   :postbody
      t.string :postsyutten
      t.string :postimage_id

      t.timestamps
    end
  end
end
