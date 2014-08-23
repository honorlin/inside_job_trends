class ChangeInsideJobsUrlToText < ActiveRecord::Migration
  def change
  	change_column :inside_jobs, :url, :text
  end
end
