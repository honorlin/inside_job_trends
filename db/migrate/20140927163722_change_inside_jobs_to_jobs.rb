class ChangeInsideJobsToJobs < ActiveRecord::Migration
  def change
  	rename_table :inside_jobs, :jobs
  end
end
