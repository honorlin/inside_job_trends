class AddCompanyToInsideJobs < ActiveRecord::Migration
  def change
  	add_column :inside_jobs, :company, :string
  end
end
