class ChangePostSortScoreToFloat < ActiveRecord::Migration
  def change
    change_column :posts, :sort_score, :float
  end
end
