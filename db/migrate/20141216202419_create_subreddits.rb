class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|

      t.timestamps null: false
    end
  end
end
