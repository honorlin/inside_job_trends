class AddJobContentToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :job_content, :text
  end
end
