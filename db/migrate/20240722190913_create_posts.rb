class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.date :date, null: false
      t.text :body, null: false

      t.timestamps

      t.index :date, unique: true
    end
  end
end
