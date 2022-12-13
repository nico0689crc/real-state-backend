class CreateRealEstate < ActiveRecord::Migration[7.0]
  def change
    create_table :real_estates do |t|
      t.string :name
      t.text :description
      t.integer :status, default: 0
      t.string :contact_phone
      t.string :contact_email
      t.string :social_medias
      t.string :address
      t.timestamps
    end
  end
end
