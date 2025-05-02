class AddRegistrationKeyAndAvatarToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :registration_key, :string
    add_column :users, :avatar, :string
  end
end
