class AddRegistrationKeyAndAvatarToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :registration_key, :string unless column_exists?(:users, :registration_key)
    add_column :users, :avatar, :string unless column_exists?(:users, :avatar)
  end
end
