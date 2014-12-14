class AddPostToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :post, index: true
    add_foreign_key :votes, :posts
  end
end
