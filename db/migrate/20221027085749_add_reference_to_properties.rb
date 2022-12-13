class AddReferenceToProperties < ActiveRecord::Migration[7.0]
  def change
    add_reference :properties, :real_estate, foreign_key: true, index: true
    add_reference :properties, :user, foreign_key: true, index: true
    add_reference :users, :real_estate_responsible, index: true
    add_reference :users, :real_estate, index: true
  end
end
