class RemoveZipCode < ActiveRecord::Migration[5.2]
  def change
    remove_column :jobs, :zip_code, :integers
  end
end
