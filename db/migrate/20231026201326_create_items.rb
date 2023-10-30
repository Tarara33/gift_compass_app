class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name,              null: false
      t.string :item_image
      t.string :item_url
      t.integer :price,            null: false
      t.integer :price_range,      null: false
      t.integer :target_gender,    null: false
      t.text :memo

      t.timestamps
    end
  end
end
