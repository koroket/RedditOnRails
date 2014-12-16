class AddCommentToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :comment, index: true
    add_foreign_key :votes, :comments
  end
end
