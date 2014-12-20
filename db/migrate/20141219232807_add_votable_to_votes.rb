class AddVotableToVotes < ActiveRecord::Migration
  def change
  	add_reference :votes, :votable, polymorphic: true
  end
end
