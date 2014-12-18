class AddSortScoreToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sort_score, :integer
	  add_index :posts, [:sort_score], name: "index_posts_on_sort_score"
  end
end
