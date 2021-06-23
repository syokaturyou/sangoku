class AddGenreIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :genre_id, :integer
  end
end
