class CreatePropertyMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :property_media do |t|
      t.string :media_path, null: false
      t.integer :media_type, default: 0
      t.integer :status, default: 0
      t.belongs_to :property, foreign_key: true
      t.timestamps
    end
  end
end
