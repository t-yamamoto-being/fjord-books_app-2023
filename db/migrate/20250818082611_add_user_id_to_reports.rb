class AddUserIdToReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :user, null: true, foreign_key: true
    
    # 既存のデータにデフォルトのユーザーIDを設定
    reversible do |dir|
      dir.up do
        # 最初のユーザーを取得（存在しない場合は作成）
        default_user = User.first_or_create!(
          email: 'default@example.com',
          password: 'password',
          name: 'Default User'
        )
        
        # 既存のreportsにuser_idを設定
        execute <<-SQL
          UPDATE reports 
          SET user_id = #{default_user.id}
          WHERE user_id IS NULL
        SQL
        
        # user_idをNOT NULLに変更
        change_column_null :reports, :user_id, false
      end
    end
  end
end
