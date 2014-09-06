class AnalysisService


	def self.perform
		AnalysisService::get_inside_all_jobs_url(3)
  	AnalysisService::get_all_inside_jobs_infomation
	end


private

  def self.get_inside_all_jobs_url(pages)
  	1.upto(pages.to_i) do |page|
  		@inside_job_url_parser_service = InsideJobUrlParserService.new("http://jobs.inside.com.tw/jobs/page/#{page}")
  		@inside_job_url_parser_service.parse
		end 
  end

  def self.get_all_inside_jobs_infomation
  	@inside_jobs = InsideJob.select(:url).where({ :title => nil })
  	@inside_jobs.each do |inside_job|
			inside_job_parser_serice = InsideJobParserService.new(inside_job.url)
  		inside_job_parser_serice.parse
    end
  end

end