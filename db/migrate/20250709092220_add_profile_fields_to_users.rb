class AddProfileFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :postal_code, :string unless column_exists?(:users, :postal_code)
    add_column :users, :address, :string unless column_exists?(:users, :address)
    add_column :users, :introduction, :text unless column_exists?(:users, :introduction)
  end
end
