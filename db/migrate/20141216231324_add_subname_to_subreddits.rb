class AddSubnameToSubreddits < ActiveRecord::Migration
  def change
    add_column :subreddits, :subname, :string
  end
end
