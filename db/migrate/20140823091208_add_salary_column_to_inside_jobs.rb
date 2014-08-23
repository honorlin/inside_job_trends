class AddSalaryColumnToInsideJobs < ActiveRecord::Migration
  def change
  	add_column :inside_jobs, :salary, :string
  end
end
