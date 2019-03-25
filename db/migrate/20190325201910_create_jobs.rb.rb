class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.integer :zip_code
      t.string :description
      t.string :company
    end
  end
end
