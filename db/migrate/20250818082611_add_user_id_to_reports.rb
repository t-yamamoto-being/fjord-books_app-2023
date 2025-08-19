class AddUserIdToReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :user, null: true, foreign_key: true

    reversible do |dir|
      dir.up do
        default_user = User.first_or_create!(
          email: 'default@example.com',
          password: 'password',
          name: 'Default User'
        )

        execute <<-SQL
          UPDATE reports 
          SET user_id = #{default_user.id}
          WHERE user_id IS NULL
        SQL

        change_column_null :reports, :user_id, false
      end
    end
  end
end
