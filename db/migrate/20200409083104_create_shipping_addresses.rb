class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :name_first,       null: false
      t.string :name_last,        null: false
      t.string :name_first_kana,  null: false
      t.string :name_last_kana,   null: false
      t.string :zipcode,         null: false
      t.integer :prefecture_id,   null: false
      t.string :city,             null: false
      t.string :street_address,   null: false
      t.string :building
      t.string :phone_number
      t.references :user,         foreign_key: true

      t.timestamps
    end
  end
end
