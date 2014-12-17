class AddSubredditToPosts < ActiveRecord::Migration
  def change
     add_reference :posts, :subreddit, index: true
  end
end
