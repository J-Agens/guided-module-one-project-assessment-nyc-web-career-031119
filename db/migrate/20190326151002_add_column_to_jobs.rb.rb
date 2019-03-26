class AddColumnToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :github_id, :string
  end
end
