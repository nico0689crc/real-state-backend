class CreatePropertyAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :property_attributes do |t|
      t.string :name, null: false
      t.string :icon_name, null: false
      t.string :p_attribute_value
      t.boolean :important, default: false
      t.integer :p_attribute_type, null: false
      t.belongs_to :property
      t.timestamps
    end
  end
end
