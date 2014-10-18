class ChangeJobsTableColumns < ActiveRecord::Migration
  def change
  	add_column :jobs, :job_class, :string
  	add_column :jobs, :location, :string
  	add_column :jobs, :job_info, :text
  	add_column :jobs, :apply_info, :text
  end
end
