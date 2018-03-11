class CreateCommodities < ActiveRecord::Migration[5.1]
  def change
    create_table :commodities do |t|
      t.string :name
      t.string :file_id
      t.integer :price
      t.text :caption
      t.boolean :display_flag
      t.integer :display_index

      t.timestamps
    end
    add_index :commodities, :file_id, unique: true
  end
end
