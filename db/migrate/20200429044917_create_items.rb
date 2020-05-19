class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :items_name,       null: false
      t.text   :item_description, null: false
      t.string :condition,        null: false
      t.string :shipping_costs,   null: false
      t.string :days_to_ship,     null: false
      t.integer :price,           null: false
      t.integer :user_id,         foreign_key: true
      t.integer :category_id,     foreign_key: true, null: false
      t.integer :brand_id,        foreign_key: true
      t.integer :prefecture_id, foreign_key: true, null: false
      t.integer :comment_id,      foreign_key: true
      t.timestamps
    end
  end
end
