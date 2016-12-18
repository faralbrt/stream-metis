class CreateAsinLogs < ActiveRecord::Migration
  def change
    create_table :asinlogs do |t|
      t.integer :asin_id, null: false
      t.string :title, null: false
      t.float :price, null: false
      t.float :cost

      t.timestamps null: false
    end
  end
end
