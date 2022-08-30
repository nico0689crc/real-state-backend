class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.text :description
      t.integer :p_type
      t.integer :p_status
      t.string :operating_since
      t.float :price
      t.string :address
      t.string :coordinates
      t.integer :sq_mts
      t.integer :bathroom_amount
      t.integer :beedroom_amount

      t.timestamps
    end
  end
end
