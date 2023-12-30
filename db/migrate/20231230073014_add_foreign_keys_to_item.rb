class AddForeignKeysToItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :situation, null: true, foreign_key: true
    add_reference :items, :genre, null: true, foreign_key: true
  end
end
