class AddDeadlineToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :deadline, :date
  end
end
