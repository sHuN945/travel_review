class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :customer_id, null: false
      t.integer :post_id, null: false
      t.string :star, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
