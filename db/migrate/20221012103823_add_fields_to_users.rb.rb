class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :gender, :string
    add_column :users, :user_role, :integer, null: false, default: 0
    add_column :users, :send_password_reset_user_initial, :boolean, default: false
    remove_column :users, :name, :string
    remove_column :users, :nickname, :string
  end
end