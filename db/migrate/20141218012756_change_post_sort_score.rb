class ChangePostSortScore < ActiveRecord::Migration
  def change
    change_column :posts, :sort_score, :integer
  end
end
