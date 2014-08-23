class TrendsController < ApplicationController
  def index

  	@inside_jobs = InsideJob.all
		
  end

  def analysis
		get_inside_all_jobs_url
  	get_all_inside_jobs_infomation

  	redirect_to "/trends/index"
  end


private


  def get_inside_all_jobs_url

  	(1..100).each do |page|
  		@inside_job_url_parser_service = InsideJobUrlParserService.new("http://jobs.inside.com.tw/jobs/page/#{page}")
  		@inside_job_url_parser_service.parse
		end 

  end

  def get_all_inside_jobs_infomation
  	@inside_jobs = InsideJob.select(:url).all
  	
  	@inside_jobs.each do |inside_job|
			inside_job_parser_serice = InsideJobParserService.new(inside_job.url)
  		inside_job_parser_serice.parse
  	end

  end

end


