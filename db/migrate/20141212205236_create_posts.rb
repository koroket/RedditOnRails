class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.text :body

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
  end
end
