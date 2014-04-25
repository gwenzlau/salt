class AddDetailsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :details, :string
  end
end
