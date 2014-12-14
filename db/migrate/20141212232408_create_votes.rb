class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :isUpvote

      t.timestamps null: false
    end
  end
end
