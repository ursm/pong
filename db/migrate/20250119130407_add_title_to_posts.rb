class AddTitleToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column    :posts, :title, :string, null: false
    remove_column :posts, :date,  :date,   null: false
  end
end
