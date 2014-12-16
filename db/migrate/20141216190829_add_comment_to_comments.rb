class AddCommentToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :comment, index: true
  end
end
