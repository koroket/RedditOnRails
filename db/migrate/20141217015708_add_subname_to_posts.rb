class AddSubnameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :subname, :string
  end
end
