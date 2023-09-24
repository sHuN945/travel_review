class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :customer_id, null: false
      t.text :introduction, null: false
      t.string :post_place, null: false
      t.string :star, null: false
      t.timestamps
    end
  end
end
