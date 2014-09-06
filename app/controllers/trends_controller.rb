class TrendsController < ApplicationController
  def index

  	@inside_jobs = InsideJob.where.not({ :company => "" }).order("post_date desc")
		
  end
end


