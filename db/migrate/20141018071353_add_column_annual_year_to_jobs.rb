class AddColumnAnnualYearToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :annual_salary, :string
  end
end
