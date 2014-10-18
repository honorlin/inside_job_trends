class RemoveJobsJobContent < ActiveRecord::Migration
  def change
  	remove_column :jobs, :job_content
  end
end
