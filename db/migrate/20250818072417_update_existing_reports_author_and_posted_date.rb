class UpdateExistingReportsAuthorAndPostedDate < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE reports 
          SET author = 'Unknown User', 
              posted_date = DATE(created_at)
          WHERE author IS NULL OR posted_date IS NULL
        SQL
      end
    end
  end
end
