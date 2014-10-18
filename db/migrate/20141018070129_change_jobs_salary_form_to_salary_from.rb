class ChangeJobsSalaryFormToSalaryFrom < ActiveRecord::Migration
  def change
  	rename_column :jobs, :salary_form, :salary_from
  end
end
