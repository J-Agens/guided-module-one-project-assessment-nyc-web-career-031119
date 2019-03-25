class AddJobType < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :type, :string
  end
end
