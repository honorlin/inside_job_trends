class AddCompanyUrlToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :company_url, :string
  end
end
