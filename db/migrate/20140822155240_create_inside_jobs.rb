class CreateInsideJobs < ActiveRecord::Migration
  def change
    create_table :inside_jobs do |t|
      t.string :title
      t.string :salary_form
      t.string :salary_end
      t.string :url
      t.string :post_date
      t.string :effective_date

      t.timestamps
    end
  end
end
