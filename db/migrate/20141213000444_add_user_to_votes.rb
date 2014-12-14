class AddUserToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :user, index: true
    add_foreign_key :votes, :users
  end
end
