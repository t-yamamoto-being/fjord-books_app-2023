class UpdateCommentsUserForeignKey < ActiveRecord::Migration[7.0]
  def change
    # Remove the existing foreign key constraint
    remove_foreign_key :comments, :users
    
    # Add a new foreign key constraint that allows null values
    add_foreign_key :comments, :users, on_delete: :nullify
  end
end
