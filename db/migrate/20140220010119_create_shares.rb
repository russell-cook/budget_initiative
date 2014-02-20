class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :user, index: true
      t.references :initiative, index: true
      t.boolean :edit

      t.timestamps
    end
  end
end
