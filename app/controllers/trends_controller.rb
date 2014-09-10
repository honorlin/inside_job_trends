class TrendsController < ApplicationController
  def index


  	@inside_jobs = InsideJob.where.not("company LIKE ? OR company=''", "%茶%").order("post_date desc")
		#.not({ :company => "" })
  end
end


