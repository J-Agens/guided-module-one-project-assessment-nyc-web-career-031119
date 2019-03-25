class ChangeColumnNameInJobs < ActiveRecord::Migration[5.2]
  def change
    rename_column :jobs, :type, :job_type
  end
end
