class CreateApplications < ActiveRecord::Migration[4.2]
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.integer :job_id
    end
  end
end
