class AddAuthenticationFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_token, :string
  end
end
