class AddCommentsToShare < ActiveRecord::Migration
  def change
    add_column :shares, :comments, :string
  end
end
