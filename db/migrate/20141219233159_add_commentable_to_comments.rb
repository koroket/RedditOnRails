class AddCommentableToComments < ActiveRecord::Migration
  def change
  	add_reference :comments, :commentable, polymorphic: true
  end
end
